//
// NAAnnotation.h
// NAMapKit
//
// Created by Neil Ang on 21/07/10.
// Copyright 2010 neilang.com. All rights reserved.
//

#import "NAAnnotation.h"

@implementation NAAnnotation

@synthesize point    = _point;
@synthesize color    = _color;
@synthesize title    = _title;
@synthesize subtitle = _subtitle;
@synthesize rightCalloutAccessoryView = _rightCalloutAccessoryView;

+ (id)annotationWithPoint:(CGPoint)point{
    return [[[self class] alloc] initWithPoint:point];
}

- (id)initWithPoint:(CGPoint)point{
    self = [super init];
    if (self) {
        self.point    = point;
        self.color    = NAPinColorRed;
        self.title    = nil;
        self.subtitle = nil;
        self.rightCalloutAccessoryView = nil;
    }
    return self;
}


@end
