//
//  NAPinAnnotationMapView.m
//  NAMapKit
//
//  Created by Daniel Doubrovkine on 3/7/14.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NAPinAnnotationMapView.h"

const CGFloat NAMapViewAnnotationCalloutAnimationDuration = 0.1f;

@interface NAPinAnnotationMapView()

@property (nonatomic, strong) NAPinAnnotationCallOutView *calloutView;

- (IBAction)showCallOut:(id)sender;
- (void)hideCallOut;
@end

@implementation NAPinAnnotationMapView

- (void)setupMap
{
    [super setupMap];

    _calloutView = [[NAPinAnnotationCallOutView alloc] initOnMapView:self];
    [self addSubview:self.calloutView];
}

- (void)addAnnotation:(NAAnnotation *)annotation animated:(BOOL)animate
{
    [super addAnnotation:annotation animated:animate];
    if ([annotation.view isKindOfClass:NAPinAnnotationView.class]) {
        NAPinAnnotationView *annotationView = (NAPinAnnotationView *) annotation.view;
        [annotationView addTarget:self action:@selector(showCallOut:) forControlEvents:UIControlEventTouchDown];
    }
    [self bringSubviewToFront:self.calloutView];
}

- (void)selectAnnotation:(NAAnnotation *)annotation animated:(BOOL)animate
{
    [self hideCallOut];
    if([annotation isKindOfClass:NAPinAnnotation.class]) {
        [self showCalloutForAnnotation:(NAPinAnnotation *)annotation animated:animate];
    }
}

- (void)removeAnnotation:(NAAnnotation *)annotation
{
    [self hideCallOut];
    [super removeAnnotation:annotation];
}

- (IBAction)showCallOut:(id)sender
{
    if([sender isKindOfClass:[NAPinAnnotationView class]]) {
        NAPinAnnotationView *annontationView = (NAPinAnnotationView *)sender;
        
        if ([self.mapViewDelegate respondsToSelector:@selector(mapView:tappedOnAnnotation:)]) {
            [self.mapViewDelegate mapView:self tappedOnAnnotation:annontationView.annotation];
        }
        
        [self showCalloutForAnnotation:annontationView.annotation animated:YES];
    }
}

- (void)showCalloutForAnnotation:(NAPinAnnotation *)annotation animated:(BOOL)animated
{
    [self hideCallOut];

    self.calloutView.annotation = annotation;

    [self centerOnPoint:annotation.point animated:animated];

    CGFloat animationDuration = animated ? NAMapViewAnnotationCalloutAnimationDuration : 0.0f;

    self.calloutView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4f, 0.4f);
    self.calloutView.hidden = NO;

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:animationDuration animations:^{
        weakSelf.calloutView.transform = CGAffineTransformIdentity;
    }];
}

- (void)hideCallOut
{
	self.calloutView.hidden = YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (!self.dragging) {
		[self hideCallOut];
	}

	[super touchesEnded:touches withEvent:event];
}

- (void)updatePositions
{
    [self.calloutView updatePosition];
    [super updatePositions];
}

@end
