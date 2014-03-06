//
//  NAAnimatedDemoViewController.m
//  Demo
//
//  Created by Neil Ang on 6/05/12.
//  Copyright (c) 2012 neilang.com. All rights reserved.
//

#import "NAAnimatedDemoViewController.h"
#import "NAMapView.h"
#import "NAAnnotation.h"



@implementation NAAnimatedDemoViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NAMapView *mapView = [[NAMapView alloc] initWithFrame:self.view.bounds];
    
    mapView.backgroundColor  = [UIColor colorWithRed:0.000f green:0.475f blue:0.761f alpha:1.000f];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    
    [mapView displayMap:[UIImage imageNamed:@"australia"]];
    
    mapView.minimumZoomScale = 0.5f;
    mapView.maximumZoomScale = 1.5f;
    
    [self.view addSubview:mapView];
    
    NAAnnotation *a0 = [NAAnnotation annotationWithPoint:CGPointMake(63.0f, 379.0f)];
    NAAnnotation *a1 = [NAAnnotation annotationWithPoint:CGPointMake(130.0f, 340.0f)];
    NAAnnotation *a2 = [NAAnnotation annotationWithPoint:CGPointMake(200.0f, 311.0f)];
    NAAnnotation *a3 = [NAAnnotation annotationWithPoint:CGPointMake(308.0f, 304.0f)];
    NAAnnotation *a4 = [NAAnnotation annotationWithPoint:CGPointMake(404.0f, 302.0f)];
    NAAnnotation *a5 = [NAAnnotation annotationWithPoint:CGPointMake(472.0f, 367.0f)];
    NAAnnotation *a6 = [NAAnnotation annotationWithPoint:CGPointMake(530.0f, 422.0f)];
    NAAnnotation *a7 = [NAAnnotation annotationWithPoint:CGPointMake(541.0f, 488.0f)];
    
    NSArray *annotations = [NSArray arrayWithObjects:a0, a1, a2, a3, a4, a5, a6, a7, nil];
    
    [mapView addAnnotations:annotations animated:YES];

}



@end
