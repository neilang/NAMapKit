//
// NAAnnotation.h
// NAMapKit
//
// Created by Neil Ang on 21/07/10.
// Copyright 2010 neilang.com. All rights reserved.
//

#import "NAAnnotation.h"
#import "NAMapView.h"

const CGFloat dotRadius = 10.0f;
const CGFloat dotOpacity = 0.5f;

@interface NAAnnotation ()
@property (nonatomic, readonly) NAMapView *mapView;
@end

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

-(void)addToMapView:(NAMapView *)mapView animated:(BOOL)animate
{
    NSAssert(!self.mapView, @"Annotation already added to map.");

    if (!self.view) {
        _view = [self createViewOnMapView:mapView];
    }
    
    [mapView addSubview:self.view];
    [mapView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    _mapView = mapView;

    [self updatePosition];
}

-(void)removeFromMapView
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

-(void)updatePosition{
    CGPoint point = [self.mapView zoomRelativePoint:self.point];
    self.view.frame = (CGRect){
        .origin = point,
        .size = self.view.frame.size
    };
}

-(UIView *)createViewOnMapView:(NAMapView *)mapView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,dotRadius*2,dotRadius*2)];
    view.alpha = dotOpacity;
    view.layer.cornerRadius = dotRadius;
    view.backgroundColor = [UIColor redColor];
    [self updatePosition];
    return view;
}

@end
