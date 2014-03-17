//
//  NATiledImageMapView.h
//  NAMapKit
//
//  Created by Daniel Doubrovkine on 3/10/14.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NAMapView.h"
#import <ARTiledImageView/ARTiledImageViewDataSource.h>

/**
 *  A tiled image map.
 */
@interface NATiledImageMapView : NAMapView

- (id)initWithFrame:(CGRect)frame tiledImageDataSource:(NSObject <ARTiledImageViewDataSource> *)dataSource;

/// Zoom the map view to fit the current display.
- (void)zoomToFit:(BOOL)animate;

/// Display tile borders, usually for debugging purposes.
@property (readwrite, nonatomic, assign) BOOL displayTileBorders;

/// Set a background image, displayed while tiles are being downloaded.
@property (readwrite, nonatomic) NSURL *backgroundImageURL;

/// Set a background image, displayed while tiles are being downloaded.
@property (readwrite, nonatomic) UIImage *backgroundImage;

/// The current tile zoom level based on the DeepZoom algorithm.
@property (readonly, nonatomic, assign) NSInteger tileZoomLevel;

@end