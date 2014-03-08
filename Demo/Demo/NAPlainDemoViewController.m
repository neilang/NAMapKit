//
//  NAPlainDemoViewController.m
//  Demo
//
//  Created by Daniel Doubrovkine on 3/7/14.
//  Copyright (c) 2014 neilang.com. All rights reserved.
//

#import "NAPlainDemoViewController.h"
#import "NAMapView.h"

@implementation NAPlainDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NAMapView *mapView = [[NAMapView alloc] initWithFrame:self.view.bounds];
    
    mapView.backgroundColor  = [UIColor colorWithRed:0.000f green:0.475f blue:0.761f alpha:1.000f];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    mapView.minimumZoomScale = 0.5f;
    mapView.maximumZoomScale = 1.5f;
    
    [mapView displayMap:[UIImage imageNamed:@"australia"]];
    
    [self.view addSubview:mapView];
    
    NAAnnotation *melbourne = [NAAnnotation annotationWithPoint:CGPointMake(543.0f, 489.0f)];
    [mapView addAnnotation:melbourne animated:NO];
    
    NAAnnotation *perth = [NAAnnotation annotationWithPoint:CGPointMake(63.0f, 379.0f)];
	[mapView addAnnotation:perth animated:YES];
    
	NAAnnotation *brisbane = [NAAnnotation annotationWithPoint:CGPointMake(679.0f, 302.0f)];
	[mapView addAnnotation:brisbane animated:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
