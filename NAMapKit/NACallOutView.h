//
// NACallOutView.h
// NAMapKit
//
// Created by Neil Ang on 23/07/10.
// Copyright 2010 neilang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAAnnotation.h"
#import "NAMapView.h"

@interface NACallOutView : UIView

- (id)initOnMapView:(NAMapView *)mapView;
- (void)setAnnotation:(NAAnnotation *)annotation;

@end
