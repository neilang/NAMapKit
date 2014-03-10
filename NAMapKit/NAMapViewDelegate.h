//
//  NAMapViewDelegate.h
//  Pods
//
//  Created by Daniel Doubrovkine on 3/10/14.
//
//

@class NAMapView;
@class NAAnnotation;

@protocol NAMapViewDelegate
@optional
- (void)mapView:(NAMapView *)mapView tappedOnAnnotation:(NAAnnotation *)annotation;
- (void)mapView:(NAMapView *)mapView hasChangedZoomLevel:(CGFloat)level;
@end
