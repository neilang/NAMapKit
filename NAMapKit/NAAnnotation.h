//
// NAAnnotation.h
// NAMapKit
//
// Created by Neil Ang on 21/07/10.
// Copyright 2010 neilang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NAMapView;

@interface NAAnnotation : NSObject

@property (nonatomic, assign) CGPoint point;

+ (id)annotationWithPoint:(CGPoint)point;
- (id)initWithPoint:(CGPoint)point;
- (UIView *)addToMapView:(NAMapView *)mapView animated:(BOOL)animate;
- (void)removeFromMapView;

@end
