//
// NAPinAnnotationView.h
// NAMapKit
//
// Created by Neil Ang on 21/07/10.
// Copyright 2010 neilang.com. All rights reserved.
//

#import "NAPinAnnotationView.h"

#define NA_PIN_WIDTH   32.0f
#define NA_PIN_HEIGHT  39.0f
#define NA_PIN_POINT_X 8.0f
#define NA_PIN_POINT_Y 35.0f

@interface NAPinAnnotationView()

- (void)updatePosition;

@property (nonatomic, weak) NAMapView *mapView;

@end

@implementation NAPinAnnotationView

@synthesize annotation = _annotation;
@synthesize animating  = _animating;
@synthesize mapView    = _mapView;

- (id)initWithAnnotation:(NAPinAnnotation *)annotation onMapView:(NAMapView *)mapView {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.mapView    = mapView;
        self.annotation = annotation;
        self.animating  = NO;

        [self updatePosition];
    }
    return self;
}

- (void)setAnimating:(BOOL)animating{
    _animating = animating;

    NSString *pinImage;
    switch (self.annotation.color) {
        case NAPinColorGreen:
            pinImage = @"pinGreen";
            break;
        case NAPinColorPurple:
            pinImage = @"pinPurple";
            break;
        case NAPinColorRed:
            pinImage = @"pinRed";
            break;
    }

    NSString * image = _animating ? [NSString stringWithFormat:@"%@Floating", pinImage] : pinImage;

    [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
}

-(void)updatePosition{
    CGPoint point = [self.mapView zoomRelativePoint:self.annotation.point];
    point.x       = point.x - NA_PIN_POINT_X;
    point.y       = point.y - NA_PIN_POINT_Y;
    self.frame    = CGRectMake(point.x, point.y, NA_PIN_WIDTH, NA_PIN_HEIGHT);
}

@end

#undef NA_PIN_WIDTH
#undef NA_PIN_HEIGHT
#undef NA_PIN_POINT_X
#undef NA_PIN_POINT_Y
