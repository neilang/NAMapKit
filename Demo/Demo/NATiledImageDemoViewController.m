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
