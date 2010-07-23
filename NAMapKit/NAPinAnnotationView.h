//
//  NAPinAnnotationView.h
//  NAMapKit
//
//  Created by Neil Ang on 21/07/10.
//  Copyright 2010 neilang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NAPinAnnotationView : UIButton {
	@private
	CGPoint _origin;
}

- (CGRect)frameForPoint: (CGPoint)point;

- (id)initWithPoint:(CGPoint)point;

@end
