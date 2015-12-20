//
//  NAInteractiveLoadViaNIBDemoViewControllerTests.m
//  Demo
//
//  Created by Daniel Doubrovkine on 3/7/14.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NALoadViaNIBDemoViewController.h"

SpecBegin(NALoadViaNIBDemoViewController)

it(@"displays a menu", ^{
    NALoadViaNIBDemoViewController *vc = [[NALoadViaNIBDemoViewController alloc] init];
    expect(vc.view).willNot.beNil();
//    expect(vc.view).will.haveValidSnapshotNamed(@"default");
});

SpecEnd
