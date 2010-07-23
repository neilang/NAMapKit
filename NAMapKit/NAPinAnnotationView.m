//
//  NAPinAnnotationView.m
//  NAMapKit
//
//  Created by Neil Ang on 21/07/10.
//  Copyright 2010 neilang.com. All rights reserved.
//

#import "NAPinAnnotationView.h"
#import "NAMapView.h"

#define RED_PIN @"pinRed.png"

@implementation NAPinAnnotationView

- (id)initWithPoint:(CGPoint)point {
	_origin = point;
	
	CGRect frame = CGRectMake(0, 0, 0, 0);
	if ((self = [super initWithFrame:frame])) {
		self.frame = [self frameForPoint:point];
		// Initialization code
		[self setImage:[UIImage imageNamed:RED_PIN] forState:UIControlStateNormal];
	}
	return self;
}

// Make frame
- (CGRect)frameForPoint:(CGPoint)point{
	// The pin image size is (32, 39)
	// however the pin point is at (8, 35)
	
	float x = point.x - 8.0;
	float y = point.y - 35.0;
	
	return CGRectMake(x, y, 32, 39);
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
	if([keyPath isEqual:@"contentSize"]){
		NAMapView * mapView = (NAMapView *) object;
		float width  = (mapView.contentSize.width / mapView.orignalSize.width) * _origin.x;
		float height = (mapView.contentSize.height / mapView.orignalSize.height) * _origin.y;
		self.frame = [self frameForPoint:CGPointMake(width, height)]; //CGRectMake(width, height, 32, 39);
	}
}

- (void)dealloc {
    [super dealloc];
}


@end
