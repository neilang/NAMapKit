//
//  NAPinAnnotation.h
//  NAMapKit
//
//  Created by Neil Ang on 21/07/10.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NAAnnotation.h"

typedef enum {
    NAPinColorRed,
    NAPinColorGreen,
    NAPinColorPurple
} NAPinColor;

/**
 *  An annotation that looks like a pin.
 */
@interface NAPinAnnotation : NAAnnotation

/// Pin color.
@property (nonatomic, assign) NAPinColor color;
/// Pin title.
@property (nonatomic, copy) NSString *title;
/// Pin subtitle.
@property (nonatomic, copy) NSString *subtitle;
/// Callout view that appears when the pin is tapped.
@property (nonatomic, strong) UIButton *rightCalloutAccessoryView;

/// Create a new pin at a point on a map.
- (id)initWithPoint:(CGPoint)point;

@end
