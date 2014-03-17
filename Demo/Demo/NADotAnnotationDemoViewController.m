//
//  NADotAnnotationDemoViewController.m
//  Demo
//
//  Created by Daniel Doubrovkine on 3/7/14.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NADotAnnotationDemoViewController.h"
#import "NAMapView.h"
#import "NADotAnnotation.h"

@implementation NADotAnnotationDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NAMapView *mapView = [[NAMapView alloc] initWithFrame:self.view.bounds];

    mapView.mapViewDelegate = self;
    mapView.backgroundColor  = [UIColor colorWithRed:0.000f green:0.475f blue:0.761f alpha:1.000f];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    mapView.minimumZoomScale = 0.5f;
    mapView.maximumZoomScale = 1.5f;

    [mapView displayMap:[UIImage imageNamed:@"Maps/australia"]];

    [self.view addSubview:mapView];

    NADotAnnotation *melbourne = [NADotAnnotation annotationWithPoint:CGPointMake(543.0f, 489.0f)];
    melbourne.radius = 10.0f;
    [mapView addAnnotation:melbourne animated:NO];

    NADotAnnotation *perth = [NADotAnnotation annotationWithPoint:CGPointMake(63.0f, 379.0f)];
    perth.radius = 10.0f;
    perth.color = [UIColor blackColor];
    [mapView addAnnotation:perth animated:YES];

	NADotAnnotation *brisbane = [NADotAnnotation annotationWithPoint:CGPointMake(679.0f, 302.0f)];
    brisbane.radius = 10.0f;
    brisbane.color = [UIColor orangeColor];
    [mapView addAnnotation:brisbane animated:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)mapView:(NAMapView *)mapView tappedOnAnnotation:(NADotAnnotation *)annotation
{
    NSLog(@"tapped: %@", annotation);
}

- (void)mapView:(NAMapView *)mapView hasChangedZoomLevel:(CGFloat)level
{
    NSLog(@"zoom: %@", @(level));
}

@end
