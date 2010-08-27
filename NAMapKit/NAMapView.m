//
// NAMapView.m
// NAMapKit
//
// Created by Neil Ang on 21/07/10.
// Copyright 2010 neilang.com. All rights reserved.
//

#import "NAMapView.h"
#import "NAPinAnnotationView.h"

@implementation NAMapView

@synthesize customMap      = _customMap;
@synthesize pinAnnotations = _pinAnnotations;
@synthesize callout        = _callout;
@synthesize orignalSize    = _orignalSize;

#pragma mark NAMapView class


- (void)awakeFromNib {
	self.delegate                       = self;
	self.showsHorizontalScrollIndicator = NO;
	self.showsVerticalScrollIndicator   = NO;
	self.pinAnnotations                 = [[NSMutableArray alloc] init];
}

- (void)displayMap:(UIImage *)map {
	if (!self.customMap) {
		UIImageView *imageView = [[UIImageView alloc] initWithImage:map];
		imageView.userInteractionEnabled = YES;
		self.customMap                   = imageView;
		[self addSubview:self.customMap];
		[imageView release];
	}	else {
		self.customMap.image = map;
	}

	// store orignal content size
	self.orignalSize = CGSizeMake(self.customMap.frame.size.width, self.customMap.frame.size.height);
	self.contentSize = self.orignalSize;
}

- (void)addAnnotation:(NAAnnotation *)annotation animated:(BOOL)animate {
	NAPinAnnotationView *pinAnnotation = [[NAPinAnnotationView alloc] initWithAnnotation:annotation onView:self animated:animate];

	[self.pinAnnotations addObject:pinAnnotation];
	[self addObserver:pinAnnotation forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
	[pinAnnotation release];
}

- (void)addAnnotations:(NSArray *)annotations animated:(BOOL)animate {
	for (NAAnnotation *annotation in annotations) {
		[self addAnnotation:annotation animated:animate];
	}
}

// The callout should belong to this class...
- (IBAction)showCallOut:(id)sender {
	for (NAPinAnnotationView *pin in self.pinAnnotations) {
		if (pin == sender) {
			if (!self.callout) {
				// create the callout
				self.callout = [[NACallOutView alloc] initWithAnnotation:pin.annotation onMap:self];
				[self addObserver:self.callout forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
				[self addSubview:self.callout];
			}	else {
				[self hideCallOut];
				[self.callout displayAnnotation:pin.annotation];
			}

			// centre the map
			[self centreOnPoint:pin.annotation.point animated:YES];

			break;
		}
	}
}

- (void)hideCallOut {
	self.callout.hidden = YES;
}

- (void)centreOnPoint:(CGPoint)point animated:(BOOL)animate {
	float x = (point.x * self.zoomScale) - (self.frame.size.width / 2.0f);
	float y = (point.y * self.zoomScale) - (self.frame.size.height / 2.0f);

	[self setContentOffset:CGPointMake(x, y) animated:animate];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if (!self.dragging) {
		[self hideCallOut];
	}

	[super touchesEnded:touches withEvent:event];
}

- (void)dealloc {
	// Remove observers
	if (self.callout) {
		[self removeObserver:self.callout forKeyPath:@"contentSize"];
	}

	for (NAAnnotation *annotation in self.pinAnnotations) {
		[self removeObserver:annotation forKeyPath:@"contentSize"];
	}

	[_pinAnnotations release];
	[_customMap release];
	[_callout release];
	[super dealloc];
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return self.customMap;
}

@end
