//
//  NATiledImageDataSource.h
//  NAMapKit
//
//  Created by Daniel Doubrovkine on 3/10/14.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

@class NATiledImageView;

/**
 *  An NATiledMapView data source.
 */
@protocol NATiledImageViewDataSource

/**
 *  Return a UIImage for a tile, if available, for example from local storage.
 *
 *  @param imageView Tiled image view.
 *  @param level     Zoom level.
 *  @param x         X coordinate of the tile.
 *  @param y         Y coordinate of the tile.
 *
 *  @return A UIImage of the tile, when available, otherwise nil.
 */
- (UIImage *)tiledImageView:(NATiledImageView *)imageView imageTileForLevel:(NSInteger)level x:(NSInteger)x y:(NSInteger)y;

/**
 *  Tile size.
 *
 *  @param imageView Tiled image view.
 *
 *  @return CGSize of a single tile.
 */
- (CGSize)tileSizeForImageView:(NATiledImageView *)imageView;

/**
 *  Size of the full, zoomed in, tiled image.
 *
 *  @param imageView Tiled image view.
 *
 *  @return CGSize of a full image.
 */
- (CGSize)imageSizeForImageView:(NATiledImageView *)imageView;

/**
 *  Minimum zoom level.
 *
 *  @param imageView Tiled image view.
 *
 *  @return Minimum zoom level.
 */
- (NSInteger)minimumImageZoomLevelForImageView:(NATiledImageView *)imageView;

/**
 *  Maximum zoom level.
 *
 *  @param imageView Tiled image view.
 *
 *  @return Maximum zoom level.
 */
- (NSInteger)maximumImageZoomLevelForImageView:(NATiledImageView *)imageView;

@optional

/**
 *  Return an URL for an image tile.
 *
 *  @param imageView Tiled image view.
 *  @param level     Zoom level.
 *  @param x         X coordinate of the tile.
 *  @param y         Y coordinate of the tile.
 *
 *  @return An NSURL where the tile can be downloaded from.
 */
- (NSURL *)tiledImageView:(NATiledImageView *)imageView urlForImageTileAtLevel:(NSInteger)level x:(NSInteger)x y:(NSInteger)y;

/**
 *  Callback when an image tile has been downloaded. Use this method to cache tiles in local storage, for example.
 *
 *  @param imageView Tiled image view.
 *  @param image     UIImage of the tile.
 *  @param url       URL from which the tile has been downloaded.
 */
- (void)tiledImageView:(NATiledImageView *)imageView didDownloadTiledImage:(UIImage *)image atURL:(NSURL *)url;

@end

