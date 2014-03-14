//
//  NALoadViaNIBDemoViewController.m
//  Demo
//
//  Created by Neil Ang on 6/05/12.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NALoadViaNIBDemoViewController.h"
#import "NAPinAnnotation.h"

@implementation NALoadViaNIBDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.mapView displayMap:[UIImage imageNamed:@"australia"]];

    self.mapView.backgroundColor = [UIColor colorWithRed:0.000f green:0.475f blue:0.761f alpha:1.000f];

    NAPinAnnotation *melbourne = [NAPinAnnotation annotationWithPoint:CGPointMake(543.0f, 489.0f)];
    melbourne.title = @"Melbourne";
    melbourne.subtitle = @"I have a subtitle";
    melbourne.color = NAPinColorGreen;

    [self.mapView addAnnotation:melbourne animated:NO];

    NAPinAnnotation *perth = [NAPinAnnotation annotationWithPoint:CGPointMake(63.0f, 379.0f)];
	perth.title = @"Perth";
    perth.subtitle = @"I have a button";
	perth.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    perth.color = NAPinColorRed;

	[self.mapView addAnnotation:perth animated:NO];

	NAPinAnnotation *brisbane = [NAPinAnnotation annotationWithPoint:CGPointMake(679.0f, 302.0f)];
	brisbane.title = @"Brisbane";
    brisbane.color = NAPinColorPurple;

	[self.mapView addAnnotation:brisbane animated:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
