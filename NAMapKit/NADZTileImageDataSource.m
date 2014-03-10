//
//  NADZTileImageDataSource.m
//
//  Created by Daniel Doubrovkine on 3/10/14.
//
//

#import "NADZTileImageDataSource.h"
#import "NATiledImageView.h"

@implementation NADZTileImageDataSource

- (NSURL *)tiledImageView:(NATiledImageView *)imageView urlForImageTileAtLevel:(NSInteger)level x:(NSInteger)x y:(NSInteger)y
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@/%d/%d_%d.%@", self.tileBaseURL.absoluteString, level, x, y, self.tileFormat]];
}

- (UIImage *)tiledImageView:(NATiledImageView *)imageView imageTileForLevel:(NSInteger)level x:(NSInteger)x y:(NSInteger)y
{
    NSString *cachesDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask].lastObject relativePath];
    NSCharacterSet *charactersToRemove =[[NSCharacterSet alphanumericCharacterSet] invertedSet];
    NSString *url = [[self.tileBaseURL.absoluteString componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@"_"];
    NSString *filename = [NSString stringWithFormat:@"%@_%@_%@_%@.%@", url, @(level), @(x), @(y), self.tileFormat];
    NSString *path = [NSString stringWithFormat:@"%@/%@", cachesDirectory, filename];
    return [UIImage imageWithContentsOfFile:path];
}

- (void)tiledImageView:(NATiledImageView *)imageView didDownloadTiledImage:(UIImage *)image atURL:(NSURL *)url
{
    // TODO: we probably want a folder structure here
    NSString *cachesDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask].lastObject relativePath];
    NSCharacterSet *charactersToRemove =[[NSCharacterSet alphanumericCharacterSet] invertedSet];
    NSString *filename = [[url.absoluteString componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@"_"];
    NSString *path = [NSString stringWithFormat:@"%@/%@", cachesDirectory, filename];
    [UIImageJPEGRepresentation(image, 1.0) writeToFile:path atomically:YES];
}

- (CGSize)imageSizeForImageView:(NATiledImageView *)imageView
{
    return CGSizeMake(self.maxTiledWidth, self.maxTiledHeight);
}

- (CGSize)tileSizeForImageView:(NATiledImageView *)imageView
{
    return CGSizeMake(self.tileSize, self.tileSize);
}

- (NSInteger)minimumImageZoomLevelForImageView:(NATiledImageView *)imageView
{
    return self.minTileLevel;
}

- (NSInteger)maximumImageZoomLevelForImageView:(NATiledImageView *)imageView
{
    return self.maxTileLevel;
}

@end
