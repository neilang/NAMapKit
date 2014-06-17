//
//  NAMapKitTests
//
//  Created by Daniel Doubrovkine on 3/6/14.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

SpecBegin(NAMapView)

describe(@"init", ^{

    __block NAMapView *mapView = nil;

    beforeEach(^{
        mapView = [[NAMapView alloc] init];
    });

    it(@"creates an instance", ^{
        expect(mapView).toNot.beNil();
        expect(mapView).to.beKindOf([NAMapView class]);
    });
    
    it(@"asserts on zoomRelativePoint: with a zero content size", ^{
        expect(^{[mapView zoomRelativePoint:CGPointZero];}).to.raise(@"NSInternalInconsistencyException");
    });
});

SpecEnd

