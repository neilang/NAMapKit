//
//  NATiledImageDemoViewController.m
//  Demo
//
//  Created by Daniel Doubrovkine on 3/10/14.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NATiledImageDemoViewController.h"
#import "NATiledImageMapView.h"
#import <ARTiledImageView/ARLocalTiledImageDataSource.h>

@interface NATiledImageDemoViewController ()
@property(nonatomic, readonly) NATiledImageMapView *mapView;
@property(nonatomic, readonly) ARLocalTiledImageDataSource *dataSource;
@end

@implementation NATiledImageDemoViewController

-(void)viewDidLoad
{
    [super viewDidLoad];

    ARLocalTiledImageDataSource *dataSource = [[ARLocalTiledImageDataSource alloc] init];
    dataSource.maxTiledHeight = 5389;
    dataSource.maxTiledWidth = 5000;
    dataSource.minTileLevel = 11;
    dataSource.maxTileLevel = 13;
    dataSource.tileSize = 512;
    dataSource.tileFormat = @"jpg";
    dataSource.tileBasePath = [NSString stringWithFormat:@"%@/Maps/Armory2014/tiles", [NSBundle mainBundle].resourcePath];
    _dataSource = dataSource;

    NATiledImageMapView *mapView = [[NATiledImageMapView alloc] initWithFrame:self.view.bounds tiledImageDataSource:dataSource];
    mapView.backgroundColor  = [UIColor colorWithRed:0.000f green:0.475f blue:0.761f alpha:1.000f];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    mapView.displayTileBorders = YES;
    mapView.backgroundImage = [UIImage imageNamed:@"Maps/Armory2014/large.jpg"];
    mapView.zoomStep = 3.0f;
    _mapView = mapView;

    [self.view addSubview:mapView];

    NAAnnotation *champagneBar = [NAAnnotation annotationWithPoint:CGPointMake(1500.0f, 4850.1f)];
    [mapView addAnnotation:champagneBar animated:NO];

    NAAnnotation *artsyBooth = [NAAnnotation annotationWithPoint:CGPointMake(2650.0f, 916.12f)];
    [mapView addAnnotation:artsyBooth animated:NO];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.mapView zoomToFit:animated];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
