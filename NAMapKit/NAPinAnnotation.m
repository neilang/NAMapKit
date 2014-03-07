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
@property(nonatomic) NAMapView *mapView;
@end

@implementation NAPinAnnotation

@synthesize color = _color;
@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize rightCalloutAccessoryView = _rightCalloutAccessoryView;
@synthesize view = _view;
@synthesize mapView = _mapView;

-(id)initWithPoint:(CGPoint)point{
    self = [super initWithPoint:point];
    if (self) {
        self.color = NAPinColorRed;
        self.title = nil;
        self.subtitle = nil;
        self.view = nil;
        self.rightCalloutAccessoryView = nil;
        self.mapView = nil;
    }
    return self;
}

-(UIView *)addToMapView:(NAMapView *)mapView animated:(BOOL)animate
{
    NSAssert(!_view && !_mapView, @"Annotation already added to view.");
    _mapView = mapView;
    
    NAPinAnnotationView *annontationView = [[NAPinAnnotationView alloc] initWithAnnotation:self onMapView:mapView];
    _view = annontationView;
    
    [mapView addSubview:_view];
    
    [mapView addObserver:annontationView forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
    if(animate){
        annontationView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0.0f, -annontationView.center.y);
    }
    
    [mapView addSubview:annontationView];
    
    if(animate){
        annontationView.animating = YES;
        [UIView animateWithDuration:NA_PIN_ANIMATION_DURATION animations:^{
            annontationView.transform = CGAffineTransformIdentity;
        }
                         completion:^ (BOOL finished) {
                             annontationView.animating = NO;
                         }];
    }
    
    return annontationView;
}

-(void)removeFromMapView
{
    NSAssert(_view, @"Annotation not added to view.");
    [_view removeFromSuperview];
    [_mapView removeObserver:_view forKeyPath:@"contentSize"];
}

@end

#undef NA_PIN_ANIMATION_DURATION