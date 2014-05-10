//
//  NAPinAnnotation.m
//  NAMapKit
//
//  Created by Neil Ang on 21/07/10.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NAPinAnnotation.h"
#import "NAPinAnnotationView.h"

const CGFloat NAMapViewPinAnimationDuration = 0.5f;

@interface NAPinAnnotation ()
@property (nonatomic, readonly, weak) NAPinAnnotationView *view;
@end

@implementation NAPinAnnotation

- (id)initWithPoint:(CGPoint)point
{
    self = [super initWithPoint:point];
    if (self) {
        self.color = NAPinColorRed;
        self.title = nil;
        self.subtitle = nil;
        self.rightCalloutAccessoryView = nil;
    }
    return self;
}

- (UIView *)createViewOnMapView:(NAMapView *)mapView
{
    return [[NAPinAnnotationView alloc] initWithAnnotation:self onMapView:mapView];
}

- (void)addToMapView:(NAMapView *)mapView animated:(BOOL)animate
{
    [super addToMapView:mapView animated:animate];

    if (animate) {
        self.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0.0f, -self.view.center.y);
    }

    [mapView addSubview:self.view];

    if (animate) {
        self.view.animating = YES;
        [UIView animateWithDuration:NAMapViewPinAnimationDuration animations:^{
            self.view.transform = CGAffineTransformIdentity;
        } completion:^ (BOOL finished) {
            self.view.animating = NO;
        }];
    }
}

- (void)updatePosition
{
    [self.view updatePosition];
}

@end
