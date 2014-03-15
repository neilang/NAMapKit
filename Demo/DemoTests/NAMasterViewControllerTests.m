//
//  DemoMenuTests.m
//  Demo
//
//  Created by Daniel Doubrovkine on 3/7/14.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NAMasterViewController.h"

SpecBegin(NAMasterViewController)

beforeAll(^{
    setGlobalReferenceImageDir(FB_REFERENCE_IMAGE_DIR);
});

it(@"displays the master menu", ^{
    NAMasterViewController *vc = [[NAMasterViewController alloc] initWithNibName:@"NAMasterViewController" bundle:nil];
    expect(vc.view).willNot.beNil();
    expect(vc.view).to.haveValidSnapshotNamed(@"default");
});

SpecEnd
