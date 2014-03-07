//
//  NAInteractiveLoadViaNIBDemoViewControllerTests.m
//  Demo
//
//  Created by Daniel Doubrovkine on 3/7/14.
//  Copyright (c) 2014 neilang.com. All rights reserved.
//

#import "NALoadViaNIBDemoViewController.h"

SpecBegin(NALoadViaNIBDemoViewController)

setGlobalReferenceImageDir(FB_REFERENCE_IMAGE_DIR);

it(@"displays a menu", ^{
    NALoadViaNIBDemoViewController *vc = [[NALoadViaNIBDemoViewController alloc] init];
    expect(vc.view).willNot.beNil();
    expect(vc.view).to.haveValidSnapshotNamed(@"NALoadViaNIBDemoViewController");
});

SpecEnd
