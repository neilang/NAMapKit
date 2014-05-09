//
//  NAPinAnnotationView.h
//  NAMapKit
//
//  Created by Neil Ang on 21/07/10.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAPinAnnotation.h"
#import "NAMapView.h"

/**
 *  A pin annotation view the behaves like a button.
 */
@interface NAPinAnnotationView : UIButton

/// Associated NAPinAnnotation.
@property (readwrite, nonatomic, weak) NAPinAnnotation *annotation;
/// Animate the pin.
@property (readwrite, nonatomic, assign) BOOL animating;

/// Create a view for a pin annotation on a map.
- (id)initWithAnnotation:(NAPinAnnotation *)annotation onMapView:(NAMapView *)mapView;
/// Update the pin position when the map is zoomed in or zoomed out.
- (void)updatePosition;

@end
