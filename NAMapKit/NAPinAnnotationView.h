//
//  NAPinAnnotationView.h
//  NAMapKit
//
//  Created by Neil Ang on 21/07/10.
//  Copyright 2010 neilang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAAnnotation.h"
#import "NACallOutView.h"

@interface NAPinAnnotationView : UIButton {
	@private
	NAAnnotation * _annotation;
	NACallOutView * _callOutView;
}

- (CGRect)frameForPoint: (CGPoint)point;

- (id)initWithAnnotation:(NAAnnotation *)annotation;

- (IBAction)showCallOut:(id)sender;
- (void)hideCallOut;

@property (nonatomic, retain) NAAnnotation * annotation;
@property (nonatomic, retain) NACallOutView * callOutView;

@end
