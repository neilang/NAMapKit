//
//  NACallOutView.m
//  NAMapKit
//
//  Created by Neil Ang on 23/07/10.
//  Copyright 2010 neilang.com. All rights reserved.
//

#import "NACallOutView.h"
#import <QuartzCore/QuartzCore.h>
#import "NAMapView.h"

#define CALLOUT_HEIGHT 57
#define CALLOUT_LEFT_IMAGE_WIDTH 17
#define CALLOUT_RIGHT_IMAGE_WIDTH 17
#define CALLOUT_MAX_WIDTH 220
#define CALLOUT_ANCHOR_WIDTH 41
#define CALLOUT_ANCHOR_HEIGHT 70
#define CALLOUT_ALPHA 1

#define CALLOUT_LEFT_IMAGE @"callout_left.png"
#define CALLOUT_RIGHT_IMAGE @"callout_right.png"
#define CALLOUT_ANCHOR_IMAGE @"callout_anchor.png"
#define CALLOUT_BG_IMAGE @"callout_bg.png"

#define TITLE_STANDALONE_TOP_OFFSET 14.0
#define TITLE_STANDALONE_LABEL_HEIGHT 22.0
#define TITLE_STANDALONE_FONT_SIZE 18.0

#define TITLE_TOP_OFFSET 4.0
#define TITLE_LABEL_HEIGHT 20.0
#define TITLE_FONT_SIZE 17.0

#define SUBTITLE_TOP_OFFSET 0.0+TITLE_LABEL_HEIGHT
#define SUBTITLE_LABEL_HEIGHT 25.0
#define SUBTITLE_FONT_SIZE 11.0

#define RIGHT_ACCESSORY_LEFT_OFFSET 1.0
#define RIGHT_ACCESSORY_TOP_OFFSET 11.0


@implementation NACallOutView

@synthesize annotation = _annotation;
@synthesize mapView = _mapView;

static UIImage *CALLOUT_LEFT_CAP;
static UIImage *CALLOUT_RIGHT_CAP;
static UIImage *CALLOUT_BG;
static UIImage *CALLOUT_ANCHOR;

-(float)calculateCentreWidth{
	float width = CALLOUT_ANCHOR_WIDTH;
	
	// Only checking the standalone title size as it *should* be bigger
	CGSize titleSize = [self.annotation.title sizeWithFont:[UIFont boldSystemFontOfSize:TITLE_STANDALONE_FONT_SIZE] constrainedToSize:CGSizeMake(CALLOUT_MAX_WIDTH, TITLE_STANDALONE_LABEL_HEIGHT) lineBreakMode:UILineBreakModeTailTruncation];
	if(titleSize.width > width) width = titleSize.width;
	
	if(self.annotation.subtitle){
		CGSize subtitleSize = [self.annotation.subtitle sizeWithFont:[UIFont boldSystemFontOfSize:SUBTITLE_FONT_SIZE] constrainedToSize:CGSizeMake(CALLOUT_MAX_WIDTH, SUBTITLE_LABEL_HEIGHT) lineBreakMode:UILineBreakModeTailTruncation];
		if(subtitleSize.width > width) width = subtitleSize.width;
	}
	
	if(self.annotation.rightCalloutAccessoryView){
		// Add on width for the button
		width += self.annotation.rightCalloutAccessoryView.frame.size.width + RIGHT_ACCESSORY_LEFT_OFFSET;
	}
	
	if(width > CALLOUT_MAX_WIDTH){
		return CALLOUT_MAX_WIDTH;
	}
	
	return width;
}

-(float)calculateViewWidth{
	return CALLOUT_LEFT_IMAGE_WIDTH + CALLOUT_RIGHT_IMAGE_WIDTH + [self calculateCentreWidth];
}

-(void)setFramePositionForPoint:(CGPoint)point{

	float positionX = (self.mapView.contentSize.width / self.mapView.orignalSize.width) * self.annotation.point.x;
	float positionY = (self.mapView.contentSize.height / self.mapView.orignalSize.height) * self.annotation.point.y;
	
	float calloutWidth = [self calculateViewWidth];
	float x = positionX - (calloutWidth / 2) - 1; // TODO: refactor offsets
	float y = positionY - CALLOUT_ANCHOR_HEIGHT - 25.0;
	
	// rounding the position removes blur...
	self.frame = CGRectMake(round(x), round(y), calloutWidth, CALLOUT_ANCHOR_HEIGHT);
	
	return;
}

