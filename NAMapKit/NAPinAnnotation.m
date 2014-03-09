//
// NAAnnotation.h
// NAMapKit
//
// Created by Neil Ang on 21/07/10.
// Copyright 2010 neilang.com. All rights reserved.
//

#import "NAPinAnnotation.h"
#import "NAPinAnnotationView.h"

#define NA_PIN_ANIMATION_DURATION     0.5f
#define NA_CALLOUT_ANIMATION_DURATION 0.1f

@implementation NAPinAnnotation

@synthesize color = _color;
@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize rightCalloutAccessoryView = _rightCalloutAccessoryView;

-(id)initWithPoint:(CGPoint)point{
    self = [super initWithPoint:point];
    if (self) {
        self.color = NAPinColorRed;
        self.title = nil;
        self.subtitle = nil;
        self.rightCalloutAccessoryView = nil;
    }
    return self;
}

-(UIView *)createViewOnMapView:(NAMapView *)mapView
{
    return [[NAPinAnnotationView alloc] initWithAnnotation:self onMapView:mapView];
}

-(void)addToMapView:(NAMapView *)mapView animated:(BOOL)animate
{
    [super addToMapView:mapView animated:animate];
    
    NAPinAnnotationView *annotationView = (NAPinAnnotationView *) self.view;

    if(animate){
        annotationView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0.0f, -annotationView.center.y);
    }
    
    [mapView addSubview:annotationView];
    
    if(animate){
        annotationView.animating = YES;
        [UIView animateWithDuration:NA_PIN_ANIMATION_DURATION animations:^{
            annotationView.transform = CGAffineTransformIdentity;
        } completion:^ (BOOL finished) {
          annotationView.animating = NO;
        }];
    }
}

-(void)updatePosition
{
    NAPinAnnotationView *annontationView = (NAPinAnnotationView *)self.view;
    [annontationView updatePosition];
}

@end

#undef NA_PIN_ANIMATION_DURATION