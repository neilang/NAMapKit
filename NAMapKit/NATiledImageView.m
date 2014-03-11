//
//  NATiledImageView.m
//  Created by Orta Therox on 2014/01/29.
//

#import "NATiledImageView.h"
#import "NAAnnotation.h"
#import <QuartzCore/CATiledLayer.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface NATile : NSObject
@property (nonatomic, assign) CGRect tileRect;
@property (nonatomic, strong) UIImage *tileImage;
@end

@implementation NATile : NSObject

-(instancetype)initWithImage:(UIImage *)anImage rect:(CGRect)rect
{
    self = [super init];
    if (self == nil) return nil;
    
    _tileImage = anImage;
    _tileRect = rect;
    
    return self;
}
@end

// NATiledImageView responds to rectangle repaint, figures out which tile to download from that rectangle and downloads tiles asynchronously.
// It will cache images in SDWebCache and store images in local storage.
@interface NATiledImageView ()
@property (nonatomic, assign) NSInteger maxLevelOfDetail;
@property (atomic, strong, readonly) NSCache *tileCache;
@property (atomic, strong, readonly) NSMutableArray *operationsArray;
@end

@implementation NATiledImageView

-(id)initWithDataSource:(NSObject <NATiledImageViewDataSource> *)dataSource;
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _dataSource = dataSource;
        
        CATiledLayer *layer = (id)[self layer];
        layer.tileSize = [_dataSource tileSizeForImageView:self];
        
        NSInteger min = [_dataSource minimumImageZoomLevelForImageView:self];
        NSInteger max = [_dataSource maximumImageZoomLevelForImageView:self];
        layer.levelsOfDetail = max - min + 1;
        
        self.maxLevelOfDetail = max;
        
        CGSize imagesize = [dataSource imageSizeForImageView:self];
        self.frame = CGRectMake(0, 0, imagesize.width, imagesize.height);
        
        _tileCache = [[NSCache alloc] init];
        _displayTileBorders = NO;
    }
    return self;
}

// http://openradar.appspot.com/8503490

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Get the scale from the context by getting the current transform matrix, then asking for its "a" component, which is one of the two scale components.
    // We need to also ask for the "d" component as it might not be precisely the same as the "a" component, even at the "same" scale.
    
    CGFloat _scaleX = CGContextGetCTM(context).a;
    CGFloat _scaleY = CGContextGetCTM(context).d;
    
    CATiledLayer *tiledLayer = (CATiledLayer *)[self layer];
    CGSize tileSize = tiledLayer.tileSize;
    
    // Even at scales lower than 100%, we are drawing into a rect in the coordinate system of the full
    // image. One tile at 50% covers the width (in original image coordinates) of two tiles at 100%.
    // So at 50% we need to stretch our tiles to double the width and height; at 25% we need to stretch
    // them to quadruple the width and height; and so on.
    
    // (Note that this means that we are drawing very blurry images as the scale gets low. At 12.5%,
    // our lowest scale, we are stretching about 6 small tiles to fill the entire original image area.
    // But this is okay, because the big blurry image we're drawing here will be scaled way down before
    // it is displayed.)
    
    tileSize.width /= _scaleX;
    tileSize.height /= -_scaleY;
    
    NSInteger firstCol = floor(CGRectGetMinX(rect) / tileSize.width);
    NSInteger lastCol = floor((CGRectGetMaxX(rect)-1) / tileSize.width);
    NSInteger firstRow = floorf(CGRectGetMinY(rect) / tileSize.height);
    NSInteger lastRow = floorf((CGRectGetMaxY(rect)-1) / tileSize.height);

    NSInteger level = self.maxLevelOfDetail + roundf(log2f(_scaleX));
    _currentZoomLevel = level;
    
    NSMutableArray *requestURLs = [NSMutableArray array];
    for (NSInteger row = firstRow; row <= lastRow; row++) {
        for (NSInteger col = firstCol; col <= lastCol; col++) {
            
            CGRect tileRect = CGRectMake(tileSize.width * col, tileSize.height * row, tileSize.width, tileSize.height);
            BOOL canUseTiledURLs = [self.dataSource respondsToSelector:@selector(tiledImageView:urlForImageTileAtLevel:x:y:)];
            
            UIImage *tileImage = [self.dataSource tiledImageView:self imageTileForLevel:level x:col y:row];
            NSURL *tileURL = canUseTiledURLs ? [self.dataSource tiledImageView:self urlForImageTileAtLevel:level x:col y:row] : nil;
            
            NATile *tile = [self.tileCache objectForKey:[tileURL absoluteString]];
            if (tile && !tile.tileImage) {
                tile.tileImage = tileImage;
            }
            
            if (canUseTiledURLs && !tile) {
                tileRect = CGRectIntersection(self.bounds, tileRect);
                tile = [[NATile alloc] initWithImage:nil rect:tileRect];
                [self.tileCache setObject:tile forKey:[tileURL absoluteString] cost:level];
                [requestURLs addObject:tileURL];
            }
            
            if (tile.tileImage) {
                [tile.tileImage drawInRect:tile.tileRect blendMode:kCGBlendModeNormal alpha:1];
                if (self.displayTileBorders) {
                    [[UIColor greenColor] set];
                    CGContextSetLineWidth(context, 6.0);
                    CGContextStrokeRect(context, tileRect);
                }
            }
        }
    }
    
    if (requestURLs.count && self && [self isKindOfClass:[NATiledImageView class]]) {
        [self setTileImagesWithURLs:[NSArray arrayWithArray:requestURLs]];
    }
}

+(Class)layerClass
{
    return [CATiledLayer class];
}

-(void)setContentScaleFactor:(CGFloat)contentScaleFactor
{
    [super setContentScaleFactor:1.f];
}

-(void)setTileImagesWithURLs:(NSArray *)arrayOfURLs
{
    __weak typeof(self) wself = self;
    
    for(NSURL *tileURL in arrayOfURLs) {
        
        id<SDWebImageOperation> operation = nil;
        operation = [SDWebImageManager.sharedManager downloadWithURL:tileURL options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
            if (!wself || !finished ) return;
            
            if (error){
                // Ideally we want to mke sure this doesn't happen multiple times
                [wself performSelector:_cmd withObject:arrayOfURLs afterDelay:1];
                return;
            }
            
            void (^block)(void) = ^{
                __strong typeof(wself) sself = wself;
                if (!sself) return;
                
                if (image) {
                    NATile *tile = [sself.tileCache objectForKey:[tileURL absoluteString]];
                    if (!tile) return;
                    
                    tile.tileImage = image;
                    [sself setNeedsDisplayInRect:tile.tileRect];
                    
                    // Overwrite the existing object in cache now that we have a real cost
                    NSInteger cost = image.size.height * image.size.width * image.scale;
                    [sself.tileCache setObject:tile forKey:[tileURL absoluteString] cost:cost];
                    
                    if([sself.dataSource respondsToSelector:@selector(tiledImageView:didDownloadTiledImage:atURL:)]){
                        [sself.dataSource tiledImageView:self didDownloadTiledImage:image atURL:tileURL];
                    }
                }
            };
            
            if ([NSThread isMainThread]) {
                block();
            } else {
                dispatch_sync(dispatch_get_main_queue(), block);
            }
        }];
        
        [_operationsArray addObject:operation];
    }
    
}

-(void)dealloc
{
    [self cancelConcurrentDownloads];
    [_tileCache removeAllObjects];
}

-(void)cancelConcurrentDownloads
{
    for(id<SDWebImageOperation> operation in _operationsArray) {
        if (operation) {
            [operation cancel];
        }
    }
    _operationsArray = nil;
}

@end