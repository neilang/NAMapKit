//
//  NAAnnotationDemoViewController.m
//  Demo
//
//  Created by Daniel Doubrovkine on 3/8/14.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NADotAnnotationDemoViewController.h"

SpecBegin(NAAnnotationDemoViewController)

it(@"displays map with a pin", ^{
    NADotAnnotationDemoViewController *vc = [[NADotAnnotationDemoViewController alloc] init];
    expect(vc.view).willNot.beNil();
//    expect(vc.view).will.haveValidSnapshotNamed(@"default");
});

SpecEnd
