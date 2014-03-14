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
    UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    vc = [[NATiledImageDemoViewController alloc] init];
    window.rootViewController = vc;
    expect(vc.view).willNot.beNil();
    [window makeKeyAndVisible];
});

// TODO: drawRect isn't called when running in a test until the test has finished
it(@"displays map with a pin", ^AsyncBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, (unsigned long) NULL), ^(void) {
        [NSThread sleepForTimeInterval:3.0];
        expect(vc.view).to.haveValidSnapshotNamed(@"default");
        done();
    });
});

SpecEnd
