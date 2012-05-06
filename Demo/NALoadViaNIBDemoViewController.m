//
//  NALoadViaNIBDemoViewController.m
//  Demo
//
//  Created by Neil Ang on 6/05/12.
//  Copyright (c) 2012 neilang.com. All rights reserved.
//

#import "NALoadViaNIBDemoViewController.h"

@implementation NALoadViaNIBDemoViewController

@synthesize mapView = _mapView;

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
    
    [self.mapView displayMap:[UIImage imageNamed:@"australia"]];
    
    self.mapView.backgroundColor = [UIColor colorWithRed:0.000 green:0.475 blue:0.761 alpha:1.000];

    NAAnnotation *melbourne = [NAAnnotation annotationWithPoint:CGPointMake(543, 489)];
    melbourne.title         = @"Melbourne";
    melbourne.subtitle      = @"I have a subtitle";
    melbourne.color         = NAPinColorGreen;
    
    [self.mapView addAnnotation:melbourne animated:NO];
    
    NAAnnotation * perth            = [NAAnnotation annotationWithPoint:CGPointMake(63, 379)];
	perth.title                     = @"Perth";
    perth.subtitle                  = @"I have a button";
	perth.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    perth.color                     = NAPinColorRed;
    
	[self.mapView addAnnotation:perth animated:NO];
    
	NAAnnotation * brisbane = [NAAnnotation annotationWithPoint:CGPointMake(679, 302)];
	brisbane.title          = @"Brisbane";
    brisbane.color          = NAPinColorPurple;
    
	[self.mapView addAnnotation:brisbane animated:NO];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
