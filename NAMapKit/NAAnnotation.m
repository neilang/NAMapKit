//
// NAAnnotation.h
// NAMapKit
//
// Created by Neil Ang on 21/07/10.
// Copyright 2010 neilang.com. All rights reserved.
//

#import "NAAnnotation.h"
#import "NAMapView.h"

@interface NAAnnotation ()
@property (nonatomic, readonly) NAMapView *mapView;
@end

@implementation NAAnnotation

@synthesize view = _view;
@synthesize mapView = _mapView;

@synthesize point = _point;

+ (id)annotationWithPoint:(CGPoint)point{
    return [[[self class] alloc] initWithPoint:point];
}

- (id)initWithPoint:(CGPoint)point{
    self = [super init];
    if (self) {
        _point = point;
        _mapView = nil;
    }
    return self;
}

-(void)addToMapView:(NAMapView *)mapView animated:(BOOL)animate
{
    [mapView addSubview:self.view];
    [mapView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)removeFromMapView
{
    [self.view removeFromSuperview];
    [self.mapView removeObserver:_view forKeyPath:@"contentSize"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"contentSize"]) {
        [self updatePosition];
	}
}

-(void)updatePosition{

}

@end
