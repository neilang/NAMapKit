//
//  NAMapView.m
//  NAMapKit
//
//  Created by Neil Ang on 21/07/10.
//  Copyright 2010 neilang.com. All rights reserved.
//

#import "NAMapView.h"
#import "NAPinAnnotationView.h"

@implementation NAMapView

@synthesize customMap;
@synthesize orignalSize = _orignalSize;

#pragma mark NAMapView class


- (void)awakeFromNib{
	self.delegate = self;
}

-(void)displayMap:(UIImage *)map{
	if(!self.customMap){
		UIImageView * imageView = [[UIImageView alloc] initWithImage:map];
		imageView.userInteractionEnabled = YES;
		self.customMap = imageView;
		[self addSubview:self.customMap];
		[imageView release];
	}
	else {
		self.customMap.image = map;
	}
	
	// store orignal content size
	self.orignalSize = CGSizeMake(self.customMap.frame.size.width, self.customMap.frame.size.height);
	self.contentSize = self.orignalSize;
}

-(void)addAnnotation:(NAAnnotation *)annotation{
	NAPinAnnotationView * pinAnnotation = [[NAPinAnnotationView alloc] initWithAnnotation:annotation];
	[self addSubview:pinAnnotation];
	[self addObserver:pinAnnotation forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
	[pinAnnotation release];
}

-(void)hideAnnotationCallOuts{
	for(UIView *subview in self.subviews){
		if ([subview class] == [NAPinAnnotationView class]) {
			NAPinAnnotationView * pinAnnotation = (NAPinAnnotationView *) subview;
			[pinAnnotation hideCallOut];
		}
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {	
	if (!self.dragging){
		[self hideAnnotationCallOuts];
	}
	[super touchesEnded:touches withEvent:event];
}

- (void)dealloc {
	[customMap release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return self.customMap;
}

@end
