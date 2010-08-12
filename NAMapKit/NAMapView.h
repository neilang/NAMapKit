//
//  NAMapView.h
//  NAMapKit
//
//  Created by Neil Ang on 21/07/10.
//  Copyright 2010 neilang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAAnnotation.h"
#import "NACallOutView.h"

@interface NAMapView : UIScrollView<UIScrollViewDelegate> {
	@private
	UIImageView *_customMap;
	NSMutableArray *_pinAnnotations;
	CGSize _orignalSize;
	NACallOutView *_callout;
}

-(void)displayMap:(UIImage *)map;
-(void)addAnnotation:(NAAnnotation *)annotation animated:(BOOL)animate;
-(void)addAnnotations:(NSArray *)annotations animated:(BOOL)animate;
-(void)hideCallOut;
-(IBAction)showCallOut:(id)sender;
-(void)centreOnPoint:(CGPoint)point animated:(BOOL)animate;

@property (nonatomic, retain) UIImageView * customMap;
@property (nonatomic, retain) NSMutableArray * pinAnnotations;
@property (nonatomic, retain) NACallOutView *callout;
@property (nonatomic, assign) CGSize orignalSize;

@end
