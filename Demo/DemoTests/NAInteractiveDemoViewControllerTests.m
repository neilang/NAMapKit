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

it(@"doesn't display any pins", ^{
    NAInteractiveDemoViewController *vc = [[NAInteractiveDemoViewController alloc] init];
    expect(vc.view).willNot.beNil();
    expect(vc.view).to.haveValidSnapshotNamed(@"NAInteractiveDemoViewController");
});

SpecEnd
