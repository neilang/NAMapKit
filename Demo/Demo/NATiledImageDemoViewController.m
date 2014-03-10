//
//  NATiledImageDemoViewController.m
//  Demo
//
//  Created by Daniel Doubrovkine on 3/10/14.
//  Copyright (c) 2014 neilang.com. All rights reserved.
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
    dzTileImageDataSource.maxTileLevel = 11;
    dzTileImageDataSource.minTileLevel = ceil(log(MAX(dzTileImageDataSource.maxTiledWidth, dzTileImageDataSource.maxTiledHeight))/log(2));
    dzTileImageDataSource.tileSize = 512;
    dzTileImageDataSource.tileFormat = @"jpg";
    dzTileImageDataSource.tileBaseURL = [NSURL URLWithString:@"http://static1.artsy.net/maps/52fa629db504f55202000001/5/dztiles-512-0"];
    
    NATiledImageMapView *mapView = [[NATiledImageMapView alloc] initWithFrame:self.view.bounds tiledImageDataSource:dzTileImageDataSource];
    mapView.backgroundColor  = [UIColor colorWithRed:0.000f green:0.475f blue:0.761f alpha:1.000f];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    mapView.minimumZoomScale = 0.5f;
    mapView.maximumZoomScale = 1.5f;
    // mapView.displayTileBorders = YES;
    mapView.backgroundImageURL = [NSURL URLWithString:@"http://static1.artsy.net/maps/52fa629db504f55202000001/5/large.jpg"];
    _mapView = mapView;

    [self.view addSubview:mapView];
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
