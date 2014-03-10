//
// NAAnnotation.h
// NAMapKit
//
// Created by Neil Ang on 21/07/10.
// Copyright 2010 neilang.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NAMapViewDelegate.h"

@class NAMapView;

@interface NAAnnotation : NSObject

@property (nonatomic, assign) CGPoint point;
@property (nonatomic, readonly) UIView *view;

+(id)annotationWithPoint:(CGPoint)point;
-(id)initWithPoint:(CGPoint)point;
-(void)addToMapView:(NAMapView *)mapView animated:(BOOL)animate;
-(void)removeFromMapView;
-(void)updatePosition;
-(UIView *)createViewOnMapView:(NAMapView *)mapView;

@property (nonatomic, weak) NSObject<NAMapViewDelegate> *mapViewDelegate;

@end
