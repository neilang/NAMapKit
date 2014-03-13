//
//  NATiledImageMapView.h
//
//  Created by Daniel Doubrovkine on 3/10/14.
//
//

#import "NAMapView.h"
#import "NATiledImageView.h"

@interface NATiledImageMapView : NAMapView

- (id)initWithFrame:(CGRect)frame tiledImageDataSource:(NSObject <NATiledImageViewDataSource> *)dataSource;

// Zoom the map view to fit the current display.
- (void)zoomToFit:(BOOL)animate;

// Calculates a coordinate for an annotation within the map's coordinate system, ie. within the entire full size image.
- (CGPoint)coordinateFor:(CGPoint)point;

// Display tile borders, usually for debugging purposes.
@property (readwrite, nonatomic, assign) BOOL displayTileBorders;

// Set a background image, displayed while tiles are being downloaded.
@property (readwrite, nonatomic) NSURL *backgroundImageURL;

// Current map tile zoom level.
@property (readonly, nonatomic, assign) NSInteger tileZoomLevel;

@end