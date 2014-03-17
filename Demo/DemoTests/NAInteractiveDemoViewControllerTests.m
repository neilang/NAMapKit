//
//  NAInteractiveDemoViewControllerTests.m
//  Demo
//
//  Created by Daniel Doubrovkine on 3/7/14.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NAInteractiveDemoViewController.h"

SpecBegin(NAInteractiveDemoViewController)

__block NAInteractiveDemoViewController *vc = nil;

beforeEach(^{
    vc = [[NAInteractiveDemoViewController alloc] init];
    expect(vc.view).willNot.beNil();
});

it(@"doesn't display any pins", ^{
    expect(vc.view).will.haveValidSnapshotNamed(@"default");
});

it(@"adds a pin", ^{
    [vc addPinAt:CGPointMake(100, 200) withColor:NAPinColorRed animated:NO];
    expect(vc.view).will.haveValidSnapshotNamed(@"add");
});

it(@"removes a pin", ^{
    [vc addPinAt:CGPointMake(100, 200) withColor:NAPinColorRed animated:NO];
    [vc addPinAt:CGPointMake(200, 300) withColor:NAPinColorGreen animated:NO];
    [vc removePinAt:0 animated:NO];
    expect(vc.view).will.haveValidSnapshotNamed(@"remove");
});

it(@"selects a pin", ^{
    [vc addPinAt:CGPointMake(100, 200) withColor:NAPinColorRed animated:NO];
    [vc addPinAt:CGPointMake(200, 300) withColor:NAPinColorGreen animated:NO];
    [vc selectPinAt:1 animated:NO];
    expect(vc.view).will.haveValidSnapshotNamed(@"select");
});

SpecEnd
