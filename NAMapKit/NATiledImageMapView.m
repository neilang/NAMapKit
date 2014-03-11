//
//  NATiledImageMapView.m
//
//  Created by Daniel Doubrovkine on 3/10/14.
//
//

#import "NATiledImageMapView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NATiledImageMapView ()
@property (nonatomic, weak, readonly) NSObject <NATiledImageViewDataSource> *dataSource;
@property (nonatomic, readonly) NATiledImageView *tiledImageView;
@property (nonatomic, readonly) UIImageView *backgroundImageView;
@end

@implementation NATiledImageMapView

- (id)initWithFrame:(CGRect)frame tiledImageDataSource:(NSObject <NATiledImageViewDataSource> *)dataSource
{
    self = [super initWithFrame:frame];
    if (self) {
        _dataSource = dataSource;
        [self setupMap];
    }
    return self;
}

-(void)createImageView
{
    if (self.dataSource) {
        _tiledImageView = [[NATiledImageView alloc] initWithDataSource:self.dataSource];
        self.tiledImageView.displayTileBorders = self.displayTileBorders;
        [self addSubview:self.tiledImageView];
    }
}

-(void)setupMap
{
    if (self.dataSource) {
        [super setupMap];
        [self setMaxMinZoomScalesForCurrentBounds];
    }
}

-(void)setDisplayTileBorders:(BOOL)displayTileBorders
{
    if (self.tiledImageView) {
        self.tiledImageView.displayTileBorders = displayTileBorders;
    }
    _displayTileBorders = displayTileBorders;
}

- (void)setMaxMinZoomScalesForCurrentBounds
{
    CGSize boundsSize = self.bounds.size;
    CGSize imageSize = [self.dataSource imageSizeForImageView:nil];
    
    // calculate min/max zoomscale
    CGFloat xScale = boundsSize.width / imageSize.width;    // the scale needed to perfectly fit the image width-wise
    CGFloat yScale = boundsSize.height / imageSize.height;  // the scale needed to perfectly fit the image height-wise
    CGFloat minScale = MAX(xScale, yScale);                 // use minimum of these to allow the image to become fully visible
    
    CGFloat maxScale = 1.0;
    
    // don't let minScale exceed maxScale. (If the image is smaller than the screen, we don't want to force it to be zoomed.)
    if (minScale > maxScale) {
        minScale = maxScale;
    }
    
    self.maximumZoomScale = maxScale * 0.6;
    self.minimumZoomScale = minScale;
    
    self.originalSize = imageSize;
    self.contentSize = boundsSize;
}

- (void)zoomToFit:(BOOL)animate
{
    [self setZoomScale:self.minimumZoomScale animated:animate];
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [super scrollViewDidZoom:scrollView];
    NSInteger newZoomLevel = self.tiledImageView.currentZoomLevel;
    if (newZoomLevel != self.tileZoomLevel) {
        // TODO: delegate that zoom level has changed

        //
        // Repaint the map when the zoom level changes.
        //
        // NATiledImageView responds to rectangle repaint, figures out which tile to download from that rectangle and downloads tiles asynchronously.
        // Whenever it gets a tile invalidates the rectangle in which it think it is. However, if the tile level has changed, it's invalidating a
        // rectangle that is no longer relevant at the new tile level. This essentially does nothing. When you zoom in or out there're rectangles
        // that have been painted already from the very first rectangle repaint, but the tile never told it to repaint itself again (it did, but
        // at the wrong zoom level).
        //
        [self.tiledImageView setNeedsDisplay];
        _tileZoomLevel = self.tiledImageView.currentZoomLevel;
    }
}

- (void)setBackgroundImageURL:(NSURL *)backgroundImageURL
{
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.tiledImageView.frame];
    [self insertSubview:backgroundImageView belowSubview:self.tiledImageView];
    [backgroundImageView setImageWithURL:backgroundImageURL];
    _backgroundImageView = backgroundImageView;
    _backgroundImageURL = backgroundImageURL;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return self.tiledImageView;
}

-(CGPoint)coordinateFor:(CGPoint)point
{
    CGSize tiledSize = [self.dataSource imageSizeForImageView:self.tiledImageView];
    return CGPointMake(tiledSize.width * point.x, tiledSize.height - (tiledSize.height * point.y));
}

@end
