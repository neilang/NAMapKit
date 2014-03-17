//
//  NADotAnnotation.h
//  NAMapKit
//
//  Created by Neil Ang on 21/07/10.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NAAnnotation.h"

/**
 *  An dot annotation.
 */
@interface NADotAnnotation : NAAnnotation

// Dot radius.
@property (nonatomic, assign) CGFloat radius;
// Dot color.
@property (nonatomic, readwrite) UIColor *color;
// Dot opacity.
@property (nonatomic, assign) CGFloat opacity;

@end
