//
// NAAnnotation.h
// NAMapKit
//
// Created by Neil Ang on 21/07/10.
// Copyright 2010 neilang.com. All rights reserved.
//

#import "NAAnnotation.h"

@implementation NAAnnotation

@synthesize point = _point;

+ (id)annotationWithPoint:(CGPoint)point{
    return [[[self class] alloc] initWithPoint:point];
}

- (id)initWithPoint:(CGPoint)point{
    self = [super init];
    if (self) {
        self.point = point;
    }
    return self;
}

-(UIView *)addToMapView:(NAMapView *)mapView animated:(BOOL)animate
{
    NSAssert(NO, @"Subclasses need to overwrite this method");
    return nil;
}

-(void)removeFromMapView
{
    NSAssert(NO, @"Subclasses need to overwrite this method");
}

@end
