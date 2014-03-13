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
    NSString *filename = [NSString stringWithFormat:@"%@/%@/%@_%@.%@", url, @(level), @(x), @(y), self.tileFormat];
    NSString *path = [NSString stringWithFormat:@"%@/%@", cachesDirectory, filename];
    return [UIImage imageWithContentsOfFile:path];
}

- (void)tiledImageView:(NATiledImageView *)imageView didDownloadTiledImage:(UIImage *)image atURL:(NSURL *)url
{
    NSString *cachesDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask].lastObject relativePath];
    NSCharacterSet *charactersToRemove =[[NSCharacterSet alphanumericCharacterSet] invertedSet];
    NSArray *urlParts = [url.absoluteString componentsSeparatedByCharactersInSet:charactersToRemove];
    NSString *filename = [NSString stringWithFormat:@"%@_%@.%@", urlParts[urlParts.count - 3], urlParts[urlParts.count - 2], urlParts[urlParts.count - 1]];
    NSString *directory = [[urlParts subarrayWithRange:NSMakeRange(0, urlParts.count - 4)] componentsJoinedByString:@"_"];
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@", cachesDirectory, directory, urlParts[urlParts.count - 4]];
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *pathWithFilename = [NSString stringWithFormat:@"%@/%@", path, filename];
    [UIImageJPEGRepresentation(image, 1.0) writeToFile:pathWithFilename atomically:YES];
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
