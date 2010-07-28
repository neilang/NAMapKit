//
//  NAAnnotation.m
//  NAMapKit
//
//  Created by Neil Ang on 21/07/10.
//  Copyright 2010 neilang.com. All rights reserved.
//

#import "NAAnnotation.h"


@implementation NAAnnotation

@synthesize point    = _point;
@synthesize title    = _title;
@synthesize subtitle = _subtitle;
@synthesize rightCalloutAccessoryView = _rightCalloutAccessoryView;

+(id)annotationWithPoint:(CGPoint)point {
	return [[[[self class] alloc] initWithPoint:point] autorelease];
}

-(id)initWithPoint:(CGPoint)point{
	self = [super init];
	if(nil != self){
		self.point = point;
	}
	return self;
}

@end
