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
    
    NAMapView *mapView = [[NAMapView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-44.0f)];
    
    mapView.backgroundColor = [UIColor colorWithRed:0.000 green:0.475 blue:0.761 alpha:1.000];
    
    [mapView displayMap:[UIImage imageNamed:@"australia"]];
    
    mapView.minimumZoomScale = 0.5;
    mapView.maximumZoomScale = 1.5;
    
    [self.view addSubview:mapView];
    
    NAAnnotation *a0 = [NAAnnotation annotationWithPoint:CGPointMake(63, 379)];
    NAAnnotation *a1 = [NAAnnotation annotationWithPoint:CGPointMake(130, 340)];
    NAAnnotation *a2 = [NAAnnotation annotationWithPoint:CGPointMake(200, 311)];
    NAAnnotation *a3 = [NAAnnotation annotationWithPoint:CGPointMake(308, 304)];
    NAAnnotation *a4 = [NAAnnotation annotationWithPoint:CGPointMake(404, 302)];
    NAAnnotation *a5 = [NAAnnotation annotationWithPoint:CGPointMake(472, 367)];
    NAAnnotation *a6 = [NAAnnotation annotationWithPoint:CGPointMake(530, 422)];
    NAAnnotation *a7 = [NAAnnotation annotationWithPoint:CGPointMake(541, 488)];
    
    NSArray *annotations = [NSArray arrayWithObjects:a0, a1, a2, a3, a4, a5, a6, a7, nil];
    
    [mapView addAnnotations:annotations animated:YES];

}



@end
