//
//  NAInteractiveDemoViewControllerTests.m
//  Demo
//
//  Created by Daniel Doubrovkine on 3/7/14.
//  Copyright (c) 2014 neilang.com. All rights reserved.
//

#import "NAInteractiveDemoViewController.h"

SpecBegin(NAInteractiveDemoViewController)

setGlobalReferenceImageDir(FB_REFERENCE_IMAGE_DIR);

__block NAInteractiveDemoViewController *vc = nil;

beforeEach(^{
    vc = [[NAInteractiveDemoViewController alloc] init];
    expect(vc.view).willNot.beNil();
});

it(@"doesn't display any pins", ^{
    expect(vc.view).to.haveValidSnapshotNamed(@"default");
});

it(@"adds a pin", ^{
    [vc addPinAt:CGPointMake(100, 200) withColor:NAPinColorRed];
    expect(vc.view).to.haveValidSnapshotNamed(@"add");
    
});

it(@"removes a pin", ^{
    [vc addPinAt:CGPointMake(100, 200) withColor:NAPinColorRed];
    [vc addPinAt:CGPointMake(200, 300) withColor:NAPinColorGreen];
    [vc removePin:nil];
    expect(vc.view).to.haveValidSnapshotNamed(@"remove");
});

pending(@"selects a pin", ^{
    [vc addPinAt:CGPointMake(100, 200) withColor:NAPinColorRed];
    [vc addPinAt:CGPointMake(200, 300) withColor:NAPinColorGreen];
    [vc selectPinAt:1];
    expect(vc.view).to.haveValidSnapshotNamed(@"select");
});

SpecEnd
