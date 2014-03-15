//
//  NATiledImageMapView.h
//  NAMapKit
//
//  Created by Daniel Doubrovkine on 3/10/14.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NAMapView.h"
#import "NATiledImageView.h"

/**
 *  A tiled image map.
 */
@interface NATiledImageMapView : NAMapView

- (id)initWithFrame:(CGRect)frame tiledImageDataSource:(NSObject <NATiledImageViewDataSource> *)dataSource;

// Zoom the map view to fit the current display.
- (void)zoomToFit:(BOOL)animate;

// Display tile borders, usually for debugging purposes.
@property (readwrite, nonatomic, assign) BOOL displayTileBorders;

// Set a background image, displayed while tiles are being downloaded.
@property (readwrite, nonatomic) NSURL *backgroundImageURL;

// Current map tile zoom level.
@property (readonly, nonatomic, assign) NSInteger tileZoomLevel;

@end