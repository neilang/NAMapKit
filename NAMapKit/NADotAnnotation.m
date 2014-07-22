//
//  NAAnnotation.m
//  NAMapKit
//
//  Created by Neil Ang on 21/07/10.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NADotAnnotation.h"
#import "NAMapView.h"

const CGFloat NAMapViewDotAnnotationDotRadius = 20.0f;
const CGFloat NAMapViewDotAnnotationDotOpacity = 0.5f;

@implementation NADotAnnotation

- (void)updatePosition
{
    if (!self.mapView) {
        return;
    }
    
    CGFloat radius = (self.radius ?: NAMapViewDotAnnotationDotRadius) * self.mapView.zoomScale;
    CGPoint point = [self.mapView zoomRelativePoint:self.point];
    point.x -= radius;
    point.y -= radius;
    self.view.layer.cornerRadius = radius;
    self.view.frame = CGRectMake(point.x, point.y, radius*2, radius*2);
}

- (UIView *)createViewOnMapView:(NAMapView *)mapView
{
    UIButton *view = [[UIButton alloc] init];
    view.alpha = self.opacity ?: NAMapViewDotAnnotationDotOpacity;
    view.backgroundColor = self.color ?: [UIColor redColor];
    [view addTarget:self action:@selector(tappedOnAnnotation:) forControlEvents:UIControlEventTouchDown];
    return view;
}

- (IBAction)tappedOnAnnotation:(id)sender
{
    if ([self.mapViewDelegate respondsToSelector:@selector(mapView:tappedOnAnnotation:)]) {
        [self.mapViewDelegate mapView:self.mapView tappedOnAnnotation:self];
    }
}

@end
