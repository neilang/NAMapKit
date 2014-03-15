//
//  NATiledImageDemoViewController.m
//  Demo
//
//  Created by Daniel Doubrovkine on 3/10/14.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NATiledImageDemoViewController.h"
#import "NATiledImageMapView.h"
#import "NADZTileImageDataSource.h"

@interface NATiledImageDemoViewController ()
@property(nonatomic, readonly) NATiledImageMapView *mapView;
@end

@implementation NATiledImageDemoViewController

-(void)viewDidLoad
{
    [super viewDidLoad];

    NADZTileImageDataSource *dzTileImageDataSource = [[NADZTileImageDataSource alloc] init];
    dzTileImageDataSource.maxTiledHeight = 5389;
    dzTileImageDataSource.maxTiledWidth = 5000;
    dzTileImageDataSource.minTileLevel = 11;
    dzTileImageDataSource.maxTileLevel = ceil(log(MAX(dzTileImageDataSource.maxTiledWidth, dzTileImageDataSource.maxTiledHeight))/log(2));
    dzTileImageDataSource.tileSize = 512;
    dzTileImageDataSource.tileFormat = @"jpg";
    dzTileImageDataSource.tileBaseURL = [NSURL URLWithString:@"https://raw.github.com/dblock/NAMapKit/tiled-map-view/Demo/Maps/Armory2014/tiles"];

    NATiledImageMapView *mapView = [[NATiledImageMapView alloc] initWithFrame:self.view.bounds tiledImageDataSource:dzTileImageDataSource];
    mapView.backgroundColor  = [UIColor colorWithRed:0.000f green:0.475f blue:0.761f alpha:1.000f];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    // mapView.displayTileBorders = YES;
    mapView.backgroundImageURL = [NSURL URLWithString:@"https://raw.github.com/dblock/NAMapKit/tiled-map-view/Demo/Maps/Armory2014/large.jpg"];
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
