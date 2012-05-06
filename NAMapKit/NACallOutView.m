//
// NACallOutView.h
// NAMapKit
//
// Created by Neil Ang on 23/07/10.
// Copyright 2010 neilang.com. All rights reserved.
//

#import "NACallOutView.h"

#define NA_TITLE_STANDALONE_LABEL_HEIGHT    22.0f
#define NA_TITLE_STANDALONE_FONT_SIZE       18.0f
#define NA_TITLE_STANDALONE_TOP_OFFSET      14.0
#define NA_TITLE_TOP_OFFSET                 4.0
#define NA_TITLE_LABEL_HEIGHT               20.0
#define NA_TITLE_FONT_SIZE                  17.0
#define NA_SUBTITLE_TOP_OFFSET              0.0 + NA_TITLE_LABEL_HEIGHT
#define NA_SUBTITLE_FONT_SIZE               11.0
#define NA_SUBTITLE_LABEL_HEIGHT            25.0
#define NA_RIGHT_ACCESSORY_LEFT_OFFSET      2.0
#define NA_RIGHT_ACCESSORY_TOP_OFFSET       9.0
#define NA_ANCHOR_Y_OFFSET                  26.0
#define NA_CALLOUT_IMAGE_LEFT               @"callout_left.png"
#define NA_CALLOUT_IMAGE_RIGHT              @"callout_right.png"
#define NA_CALLOUT_IMAGE_ANCHOR             @"callout_anchor.png"
#define NA_CALLOUT_IMAGE_BG                 @"callout_bg.png"


@interface NACallOutView()

@property (nonatomic, strong) UIImageView *calloutLeftCapView;
@property (nonatomic, strong) UIImageView *calloutRightCapView;
@property (nonatomic, strong) UIImageView *calloutAnchorView;
@property (nonatomic, strong) UIImageView *calloutLeftCenterView;
@property (nonatomic, strong) UIImageView *calloutRightCenterView;
@property (nonatomic, strong) UILabel     *subtitleLabel;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, assign) CGPoint      point;
@property (nonatomic, assign) CGPoint      position;
@property (nonatomic, weak)   NAMapView   *mapView;

-(void)updatePosition;
-(void)positionView:(UIView *)view posX:(float)x;
-(void)positionView:(UIView *)view posX:(float)x width:(float)width;

@end

@implementation NACallOutView

@synthesize calloutLeftCapView     = _calloutLeftCapView;
@synthesize calloutRightCapView    = _calloutRightCapView;
@synthesize calloutAnchorView      = _calloutAnchorView;
@synthesize calloutLeftCenterView  = _calloutLeftCenterView;
@synthesize calloutRightCenterView = _calloutRightCenterView;
@synthesize subtitleLabel          = _subtitleLabel;
@synthesize titleLabel             = _titleLabel;
@synthesize point                  = _point;
@synthesize mapView                = _mapView;
@synthesize position               = _position;

- (id)initOnMapView:(NAMapView *)mapView {
    self = [super init];
    if (self) {        
        UIImage *calloutBG                 = [[UIImage imageNamed:NA_CALLOUT_IMAGE_BG] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        self.calloutLeftCapView            = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NA_CALLOUT_IMAGE_LEFT]];
        self.calloutRightCapView           = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NA_CALLOUT_IMAGE_RIGHT]];
        self.calloutAnchorView             = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NA_CALLOUT_IMAGE_ANCHOR]];
        self.calloutLeftCenterView         = [[UIImageView alloc] initWithImage:calloutBG];
        self.calloutRightCenterView        = [[UIImageView alloc] initWithImage:calloutBG];
        self.subtitleLabel                 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.subtitleLabel.textColor       = [UIColor whiteColor];
        self.subtitleLabel.backgroundColor = [UIColor clearColor];
        self.subtitleLabel.font            = [UIFont systemFontOfSize:NA_SUBTITLE_FONT_SIZE];
        self.titleLabel                    = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.backgroundColor    = [UIColor clearColor];
        self.titleLabel.textColor          = [UIColor whiteColor];
        self.mapView                       = mapView;
        self.hidden                        = YES;
    }
    return self;
}

