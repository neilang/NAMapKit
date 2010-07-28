//
//  NAPinAnnotationView.m
//  NAMapKit
//
//  Created by Neil Ang on 21/07/10.
//  Copyright 2010 neilang.com. All rights reserved.
//

#import "NAPinAnnotationView.h"
#import "NAMapView.h"
#import "NACallOutView.h"

#define RED_PIN @"pinRed.png"
#define PIN_WIDTH   32.0
#define PIN_HEIGHT  39.0
#define PIN_POINT_X 8.0
#define PIN_POINT_Y 35.0
#define CALLOUT_OFFSET_X 7.0
#define CALLOUT_OFFSET_Y 5.0

@implementation NAPinAnnotationView

@synthesize annotation  = _annotation;
@synthesize callOutView = _callOutView;

- (id)initWithAnnotation:(NAAnnotation *)annotation {
	CGRect frame = CGRectMake(0, 0, 0, 0); // TODO: remove this
	if ((self = [super initWithFrame:frame])) {
		self.annotation = annotation;
		self.frame = [self frameForPoint:self.annotation.point];
		[self setImage:[UIImage imageNamed:RED_PIN] forState:UIControlStateNormal];
		
		[self addTarget:self action:@selector(showCallOut:) forControlEvents:UIControlEventTouchDown];
		
		// if no title is set, the pin can't be tapped
		if(!self.annotation.title){
			[self setImage:[UIImage imageNamed:RED_PIN] forState:UIControlStateDisabled];
			self.enabled = self.annotation.title ? YES : NO;
		}
	}
	return self;
}

- (IBAction)showCallOut:(id)sender{
	
	// hide all other callouts
	if([self.superview class] == [NAMapView class]){
		NAMapView *mapView = (NAMapView *)self.superview;
		[mapView hideAnnotationCallOuts];
	}
	
	if(!self.callOutView){
		CGPoint point = CGPointMake(CALLOUT_OFFSET_X, CALLOUT_OFFSET_Y);
		self.callOutView = [NACallOutView addCalloutView:self point:point annotation:self.annotation]; // TODO: do this better
	}
	// TODO: show callout... with animation
	self.callOutView.hidden = NO;
}

- (void)hideCallOut{
	// TODO: hide the callout... with animation
	// TODO: remove the subview to save memory
	if(self.callOutView){
		//[self.callOutView removeFromSuperview];
		//self.callOutView = nil;
		self.callOutView.hidden = YES;
	}
}

- (CGRect)frameForPoint:(CGPoint)point{
	// Calculate the offset for the pin point
	float x = point.x - PIN_POINT_X;
	float y = point.y - PIN_POINT_Y;
	
	return CGRectMake(x, y, PIN_WIDTH, PIN_HEIGHT);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
	if([keyPath isEqual:@"contentSize"]){
		NAMapView * mapView = (NAMapView *) object;
		float width  = (mapView.contentSize.width / mapView.orignalSize.width) * self.annotation.point.x;
		float height = (mapView.contentSize.height / mapView.orignalSize.height) * self.annotation.point.y;
		self.frame = [self frameForPoint:CGPointMake(width, height)];
	}
}

- (void)dealloc {
    [super dealloc];
}


@end
