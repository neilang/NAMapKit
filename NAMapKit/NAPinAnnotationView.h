//
// NAPinAnnotationView.h
// NAMapKit
//
// Created by Neil Ang on 21/07/10.
// Copyright 2010 neilang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAAnnotation.h"
#import "NAMapView.h"

@interface NAPinAnnotationView : UIButton

- (id)initWithAnnotation:(NAAnnotation *)annotation onMapView:(NAMapView *)mapView;

@property (nonatomic, retain) NAAnnotation *annotation;
@property (nonatomic, assign) BOOL          animating;

@end
