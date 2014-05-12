//
//  NAPinAnnotationsDemoViewController.m
//  Demo
//
//  Created by Neil Ang on 6/05/12.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NAPinAnnotationsDemoViewController.h"
#import "NAMapView.h"
#import "NAPinAnnotationMapView.h"
#import "NAPinAnnotation.h"

@implementation NAPinAnnotationsDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NAMapView *mapView = [[NAPinAnnotationMapView alloc] initWithFrame:self.view.bounds];

    mapView.backgroundColor  = [UIColor colorWithRed:0.000f green:0.475f blue:0.761f alpha:1.000f];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    mapView.minimumZoomScale = 0.5f;
    mapView.maximumZoomScale = 1.5f;

    NSString *australia = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/Maps/australia.png"];
    [mapView displayMap:[UIImage imageWithContentsOfFile:australia]];

    [self.view addSubview:mapView];

    NAPinAnnotation *melbourne = [NAPinAnnotation annotationWithPoint:CGPointMake(543.0f, 489.0f)];
    melbourne.title = @"Melbourne";
    melbourne.subtitle = @"I have a subtitle";
    melbourne.color = NAPinColorGreen;

    [mapView addAnnotation:melbourne animated:NO];

    NAPinAnnotation * perth = [NAPinAnnotation annotationWithPoint:CGPointMake(63.0f, 379.0f)];
	perth.title = @"Perth";
    perth.subtitle = @"I have a button";
	perth.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    perth.color = NAPinColorRed;

	[mapView addAnnotation:perth animated:NO];

	NAPinAnnotation * brisbane = [NAPinAnnotation annotationWithPoint:CGPointMake(679.0f, 302.0f)];
	brisbane.title = @"Brisbane";
    brisbane.color = NAPinColorPurple;

	[mapView addAnnotation:brisbane animated:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
