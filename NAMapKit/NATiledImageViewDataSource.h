//
//  NATiledImageDataSource.h
//
//  Created by Daniel Doubrovkine on 3/10/14.
//
//

@class NATiledImageView;

@protocol NATiledImageViewDataSource
- (UIImage *)tiledImageView:(NATiledImageView *)imageView imageTileForLevel:(NSInteger)level x:(NSInteger)x y:(NSInteger)y;
- (CGSize)tileSizeForImageView:(NATiledImageView *)imageView;
- (CGSize)imageSizeForImageView:(NATiledImageView *)imageView;
- (NSInteger)minimumImageZoomLevelForImageView:(NATiledImageView *)imageView;
- (NSInteger)maximumImageZoomLevelForImageView:(NATiledImageView *)imageView;

@optional
- (NSURL *)tiledImageView:(NATiledImageView *)imageView urlForImageTileAtLevel:(NSInteger)level x:(NSInteger)x y:(NSInteger)y;
- (void)tiledImageView:(NATiledImageView *)imageView didDownloadTiledImage:(UIImage *)image atURL:(NSURL *)url;
@end

