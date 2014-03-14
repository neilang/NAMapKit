//
//  NAMapView.h
//  NAMapKit
//
//  Created by Neil Ang on 21/07/10.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAAnnotation.h"
#import "NAMapViewDelegate.h"

// A zoomable, scrollable map with an image in the background.
@interface NAMapView : UIScrollView<UIScrollViewDelegate>

// Display a map with a background image.
-(void)displayMap:(UIImage *)map;
// Add an annotation.
-(void)addAnnotation:(NAAnnotation *)annotation animated:(BOOL)animate;
// Add a set of annotations.
-(void)addAnnotations:(NSArray *)annotations animated:(BOOL)animate;
// Remove an annotation.
-(void)removeAnnotation:(NAAnnotation *)annotation;
// Calculate the point on the screen from a point on the original image at the current zoom level.
-(CGPoint)zoomRelativePoint:(CGPoint)point;
// Select a particular annotation, notably centers the map on the annotation point.
-(void)selectAnnotation:(NAAnnotation *)annotation animated:(BOOL)animate;
// Center map on a given point.
-(void)centerOnPoint:(CGPoint)point animated:(BOOL)animate;
// Callback invoked to setup the map.
-(void)setupMap;

// Current map zoom level.
@property (nonatomic, readonly) CGFloat zoomLevel;
// Point on which to center the map by default.
@property (nonatomic, assign) CGPoint centerPoint;
// A delegate for receiving map notifications.
@property (nonatomic, weak) NSObject<NAMapViewDelegate> *mapViewDelegate;
// Size of the map, typically the full size of the background image.
@property (nonatomic, assign) CGSize originalSize;
// Amount by which to zoom in or zoom out with every double-tap, default is 1.5f.
@property (nonatomic, assign) CGFloat zoomStep;

@end


