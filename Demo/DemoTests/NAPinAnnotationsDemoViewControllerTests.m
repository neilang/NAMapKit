//
//  NAPinAnnotationsDemoViewController.m
//  Demo
//
//  Created by Daniel Doubrovkine on 3/7/14.
//  Copyright (c) 2014 neilang.com. All rights reserved.
//

#import "NAPinAnnotationsDemoViewController.h"
#import "NAPinAnnotation.h"

SpecBegin(NAPinAnnotationsDemoViewController)

setGlobalReferenceImageDir(FB_REFERENCE_IMAGE_DIR);

__block NAPinAnnotationsDemoViewController *vc = nil;

beforeEach(^{
    vc = [[NAPinAnnotationsDemoViewController alloc] init];
    expect(vc.view).willNot.beNil();
});

it(@"displays map with a pin", ^{
    expect(vc.view).to.haveValidSnapshotNamed(@"default");
});

SpecEnd
