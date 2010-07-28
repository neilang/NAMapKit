//
//  NACallOutView.h
//  NAMapKit
//
//  Created by Neil Ang on 23/07/10.
//  Copyright 2010 neilang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAAnnotation.h"

@interface NACallOutView : UIView {
	@private
	NAAnnotation * _annotation;
}

+(NACallOutView*) addCalloutView:(UIView*)parent point:(CGPoint)point annotation:(NAAnnotation *)annotation;

- (id)initAtPoint:(CGPoint)point withAnnotation:(NAAnnotation *)annotation;

@property (nonatomic, retain) NAAnnotation * annotation;

@end
