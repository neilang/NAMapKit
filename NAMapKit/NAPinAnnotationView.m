//
//  NAPinAnnotationView.h
//  NAMapKit
//
//  Created by Neil Ang on 21/07/10.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NAPinAnnotationView.h"

const CGFloat pinWidth = 32.0f;
const CGFloat pinHeight = 39.0f;
const CGFloat pinPointX = 8.0f;
const CGFloat pinPointY = 35.0f;

@interface NAPinAnnotationView()
@property (nonatomic, weak) NAMapView *mapView;
@end

@implementation NAPinAnnotationView

- (id)initWithAnnotation:(NAPinAnnotation *)annotation onMapView:(NAMapView *)mapView {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.mapView = mapView;
        self.annotation = annotation;
        self.animating = NO;
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
    point.x = point.x - pinPointX;
    point.y = point.y - pinPointY;
    self.frame = CGRectMake(point.x, point.y, pinWidth, pinHeight);
}

@end
