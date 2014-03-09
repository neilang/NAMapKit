//
//  NAPlainDemoViewControllerTests.m
//  Demo
//
//  Created by Daniel Doubrovkine on 3/8/14.
//  Copyright (c) 2014 neilang.com. All rights reserved.
//

#import "NAPlainDemoViewController.h"

SpecBegin(NAPlainDemoViewController)

setGlobalReferenceImageDir(FB_REFERENCE_IMAGE_DIR);

it(@"displays map with a pin", ^{
    NAPlainDemoViewController *vc = [[NAPlainDemoViewController alloc] init];
    expect(vc.view).willNot.beNil();
    expect(vc.view).to.haveValidSnapshotNamed(@"default");
});

SpecEnd