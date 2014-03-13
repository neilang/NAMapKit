//
//  NADZTileImageDataSource.h
//
//  Created by Daniel Doubrovkine on 3/10/14.
//
//

#import <Foundation/Foundation.h>
#import "NATiledImageViewDataSource.h"

@interface NADZTileImageDataSource : NSObject<NATiledImageViewDataSource>

@property (nonatomic) NSInteger maxTiledHeight;
@property (nonatomic) NSInteger maxTiledWidth;
@property (nonatomic) NSInteger tileSize;
@property (nonatomic) NSURL *tileBaseURL;
@property (nonatomic, copy) NSString *tileFormat;
@property (nonatomic) NSInteger maxTileLevel;
@property (nonatomic) NSInteger minTileLevel;

- (NSURL *)tiledImageView:(NATiledImageView *)imageView urlForImageTileAtLevel:(NSInteger)level x:(NSInteger)x y:(NSInteger)y;
- (UIImage *)tiledImageView:(NATiledImageView *)imageView imageTileForLevel:(NSInteger)level x:(NSInteger)x y:(NSInteger)y;
- (void)tiledImageView:(NATiledImageView *)imageView didDownloadTiledImage:(UIImage *)image atURL:(NSURL *)url;
- (CGSize)imageSizeForImageView:(NATiledImageView *)imageView;
- (CGSize)tileSizeForImageView:(NATiledImageView *)imageView;
- (NSInteger)minimumImageZoomLevelForImageView:(NATiledImageView *)imageView;
- (NSInteger)maximumImageZoomLevelForImageView:(NATiledImageView *)imageView;

@end
