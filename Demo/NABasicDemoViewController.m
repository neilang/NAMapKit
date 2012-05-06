//
//  NABasicDemoViewController.m
//  Demo
//
//  Created by Neil Ang on 6/05/12.
//  Copyright (c) 2012 neilang.com. All rights reserved.
//

#import "NABasicDemoViewController.h"
#import "NAMapView.h"
#import "NAAnnotation.h"

@interface NABasicDemoViewController ()

@end

@implementation NABasicDemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NAMapView *mapView = [[NAMapView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-44.0f)];
    
    mapView.backgroundColor = [UIColor colorWithRed:0.000 green:0.475 blue:0.761 alpha:1.000];

    
    mapView.minimumZoomScale = 0.5;
    mapView.maximumZoomScale = 1.5;
    
    [mapView displayMap:[UIImage imageNamed:@"australia"]];
    
    [self.view addSubview:mapView];
    
    NAAnnotation *melbourne = [NAAnnotation annotationWithPoint:CGPointMake(543, 489)];
    melbourne.title         = @"Melbourne";
    melbourne.subtitle      = @"I have a subtitle";
    melbourne.color         = NAPinColorGreen;
    
    [mapView addAnnotation:melbourne animated:NO];
    
    NAAnnotation * perth            = [NAAnnotation annotationWithPoint:CGPointMake(63, 379)];
	perth.title                     = @"Perth";
    perth.subtitle                  = @"I have a button";
	perth.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    perth.color                     = NAPinColorRed;
    
	[mapView addAnnotation:perth animated:YES];
    
	NAAnnotation * brisbane = [NAAnnotation annotationWithPoint:CGPointMake(679, 302)];
	brisbane.title          = @"Brisbane";
    brisbane.color          = NAPinColorPurple;
    
	[mapView addAnnotation:brisbane animated:NO];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
