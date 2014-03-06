//
//  NAMapKitTests
//
//  Created by Daniel Doubrovkine on 3/6/14.
//  Copyright (c) 2014 neilang.com. All rights reserved.
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
});

SpecEnd