-(void)setBackgroundImages{
	if (!CALLOUT_LEFT_CAP)  CALLOUT_LEFT_CAP  = [UIImage imageNamed:CALLOUT_LEFT_IMAGE];
	if (!CALLOUT_RIGHT_CAP) CALLOUT_RIGHT_CAP = [UIImage imageNamed:CALLOUT_RIGHT_IMAGE];
	if (!CALLOUT_ANCHOR)    CALLOUT_ANCHOR    = [UIImage imageNamed:CALLOUT_ANCHOR_IMAGE];
	if (!CALLOUT_BG)        CALLOUT_BG        = [[UIImage imageNamed:CALLOUT_BG_IMAGE] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
	
	float centreWidth = [self calculateCentreWidth];
	float centreOffsetWidth = (centreWidth-CALLOUT_ANCHOR_WIDTH) / 2;	
	
	UIImageView * leftCap = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CALLOUT_LEFT_IMAGE_WIDTH, CALLOUT_HEIGHT)];
	leftCap.image = CALLOUT_LEFT_CAP;
	leftCap.alpha = CALLOUT_ALPHA;
	[self addSubview:leftCap];
	[leftCap release];
	
	UIImageView * rightCap = [[UIImageView alloc] initWithFrame:CGRectMake(CALLOUT_LEFT_IMAGE_WIDTH + centreWidth, 0, CALLOUT_RIGHT_IMAGE_WIDTH, CALLOUT_HEIGHT)];
	rightCap.image = CALLOUT_RIGHT_CAP;
	rightCap.alpha = CALLOUT_ALPHA;
	[self addSubview:rightCap];
	[rightCap release];
	
	UIImageView * anchor = [[UIImageView alloc] initWithFrame:CGRectMake(CALLOUT_LEFT_IMAGE_WIDTH+centreOffsetWidth, 0, CALLOUT_ANCHOR_WIDTH, CALLOUT_ANCHOR_HEIGHT)];
	anchor.image = CALLOUT_ANCHOR;
	anchor.alpha = CALLOUT_ALPHA;
	[self addSubview:anchor];
	[anchor release];

	if(centreWidth > CALLOUT_ANCHOR_WIDTH){
		CGRect leftFrame  = CGRectMake(CALLOUT_LEFT_IMAGE_WIDTH, 0, centreOffsetWidth, CALLOUT_HEIGHT);
		CGRect rightFrame = CGRectMake(CALLOUT_LEFT_IMAGE_WIDTH+centreWidth-centreOffsetWidth, 0, centreOffsetWidth, CALLOUT_HEIGHT);
		
		UIImageView * leftBG = [[UIImageView alloc] initWithFrame:leftFrame];
		leftBG.image = CALLOUT_BG;
		leftBG.alpha = CALLOUT_ALPHA;
		[self addSubview:leftBG];
		[leftBG release];

		UIImageView * rightBG = [[UIImageView alloc] initWithFrame:rightFrame];
		rightBG.image = CALLOUT_BG;
		rightBG.alpha = CALLOUT_ALPHA;
		[self addSubview:rightBG];
		[rightBG release];
	}
	
}

-(void)setLabels{	
	float titleTopOffset   = TITLE_STANDALONE_TOP_OFFSET;
	float titleLabelHeight = TITLE_STANDALONE_LABEL_HEIGHT;
	float titleFontSize    = TITLE_STANDALONE_FONT_SIZE;
	
	float labelWidth = [self calculateCentreWidth];
	
	if (self.annotation.rightCalloutAccessoryView){
		float x = labelWidth - self.annotation.rightCalloutAccessoryView.frame.size.width + CALLOUT_LEFT_IMAGE_WIDTH + RIGHT_ACCESSORY_LEFT_OFFSET;
		labelWidth -= self.annotation.rightCalloutAccessoryView.frame.size.width;
		self.annotation.rightCalloutAccessoryView.frame = CGRectMake(x, RIGHT_ACCESSORY_TOP_OFFSET, self.annotation.rightCalloutAccessoryView.frame.size.width, self.annotation.rightCalloutAccessoryView.frame.size.height);
		
		[self addSubview:self.annotation.rightCalloutAccessoryView];
	}
	
	if(self.annotation.subtitle){
		titleTopOffset   = TITLE_TOP_OFFSET;
		titleLabelHeight = TITLE_LABEL_HEIGHT;
		titleFontSize    = TITLE_FONT_SIZE;
		
		UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CALLOUT_LEFT_IMAGE_WIDTH, SUBTITLE_TOP_OFFSET, labelWidth, SUBTITLE_LABEL_HEIGHT)];
		subtitleLabel.textColor = [UIColor whiteColor];
		subtitleLabel.backgroundColor = [UIColor clearColor];
		subtitleLabel.font = [UIFont systemFontOfSize:SUBTITLE_FONT_SIZE];
		subtitleLabel.text = self.annotation.subtitle;
		[self addSubview:subtitleLabel];
		[subtitleLabel release];
	}
	
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CALLOUT_LEFT_IMAGE_WIDTH, titleTopOffset, labelWidth, titleLabelHeight)];
	titleLabel.textColor = [UIColor whiteColor];
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.font = [UIFont boldSystemFontOfSize:titleFontSize];
	titleLabel.text = self.annotation.title;
	[self addSubview:titleLabel];
	[titleLabel release];

}

- (id)initWithAnnotation:(NAAnnotation *)annotation onMap:(NAMapView *)mapView{
	if ((self = [super initWithFrame:CGRectMake(0, 0, 0, 0)])) {
		self.mapView = mapView;
		
		self.backgroundColor = [UIColor clearColor];
		self.opaque = false;
		
		[self displayAnnotation:annotation];	
	}
	
	return self;
}

-(void)displayAnnotation:(NAAnnotation *)annotation{
	
	// Remove all subviews
	for (UIView * view in self.subviews) {
		[view removeFromSuperview];
	}
	
	self.annotation = annotation;
	
	[self setFramePositionForPoint:annotation.point];
	[self setBackgroundImages];
	[self setLabels];
	
	self.hidden = NO;
	
	// Animate 
	CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	scale.duration = 0.1f;
	scale.autoreverses = NO;
	scale.removedOnCompletion = YES;
	scale.fromValue = [NSNumber numberWithFloat:0.0f];
	scale.toValue = [NSNumber numberWithFloat:1.0f];
	scale.fillMode = kCAFillModeForwards;
	
	[self.layer addAnimation:scale forKey:@"scale"];
	
}

// observe resizing
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
	if([keyPath isEqual:@"contentSize"]){
		[self setFramePositionForPoint:self.annotation.point];
	}
}

- (void)dealloc {
	[_mapView release];
	[_annotation release];
    [super dealloc];
}


@end
