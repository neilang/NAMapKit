//
//  NAMapView.h
//  NAMapKit
//
//  Created by Neil Ang on 21/07/10.
//  Copyright 2010 neilang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAAnnotation.h"

@interface NAMapView : UIScrollView<UIScrollViewDelegate> {
	@private
	UIImageView * customMap;
	CGSize _orignalSize;
}

-(void)displayMap:(UIImage *)map;
-(void)addAnnotation:(NAAnnotation *)annotation;

@property (nonatomic, retain) UIImageView * customMap;
@property (nonatomic, assign) CGSize orignalSize;

@end
