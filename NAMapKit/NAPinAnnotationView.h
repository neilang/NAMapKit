//
// NAPinAnnotationView.h
// NAMapKit
//
// Created by Neil Ang on 21/07/10.
// Copyright 2010 neilang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAPinAnnotation.h"
#import "NAMapView.h"

@interface NAPinAnnotationView : UIButton

@property (nonatomic, retain) NAPinAnnotation *annotation;
@property (nonatomic, assign) BOOL animating;

-(id)initWithAnnotation:(NAPinAnnotation *)annotation onMapView:(NAMapView *)mapView;
-(void)updatePosition;

@end
