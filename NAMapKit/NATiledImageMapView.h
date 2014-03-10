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
- (void)zoomToFit:(BOOL)animate;

@property (readwrite, nonatomic, assign) BOOL displayTileBorders;
@property (readwrite, nonatomic) NSURL *backgroundImageURL;

@end