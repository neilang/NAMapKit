//
//  DemoMenuTests.m
//  Demo
//
//  Created by Daniel Doubrovkine on 3/7/14.
//  Copyright (c) 2014 neilang.com. All rights reserved.
//

#import "NAMasterViewController.h"

SpecBegin(NAMasterViewController)

setGlobalReferenceImageDir(FB_REFERENCE_IMAGE_DIR);

it(@"displays the master menu", ^{
    NAMasterViewController *vc = [[NAMasterViewController alloc] initWithNibName:@"NAMasterViewController" bundle:nil];
    expect(vc.view).willNot.beNil();
    expect(vc.view).to.haveValidSnapshotNamed(@"NAMasterViewController");
});

SpecEnd
