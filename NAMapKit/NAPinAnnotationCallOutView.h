//
//  NAPinAnnotationCallOutView.h
//  NAMapKit
//
//  Created by Neil Ang on 23/07/10.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAPinAnnotation.h"
#import "NAMapView.h"

/**
 *  A callout view displayed wiht NAPinAnnotation.
 */
@interface NAPinAnnotationCallOutView : UIView

/// Create a new callout view on a map.
- (id)initOnMapView:(NAMapView *)mapView;

/// Recalculate position on map according to zoom level.
- (void)updatePosition;

/// Pin annotation.
@property(readwrite, nonatomic, strong) NAPinAnnotation *annotation;

@end
