//
//  NAAnimatedDemoViewController.m
//  Demo
//
//  Created by Neil Ang on 6/05/12.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NAAnimatedDemoViewController.h"
#import "NAMapView.h"
#import "NAPinAnnotationMapView.h"
#import "NAPinAnnotation.h"

@implementation NAAnimatedDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NAMapView *mapView = [[NAPinAnnotationMapView alloc] initWithFrame:self.view.bounds];

    mapView.backgroundColor  = [UIColor colorWithRed:0.000f green:0.475f blue:0.761f alpha:1.000f];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    NSString *australia = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/Maps/australia.png"];
    [mapView displayMap:[UIImage imageWithContentsOfFile:australia]];

    mapView.minimumZoomScale = 0.5f;
    mapView.maximumZoomScale = 1.5f;

    [self.view addSubview:mapView];

    NAPinAnnotation *a0 = [NAPinAnnotation annotationWithPoint:CGPointMake(63.0f, 379.0f)];
    NAPinAnnotation *a1 = [NAPinAnnotation annotationWithPoint:CGPointMake(130.0f, 340.0f)];
    NAPinAnnotation *a2 = [NAPinAnnotation annotationWithPoint:CGPointMake(200.0f, 311.0f)];
    NAPinAnnotation *a3 = [NAPinAnnotation annotationWithPoint:CGPointMake(308.0f, 304.0f)];
    NAPinAnnotation *a4 = [NAPinAnnotation annotationWithPoint:CGPointMake(404.0f, 302.0f)];
    NAPinAnnotation *a5 = [NAPinAnnotation annotationWithPoint:CGPointMake(472.0f, 367.0f)];
    NAPinAnnotation *a6 = [NAPinAnnotation annotationWithPoint:CGPointMake(530.0f, 422.0f)];
    NAPinAnnotation *a7 = [NAPinAnnotation annotationWithPoint:CGPointMake(541.0f, 488.0f)];

    NSArray *annotations = [NSArray arrayWithObjects:a0, a1, a2, a3, a4, a5, a6, a7, nil];

    for (NAPinAnnotation *annotation in annotations) {
        annotation.title = @"Hello World";
    }
    
    [mapView addAnnotations:annotations animated:YES];
}

@end
