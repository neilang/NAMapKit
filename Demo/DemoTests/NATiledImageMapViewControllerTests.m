//
//  NATiledImageMapViewTests.m
//
//  Created by Daniel Doubrovkine on 3/11/14.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NATiledImageDemoViewController.h"

SpecBegin(NATiledImageDemoViewController)

__block NATiledImageDemoViewController *vc = nil;

beforeEach(^{
    UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    vc = [[NATiledImageDemoViewController alloc] init];
    window.rootViewController = vc;
    expect(vc.view).willNot.beNil();
    [window makeKeyAndVisible];
});

it(@"displays map with a pin", ^AsyncBlock {
    dispatch_async(dispatch_get_main_queue(), ^{
        [NSThread sleepForTimeInterval:3.0];
        expect(vc.view).will.haveValidSnapshotNamed(@"default");
        done();
    });
});

SpecEnd
