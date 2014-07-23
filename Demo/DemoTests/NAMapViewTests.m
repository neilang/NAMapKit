//
//  NAMapKitTests
//
//  Created by Daniel Doubrovkine on 3/6/14.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NADotAnnotation.h"

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

describe(@"a map view", ^{
    __block NAMapView *mapView = nil;
    
    beforeEach(^{
        mapView = [[NAMapView alloc] init];
        mapView.bounds = CGRectMake(0, 0, 50, 50);
        mapView.contentSize = CGSizeMake(100, 100);
        mapView.originalSize = CGSizeMake(100, 100);
    });
    
    it(@"sets the contentOffset correctly when centering on a point", ^{
        [mapView updateContentOffsetToCenterPoint:CGPointMake(10, 10) animated:NO];
        expect(mapView.contentOffset.x).to.equal(-15);
        expect(mapView.contentOffset.y).to.equal(-15);
    });
    
    it(@"sets the contentOffset correctly when centering on an annotation", ^{
        NADotAnnotation *annotation = [NADotAnnotation annotationWithPoint:CGPointMake(70, 70)];
        [mapView addAnnotation:annotation animated:NO];
        
        [mapView selectAnnotation:annotation animated:NO];
        
        expect(mapView.contentOffset.x).to.equal(45);
        expect(mapView.contentOffset.y).to.equal(45);
    });
});

SpecEnd