- (void)setAnnotation:(NAAnnotation *)annotation{
        
    // --- RESET ---
    
    self.titleLabel.text    = @"";
    self.subtitleLabel.text = @"";
    self.point              = CGPointZero;
    
    for (UIView *view in self.subviews) {
		[view removeFromSuperview];
	}
    
    self.position = annotation.point;
    
    float leftCapWidth  = self.calloutLeftCapView.image.size.width;
    float rightCapWidth = self.calloutRightCapView.image.size.width;
    float anchorWidth   = self.calloutAnchorView.image.size.width;
    float anchorHeight  = self.calloutAnchorView.image.size.height;
    float maxWidth      = self.mapView.frame.size.width;
    
    // --- FRAME --- 
    
    float middleWidth = anchorWidth;
    
    if (annotation.subtitle) {
        CGSize subtitleSize = [annotation.subtitle sizeWithFont:[UIFont boldSystemFontOfSize:NA_SUBTITLE_FONT_SIZE] constrainedToSize:CGSizeMake(maxWidth, NA_SUBTITLE_LABEL_HEIGHT) lineBreakMode:UILineBreakModeTailTruncation];
        
        middleWidth = MAX(subtitleSize.width, middleWidth);
        
        CGSize titleSize  = [annotation.title sizeWithFont:[UIFont boldSystemFontOfSize:NA_TITLE_FONT_SIZE] constrainedToSize:CGSizeMake(maxWidth, NA_TITLE_LABEL_HEIGHT) lineBreakMode:UILineBreakModeTailTruncation];
        
        middleWidth = MAX(titleSize.width, middleWidth);
    }
    else{
        CGSize titleSize  = [annotation.title sizeWithFont:[UIFont boldSystemFontOfSize:NA_TITLE_STANDALONE_FONT_SIZE] constrainedToSize:CGSizeMake(maxWidth, NA_TITLE_STANDALONE_LABEL_HEIGHT) lineBreakMode:UILineBreakModeTailTruncation];
        
        middleWidth = MAX(titleSize.width, middleWidth);
    }
    
    if (annotation.rightCalloutAccessoryView) {
		middleWidth += annotation.rightCalloutAccessoryView.frame.size.width + NA_RIGHT_ACCESSORY_LEFT_OFFSET;
	}
    
    middleWidth = MIN(maxWidth, middleWidth);
    
    float totalWidth  = middleWidth + leftCapWidth + rightCapWidth;
    
    self.point = annotation.point;
        
    self.frame = CGRectMake(0.0f, 0.0f, totalWidth, anchorHeight);
    [self updatePosition];

    // --- IMAGEVIEWS ---
    
    float centreOffsetWidth = (middleWidth - anchorWidth) / 2.0f;
    
    [self positionView:self.calloutLeftCapView posX:0.0f];
    [self positionView:self.calloutRightCapView posX:(totalWidth - rightCapWidth)];
    [self positionView:self.calloutAnchorView posX:(leftCapWidth + centreOffsetWidth)];
    
    [self addSubview:self.calloutLeftCapView];
    [self addSubview:self.calloutRightCapView];
    [self addSubview:self.calloutAnchorView];
    
    if (middleWidth > anchorWidth) {
        [self positionView:self.calloutLeftCenterView posX:leftCapWidth width:centreOffsetWidth];
        [self positionView:self.calloutRightCenterView posX:(leftCapWidth + middleWidth - centreOffsetWidth) width:centreOffsetWidth];
        
        [self addSubview:self.calloutLeftCenterView];
        [self addSubview:self.calloutRightCenterView];
	}
    
    float labelWidth = middleWidth;
    
    // --- RIGHT ACCESSORY VIEW ---
    
    if (annotation.rightCalloutAccessoryView) {
        float accesoryWidth = annotation.rightCalloutAccessoryView.frame.size.width;
        float x = middleWidth - accesoryWidth + leftCapWidth + NA_RIGHT_ACCESSORY_LEFT_OFFSET;
        
        CGRect frame = annotation.rightCalloutAccessoryView.frame;
        frame.origin.x = x;
        frame.origin.y = NA_RIGHT_ACCESSORY_TOP_OFFSET;
        annotation.rightCalloutAccessoryView.frame = frame;
        
        [self addSubview:annotation.rightCalloutAccessoryView];
        labelWidth -= accesoryWidth;
	}
    
    
    // --- LABELS ---
    
    float titleTopOffset   = NA_TITLE_STANDALONE_TOP_OFFSET;
	float titleLabelHeight = NA_TITLE_STANDALONE_LABEL_HEIGHT;
	float titleFontSize    = NA_TITLE_STANDALONE_FONT_SIZE;
    
    
    // --- SUBTITLE ---
    
    if (annotation.subtitle) {
		titleTopOffset       = NA_TITLE_TOP_OFFSET;
		titleLabelHeight     = NA_TITLE_LABEL_HEIGHT;
		titleFontSize        = NA_TITLE_FONT_SIZE;        
        self.subtitleLabel.text  = annotation.subtitle;
        self.subtitleLabel.frame = CGRectMake(leftCapWidth, NA_SUBTITLE_TOP_OFFSET, labelWidth, NA_SUBTITLE_LABEL_HEIGHT);
        [self addSubview:self.subtitleLabel];
	}
    
    // --- TITLE ---
    
    self.titleLabel.text  = annotation.title;
    self.titleLabel.font  = [UIFont boldSystemFontOfSize:titleFontSize];
    self.titleLabel.frame = CGRectMake(leftCapWidth, titleTopOffset, labelWidth, titleLabelHeight);
    
    [self addSubview:self.titleLabel];
        
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"contentSize"]) {
        [self updatePosition];
	}
}

