//
//  NATiledImageMapViewTests.m
//
//  Created by Daniel Doubrovkine on 3/11/14.
//  Copyright (c) 2014 neilang.com. All rights reserved.
//

#import "NATiledImageDemoViewController.h"

SpecBegin(NATiledImageDemoViewController)

beforeAll(^{
    setGlobalReferenceImageDir(FB_REFERENCE_IMAGE_DIR);
});

__block NATiledImageDemoViewController *vc = nil;

beforeEach(^{
    vc = [[NATiledImageDemoViewController alloc] init];
    expect(vc.view).willNot.beNil();
});

// TODO: drawRect isn't called when running in a test until the test has finished
pending(@"displays map with a pin", ^{
    [vc viewDidAppear:NO];
    expect(vc.view).to.haveValidSnapshotNamed(@"default");
});

SpecEnd
