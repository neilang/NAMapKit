//
//  NAPinAnnotationView.h
//  NAMapKit
//
//  Created by Neil Ang on 21/07/10.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NAPinAnnotationView.h"

const CGFloat NAMapViewAnnotationPinWidth = 32.0f;
const CGFloat NAMapViewAnnotationPinHeight = 39.0f;
const CGFloat NAMapViewAnnotationPinPointX = 8.0f;
const CGFloat NAMapViewAnnotationPinPointY = 35.0f;

@interface NAPinAnnotationView()
@property (nonatomic, weak) NAMapView *mapView;
@end

@implementation NAPinAnnotationView

- (id)initWithAnnotation:(NAPinAnnotation *)annotation onMapView:(NAMapView *)mapView
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.mapView = mapView;
        self.annotation = annotation;
        self.animating = NO;
    }
    return self;
}

- (void)setAnimating:(BOOL)animating
{
    _animating = animating;

    NSString *pinImageName;
    switch (self.annotation.color) {
        case NAPinColorGreen:
            pinImageName = @"pin_green";
            break;
        case NAPinColorPurple:
            pinImageName = @"pin_purple";
            break;
        case NAPinColorRed:
            pinImageName = @"pin_red";
            break;
    }

    if (animating) {
        pinImageName = [NSString stringWithFormat:@"%@_floating", pinImageName];
    }
    
    UIImage *pinImage = [UIImage imageWithContentsOfFile:[[NSBundle bundleForClass:NAPinAnnotationView.class] pathForResource:pinImageName ofType:@"png"]];
    
    [self setImage:pinImage forState:UIControlStateNormal];
}

- (void)updatePosition
{
    CGPoint point = [self.mapView zoomRelativePoint:self.annotation.point];
    point.x = point.x - NAMapViewAnnotationPinPointX;
    point.y = point.y - NAMapViewAnnotationPinPointY;
    self.frame = CGRectMake(point.x, point.y, NAMapViewAnnotationPinWidth, NAMapViewAnnotationPinHeight);
}

@end
