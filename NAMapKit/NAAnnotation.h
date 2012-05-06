//
// NAAnnotation.h
// NAMapKit
//
// Created by Neil Ang on 21/07/10.
// Copyright 2010 neilang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    NAPinColorRed,
    NAPinColorGreen,
    NAPinColorPurple
} NAPinColor;

@interface NAAnnotation : NSObject

@property (nonatomic, assign) CGPoint     point;
@property (nonatomic, assign) NAPinColor  color;
@property (nonatomic, copy)   NSString   *title;
@property (nonatomic, copy)   NSString   *subtitle;
@property (nonatomic, strong) UIButton   *rightCalloutAccessoryView;

+ (id)annotationWithPoint:(CGPoint)point;
- (id)initWithPoint:(CGPoint)point;

@end