#pragma - Private helpers

-(void)updatePosition{
    CGPoint point = [self.mapView zoomRelativePoint:self.position];
    float xPos = point.x - (self.frame.size.width / 2.0f);
    float yPos = point.y - (self.frame.size.height) - NA_ANCHOR_Y_OFFSET;
    self.frame = CGRectMake(floor(xPos), yPos, self.frame.size.width, self.frame.size.height);
}

-(void)positionView:(UIView *)view posX:(float)x width:(float)width{
    CGRect frame     = view.frame;
    frame.origin.x   = x;
    frame.size.width = width;
    view.frame       = frame;
}

-(void)positionView:(UIView *)view posX:(float)x{
    [self positionView:view posX:x width:view.frame.size.width];
}

@end

#undef NA_TITLE_STANDALONE_LABEL_HEIGHT
#undef NA_TITLE_STANDALONE_FONT_SIZE
#undef NA_TITLE_STANDALONE_TOP_OFFSET
#undef NA_SUBTITLE_TOP_OFFSET
#undef NA_TITLE_TOP_OFFSET
#undef NA_TITLE_LABEL_HEIGHT
#undef NA_TITLE_FONT_SIZE
#undef NA_SUBTITLE_FONT_SIZE
#undef NA_SUBTITLE_LABEL_HEIGHT
#undef NA_RIGHT_ACCESSORY_LEFT_OFFSET
#undef NA_CALLOUT_IMAGE_LEFT
#undef NA_CALLOUT_IMAGE_RIGHT
#undef NA_CALLOUT_IMAGE_ANCHOR
#undef NA_CALLOUT_IMAGE_BG
#undef NA_RIGHT_ACCESSORY_TOP_OFFSET
#undef NA_ANCHOR_Y_OFFSET