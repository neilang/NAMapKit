//
//  NAAnnotation.h
//  NAMapKit
//
//  Created by Neil Ang on 21/07/10.
//  Copyright 2010 neilang.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NAAnnotation : NSObject {
	CGPoint _point;
	NSString * _title;
}

// points as we are not showing coords!
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, copy) NSString * title;

+(id)annotationWithPoint:(CGPoint)point;
-(id)initWithPoint:(CGPoint)point;

@end
