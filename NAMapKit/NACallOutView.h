//
//  NACallOutView.h
//  NAMapKit
//
//  Created by Neil Ang on 23/07/10.
//  Copyright 2010 neilang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAAnnotation.h"


@class NAMapView;

@interface NACallOutView : UIView {
	@private
	NAAnnotation * _annotation;
	NAMapView * _mapView;
}

-(id)initWithAnnotation:(NAAnnotation *)annotation onMap:(NAMapView *)mapView;
-(void)displayAnnotation:(NAAnnotation *)annotation;


@property (nonatomic, retain) NAAnnotation * annotation;
@property (nonatomic, retain) NAMapView * mapView;

@end
