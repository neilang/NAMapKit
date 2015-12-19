//
//  NAPinAnnotationCallOutView.m
//  NAMapKit
//
//  Created by Neil Ang on 23/07/10.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NAPinAnnotationCallOutView.h"

const CGFloat NAMapViewAnnotationCalloutTitleStandaloneLabelHeight = 22.0f;
const CGFloat NAMapViewAnnotationCalloutTitleStandaloneFontSize = 18.0f;
const CGFloat NAMapViewAnnotationCalloutTitleStandaloneTopOffset = 12.0f;
const CGFloat NAMapViewAnnotationCalloutTitleTopOffset = 4.0f;
const CGFloat NAMapViewAnnotationCalloutTitleLabelHeight = 20.0f;
const CGFloat NAMapViewAnnotationCalloutTitleFontSize = 17.0f;
const CGFloat NAMapViewAnnotationCalloutSubtitleTopOffset = 0.0f + NAMapViewAnnotationCalloutTitleLabelHeight;
const CGFloat NAMapViewAnnotationCalloutSubtitleFontSize = 11.0f;
const CGFloat NAMapViewAnnotationCalloutSubtitleLabelHeight = 25.0f;
const CGFloat NAMapViewAnnotationCalloutRightAccessoryLeftOffset = 2.0f;
const CGFloat NAMapViewAnnotationCalloutRightAccessoryTopOffset = 9.0f;
const CGFloat NAMapViewAnnotationCalloutAnchorYOffset = 26.0f;
static NSString *NAMapViewAnnotationCalloutImageLeft = @"/callout_left.png";
static NSString *NAMapViewAnnotationCalloutImageRight = @"/callout_right.png";
static NSString *NAMapViewAnnotationCalloutImageAnchor = @"/callout_anchor.png";
static NSString *NAMapViewAnnotationCalloutImageBG = @"/callout_bg.png";

@interface NAPinAnnotationCallOutView()

@property (nonatomic, strong) UIImageView *calloutLeftCapView;
@property (nonatomic, strong) UIImageView *calloutRightCapView;
@property (nonatomic, strong) UIImageView *calloutAnchorView;
@property (nonatomic, strong) UIImageView *calloutLeftCenterView;
@property (nonatomic, strong) UIImageView *calloutRightCenterView;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, assign) CGPoint position;
@property (nonatomic, weak)   NAMapView *mapView;

- (void)positionView:(UIView *)view posX:(float)x;
- (void)positionView:(UIView *)view posX:(float)x width:(float)width;

@end

@implementation NAPinAnnotationCallOutView

- (id)initOnMapView:(NAMapView *)mapView
{
    self = [super init];
    if (self) {
        UIImage *calloutBG                 = [[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:NAMapViewAnnotationCalloutImageBG]] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        self.calloutLeftCapView            = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:NAMapViewAnnotationCalloutImageLeft]]];
        self.calloutRightCapView           = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:NAMapViewAnnotationCalloutImageRight]]];
        self.calloutAnchorView             = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:NAMapViewAnnotationCalloutImageAnchor]]];
        self.calloutLeftCenterView         = [[UIImageView alloc] initWithImage:calloutBG];
        self.calloutRightCenterView        = [[UIImageView alloc] initWithImage:calloutBG];
        self.subtitleLabel                 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.subtitleLabel.textColor       = [UIColor whiteColor];
        self.subtitleLabel.backgroundColor = [UIColor clearColor];
        self.subtitleLabel.font            = [UIFont systemFontOfSize:NAMapViewAnnotationCalloutSubtitleFontSize];
        self.titleLabel                    = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.backgroundColor    = [UIColor clearColor];
        self.titleLabel.textColor          = [UIColor whiteColor];
        self.mapView                       = mapView;
        self.hidden                        = YES;
    }
    return self;
}

