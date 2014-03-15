//
//  NATiledImageMapView.m
//  NAMapKit
//
//  Created by Daniel Doubrovkine on 3/10/14.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NATiledImageMapView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NATiledImageMapView ()
@property (nonatomic, weak, readonly) NSObject <NATiledImageViewDataSource> *dataSource;
@property (nonatomic, readonly) NATiledImageView *imageView;
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
        _imageView = [[NATiledImageView alloc] initWithDataSource:self.dataSource];
        self.imageView.displayTileBorders = self.displayTileBorders;
        [self addSubview:self.imageView];
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
    self.imageView.displayTileBorders = displayTileBorders;
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
    self.backgroundImageView.frame = self.imageView.frame;
    [super scrollViewDidZoom:scrollView];
    NSInteger newZoomLevel = self.imageView.currentZoomLevel;
    if (newZoomLevel != self.tileZoomLevel) {
        // TODO: delegate that zoom level has changed
        _tileZoomLevel = self.imageView.currentZoomLevel;
    }
}

- (void)setBackgroundImageURL:(NSURL *)backgroundImageURL
{
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.imageView.frame];
    [self insertSubview:backgroundImageView belowSubview:self.imageView];
    [backgroundImageView setImageWithURL:backgroundImageURL];
    _backgroundImageView = backgroundImageView;
    _backgroundImageURL = backgroundImageURL;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return self.imageView;
}

@end
