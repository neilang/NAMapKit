//
//  NAAnnotation.m
//  NAMapKit
//
//  Created by Neil Ang on 21/07/10.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NAAnnotation.h"
#import "NAMapView.h"

const CGFloat NAMapViewAnnotationDotRadius = 20.0f;
const CGFloat NAMapViewAnnotationDotOpacity = 0.5f;

@implementation NAAnnotation

+ (id)annotationWithPoint:(CGPoint)point{
    return [[[self class] alloc] initWithPoint:point];
}

- (id)initWithPoint:(CGPoint)point{
    self = [super init];
    if (self) {
        _point = point;
    }
    return self;
}

- (void)addToMapView:(NAMapView *)mapView animated:(BOOL)animate
{
    NSAssert(!self.mapView, @"Annotation already added to map.");

    if (!self.view) {
        _view = [self createViewOnMapView:mapView];
    }

    [mapView addSubview:self.view];
    [mapView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    _mapView = mapView;

    _mapViewDelegate = mapView.mapViewDelegate;

    [self updatePosition];
}

- (void)removeFromMapView
{
    [self.view removeFromSuperview];
    [self.mapView removeObserver:self forKeyPath:@"contentSize"];
    _mapView = nil;
    _view = nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"contentSize"]) {
        [self updatePosition];
	}
}

- (void)updatePosition {
    if (! self.mapView) return;
    CGPoint point = [self.mapView zoomRelativePoint:self.point];
    self.view.frame = (CGRect) {
        .origin = point,
        .size = self.view.bounds.size
    };
}

- (UIView *)createViewOnMapView:(NAMapView *)mapView
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return nil;
}

- (IBAction)tappedOnAnnotation:(id)sender
{
    [self.mapViewDelegate mapView:self.mapView tappedOnAnnotation:self];
}

@end
