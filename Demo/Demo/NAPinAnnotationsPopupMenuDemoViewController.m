//
//  NAPinAnnotationsPopupMenuDemoViewController.m
//  Demo
//
//  Created by xdzhangm on 16/5/4.
//  Copyright © 2016年 neilang.com. All rights reserved.
//

#import "NAPinAnnotationsPopupMenuDemoViewController.h"
#import "NAMapView.h"
#import "NAPinAnnotationPopupMapView.h"
#import "NAPinAnnotationPopup.h"

@interface NAPinAnnotationsPopupMenuDemoViewController ()

@end

@implementation NAPinAnnotationsPopupMenuDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NAMapView *mapView = [[NAPinAnnotationPopupMapView alloc] initWithFrame:self.view.bounds];
    
    mapView.backgroundColor  = [UIColor colorWithRed:0.000f green:0.475f blue:0.761f alpha:1.000f];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    mapView.minimumZoomScale = 0.5f;
    mapView.maximumZoomScale = 1.5f;
    
    NSString *australia = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/Maps/australia.png"];
    [mapView displayMap:[UIImage imageWithContentsOfFile:australia]];
    
    [self.view addSubview:mapView];
    
    NAPinAnnotationPopup *melbourne = [NAPinAnnotationPopup annotationWithPoint:CGPointMake(543.0f, 489.0f)];
    melbourne.title = @"Melbourne";
    melbourne.menuStyle = POP_UP_MENU_STYLE_CIRCLE;
    melbourne.subTitleList = @[@"Menu 1", @"Menu 2", @"Menu 3"];
    
    [mapView addAnnotation:melbourne animated:NO];
    
    NAPinAnnotationPopup * perth = [NAPinAnnotationPopup annotationWithPoint:CGPointMake(63.0f, 379.0f)];
    perth.title = @"Perth";
    perth.menuStyle = POP_UP_MENU_STYLE_CIRCLE;
    perth.subTitleList = @[@"Menu 1", @"Menu 2", @"Menu 3", @"Menu 4"];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
