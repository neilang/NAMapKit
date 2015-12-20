//
//  NAPinAnnotationsDemoViewController.m
//  Demo
//
//  Created by Daniel Doubrovkine on 3/7/14.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NAPinAnnotationsDemoViewController.h"
#import "NAPinAnnotation.h"

SpecBegin(NAPinAnnotationsDemoViewController)

__block NAPinAnnotationsDemoViewController *vc = nil;

beforeEach(^{
    vc = [[NAPinAnnotationsDemoViewController alloc] init];
    expect(vc.view).willNot.beNil();
});

it(@"displays map with a pin", ^{
    expect(vc.view).will.haveValidSnapshotNamed(@"default");
});

SpecEnd
