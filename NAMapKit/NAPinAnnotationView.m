//
// NAPinAnnotationView.m
// NAMapKit
//
// Created by Neil Ang on 21/07/10.
// Copyright 2010 neilang.com. All rights reserved.
//

#import "NAPinAnnotationView.h"
#import "NAMapView.h"
#import "NACallOutView.h"
#import <QuartzCore/QuartzCore.h>

#define RED_PIN             @"pinRed.png"
#define PIN_WIDTH           32.0
#define PIN_HEIGHT          39.0
#define PIN_POINT_X         8.0
#define PIN_POINT_Y         35.0
#define CALLOUT_OFFSET_X    7.0
#define CALLOUT_OFFSET_Y    5.0

@implementation NAPinAnnotationView

@synthesize annotation = _annotation;

- (id)initWithAnnotation:(NAAnnotation *)annotation onView:(NAMapView *)mapView animated:(BOOL)animate {
	CGRect frame = CGRectMake(0, 0, 0, 0); // TODO: remove this

	if ((self = [super initWithFrame:frame])) {
		self.annotation = annotation;
		self.frame      = [self frameForPoint:self.annotation.point];

		[self setImage:[UIImage imageNamed:RED_PIN] forState:UIControlStateNormal];

		[self addTarget:mapView action:@selector(showCallOut:) forControlEvents:UIControlEventTouchDown];

		// if no title is set, the pin can't be tapped
		if (!self.annotation.title) {
			[self setImage:[UIImage imageNamed:RED_PIN] forState:UIControlStateDisabled];
			self.enabled = self.annotation.title ? YES : NO;
		}

		[mapView addSubview:self];

		if (animate) {
			CABasicAnimation *pindrop = [CABasicAnimation animationWithKeyPath:@"position.y"];
			pindrop.duration       = 0.5f;
			pindrop.fromValue      = [NSNumber numberWithFloat:self.center.y - mapView.frame.size.height];
			pindrop.toValue        = [NSNumber numberWithFloat:self.center.y];
			pindrop.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
			[self.layer addAnimation:pindrop forKey:@"pindrop"];
		}
	}

	return self;
}

- (CGRect)frameForPoint:(CGPoint)point {
	// Calculate the offset for the pin point
	float x = point.x - PIN_POINT_X;
	float y = point.y - PIN_POINT_Y;

	return CGRectMake(round(x), round(y), PIN_WIDTH, PIN_HEIGHT);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqual:@"contentSize"]) {
		NAMapView *mapView = (NAMapView *)object;
		float      width   = (mapView.contentSize.width / mapView.orignalSize.width) * self.annotation.point.x;
		float      height  = (mapView.contentSize.height / mapView.orignalSize.height) * self.annotation.point.y;
		self.frame = [self frameForPoint:CGPointMake(width, height)];
	}
}

- (void)dealloc {
	[_annotation release];
	[super dealloc];
}

@end
