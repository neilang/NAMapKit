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

@interface NAPinAnnotation ()
@property(nonatomic) UIView *view;
@end

@implementation NAPinAnnotation

@synthesize view = _view;
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
        self.view = nil;
        self.rightCalloutAccessoryView = nil;
    }
    return self;
}

-(void)addToMapView:(NAMapView *)mapView animated:(BOOL)animate
{
    NSAssert(!self.view, @"Annotation already added to view.");

    NAPinAnnotationView *annontationView = [[NAPinAnnotationView alloc] initWithAnnotation:self onMapView:mapView];
    _view = annontationView;
    [super addToMapView:mapView animated:animate];
    
    if(animate){
        annontationView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0.0f, -annontationView.center.y);
    }
    
    [mapView addSubview:annontationView];
    
    if(animate){
        annontationView.animating = YES;
        [UIView animateWithDuration:NA_PIN_ANIMATION_DURATION animations:^{
            annontationView.transform = CGAffineTransformIdentity;
        } completion:^ (BOOL finished) {
          annontationView.animating = NO;
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