- (void)setAnnotation:(NAPinAnnotation *)annotation
{

    // --- RESET ---

    self.titleLabel.text    = @"";
    self.subtitleLabel.text = @"";
    self.point              = CGPointZero;

    for (UIView *view in self.subviews) {
		[view removeFromSuperview];
	}

    self.position = annotation.point;

    CGFloat leftCapWidth  = self.calloutLeftCapView.image.size.width;
    CGFloat rightCapWidth = self.calloutRightCapView.image.size.width;
    CGFloat anchorWidth   = self.calloutAnchorView.image.size.width;
    CGFloat anchorHeight  = self.calloutAnchorView.image.size.height;
    CGFloat maxWidth      = self.mapView.frame.size.width;

    // --- FRAME ---

    CGFloat middleWidth = anchorWidth;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    if (annotation.subtitle) {
        CGSize subtitleSize = [annotation.subtitle sizeWithFont:[UIFont boldSystemFontOfSize:NAMapViewAnnotationCalloutSubtitleFontSize] constrainedToSize:CGSizeMake(maxWidth, NAMapViewAnnotationCalloutSubtitleLabelHeight) lineBreakMode:NSLineBreakByTruncatingTail];

        middleWidth = MAX(subtitleSize.width, middleWidth);

        CGSize titleSize  = [annotation.title sizeWithFont:[UIFont boldSystemFontOfSize:NAMapViewAnnotationCalloutTitleFontSize] constrainedToSize:CGSizeMake(maxWidth, NAMapViewAnnotationCalloutTitleLabelHeight) lineBreakMode:NSLineBreakByTruncatingTail];

        middleWidth = MAX(titleSize.width, middleWidth);
    }
    else{
        CGSize titleSize  = [annotation.title sizeWithFont:[UIFont boldSystemFontOfSize:NAMapViewAnnotationCalloutTitleStandaloneFontSize] constrainedToSize:CGSizeMake(maxWidth, NAMapViewAnnotationCalloutTitleStandaloneLabelHeight) lineBreakMode:NSLineBreakByTruncatingTail];

        middleWidth = MAX(titleSize.width, middleWidth);
    }
#pragma clang diagnostic pop

    if (annotation.rightCalloutAccessoryView) {
		middleWidth += annotation.rightCalloutAccessoryView.frame.size.width + NAMapViewAnnotationCalloutRightAccessoryLeftOffset;
	}

    middleWidth = MIN(maxWidth, middleWidth);

    CGFloat totalWidth  = middleWidth + leftCapWidth + rightCapWidth;

    self.point = annotation.point;

    self.frame = CGRectMake(0.0f, 0.0f, totalWidth, anchorHeight);
    [self updatePosition];

    // --- IMAGEVIEWS ---

    CGFloat centreOffsetWidth = (middleWidth - anchorWidth) / 2.0f;

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

    CGFloat labelWidth = middleWidth;

    // --- RIGHT ACCESSORY VIEW ---

    if (annotation.rightCalloutAccessoryView) {
        CGFloat accesoryWidth = annotation.rightCalloutAccessoryView.frame.size.width;
        CGFloat x = middleWidth - accesoryWidth + leftCapWidth + NAMapViewAnnotationCalloutRightAccessoryLeftOffset;

        CGRect frame = annotation.rightCalloutAccessoryView.frame;
        frame.origin.x = x;
        frame.origin.y = NAMapViewAnnotationCalloutRightAccessoryTopOffset;
        annotation.rightCalloutAccessoryView.frame = frame;

        [self addSubview:annotation.rightCalloutAccessoryView];
        labelWidth -= accesoryWidth;
	}


    // --- LABELS ---

    CGFloat currentTitleTopOffset   = NAMapViewAnnotationCalloutTitleStandaloneTopOffset;
	CGFloat currentTitleLabelHeight = NAMapViewAnnotationCalloutTitleStandaloneLabelHeight;
	CGFloat currentTitleFontSize    = NAMapViewAnnotationCalloutTitleStandaloneFontSize;


    // --- SUBTITLE ---

    if (annotation.subtitle) {
		currentTitleTopOffset       = NAMapViewAnnotationCalloutTitleTopOffset;
		currentTitleLabelHeight     = NAMapViewAnnotationCalloutTitleLabelHeight;
		currentTitleFontSize        = NAMapViewAnnotationCalloutTitleFontSize;
        self.subtitleLabel.text  = annotation.subtitle;
        self.subtitleLabel.frame = CGRectMake(leftCapWidth, NAMapViewAnnotationCalloutSubtitleTopOffset, labelWidth, NAMapViewAnnotationCalloutSubtitleLabelHeight);
        [self addSubview:self.subtitleLabel];
	}

    // --- TITLE ---

    self.titleLabel.text  = annotation.title;
    self.titleLabel.font  = [UIFont boldSystemFontOfSize:currentTitleFontSize];
    self.titleLabel.frame = CGRectMake(leftCapWidth, currentTitleTopOffset, labelWidth, currentTitleLabelHeight);

    [self addSubview:self.titleLabel];

}

#pragma - Private helpers

- (void)updatePosition
{
    CGPoint point = [self.mapView zoomRelativePoint:self.position];
    CGFloat xPos = point.x - (self.frame.size.width / 2.0f);
    CGFloat yPos = point.y - (self.frame.size.height) - NAMapViewAnnotationCalloutAnchorYOffset;
    self.frame = CGRectMake(floor(xPos), yPos, self.frame.size.width, self.frame.size.height);
}

- (void)positionView:(UIView *)view posX:(float)x width:(float)width
{
    CGRect frame     = view.frame;
    frame.origin.x   = x;
    frame.size.width = width;
    view.frame       = frame;
}

- (void)positionView:(UIView *)view posX:(float)x
{
    [self positionView:view posX:x width:view.frame.size.width];
}

@end
