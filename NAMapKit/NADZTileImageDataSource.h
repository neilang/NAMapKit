//
//  NADZTileImageDataSource.h
//  NAMapKit
//
//  Created by Daniel Doubrovkine on 3/10/14.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NATiledImageViewDataSource.h"

/**
 *  An implementation of the NATiledImageViewDataSource protocol that supports retrieving tiles from a remote HTTP server.
 */
@interface NADZTileImageDataSource : NSObject<NATiledImageViewDataSource>

// Maximum height of the tiled image.
@property (nonatomic) NSInteger maxTiledHeight;
// Maximim width of the tiled image.
@property (nonatomic) NSInteger maxTiledWidth;
// Maximum tile width or height. Tiles are square except on edges.
@property (nonatomic) NSInteger tileSize;
// The base URL from which to retrieve tiles.
@property (nonatomic) NSURL *tileBaseURL;
// Tile format, eg. "jpg".
@property (nonatomic, copy) NSString *tileFormat;
// Maximum tile level.
@property (nonatomic) NSInteger maxTileLevel;
// Minimum tile level.
@property (nonatomic) NSInteger minTileLevel;

- (NSURL *)tiledImageView:(NATiledImageView *)imageView urlForImageTileAtLevel:(NSInteger)level x:(NSInteger)x y:(NSInteger)y;
- (UIImage *)tiledImageView:(NATiledImageView *)imageView imageTileForLevel:(NSInteger)level x:(NSInteger)x y:(NSInteger)y;
- (void)tiledImageView:(NATiledImageView *)imageView didDownloadTiledImage:(UIImage *)image atURL:(NSURL *)url;
- (CGSize)imageSizeForImageView:(NATiledImageView *)imageView;
- (CGSize)tileSizeForImageView:(NATiledImageView *)imageView;
- (NSInteger)minimumImageZoomLevelForImageView:(NATiledImageView *)imageView;
- (NSInteger)maximumImageZoomLevelForImageView:(NATiledImageView *)imageView;

@end
