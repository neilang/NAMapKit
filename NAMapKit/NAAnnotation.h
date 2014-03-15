//
//  NAAnnotation.h
//  NAMapKit
//
//  Created by Neil Ang on 21/07/10.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NAMapViewDelegate.h"

@class NAMapView;

/**
 *  An annotation is a point on a map.
 */
@interface NAAnnotation : NSObject

// Point on the map.
@property (nonatomic, assign) CGPoint point;
// Associated view, displayed on an NAMapView.
@property (nonatomic, readonly) UIView *view;

// Create an annotation at a given point.
+(id)annotationWithPoint:(CGPoint)point;
// Create an annotation at a given point.
-(id)initWithPoint:(CGPoint)point;
// Callback invoked when adding an annotation to a map view.
-(void)addToMapView:(NAMapView *)mapView animated:(BOOL)animate;
// Remove this annotation from its map view.
-(void)removeFromMapView;
// Update the annotation position when zooming in or out.
-(void)updatePosition;
// Override to return a custom view when the annotation is being added to a map view.
-(UIView *)createViewOnMapView:(NAMapView *)mapView;

// A delegate to invoke map-specific events.
@property (nonatomic, weak) NSObject<NAMapViewDelegate> *mapViewDelegate;
// Map view to which the annotation currently belongs.
@property (nonatomic, readonly) NAMapView *mapView;

@end
