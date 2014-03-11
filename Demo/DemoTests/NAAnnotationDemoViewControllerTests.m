//
//  NAAnnotationDemoViewController.m
//  Demo
//
//  Created by Daniel Doubrovkine on 3/8/14.
//  Copyright (c) 2014 neilang.com. All rights reserved.
//

#import "NAAnnotationDemoViewController.h"

SpecBegin(NAAnnotationDemoViewController)

beforeAll(^{
    setGlobalReferenceImageDir(FB_REFERENCE_IMAGE_DIR);
});

it(@"displays map with a pin", ^{
    NAAnnotationDemoViewController *vc = [[NAAnnotationDemoViewController alloc] init];
    expect(vc.view).willNot.beNil();
    expect(vc.view).will.haveValidSnapshotNamed(@"default");
});

SpecEnd
