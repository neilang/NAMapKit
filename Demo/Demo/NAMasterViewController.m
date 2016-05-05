//
//  NAMasterViewController.m
//  Demo
//
//  Created by Neil Ang on 6/05/12.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NAMasterViewController.h"
#import "NADotAnnotationDemoViewController.h"
#import "NAPinAnnotationsDemoViewController.h"
#import "NALoadViaNIBDemoViewController.h"
#import "NAAnimatedDemoViewController.h"
#import "NAInteractiveDemoViewController.h"
#import "NATiledImageDemoViewController.h"
#import "NAPinAnnotationsPopupMenuDemoViewController.h"

@implementation NAMasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"NAMapKit";
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([self isRunningTests])
    {
        return 6;
    }
    else
    {
        return 7;
    }
}

- (BOOL)isRunningTests
{
    return NSClassFromString(@"XCTest") != nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Simple Annotations Demo";
            break;
        case 1:
            cell.textLabel.text = @"Pin Annotations Demo";
            break;
        case 2:
            cell.textLabel.text = @"Load Via NIB Demo";
            break;
        case 3:
            cell.textLabel.text = @"Animated Pins Demo";
            break;
        case 4:
            cell.textLabel.text = @"Interactive Demo";
            break;
        case 5:
            cell.textLabel.text = @"Tiled Map Demo";
            break;
        case 6:
            cell.textLabel.text = @"Pin Annotations Popup Menu Demo";
            break;
        default:
            cell.textLabel.text = @"???";
            break;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if(indexPath.row == 0){
        NADotAnnotationDemoViewController *vc = [[NADotAnnotationDemoViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    } else if(indexPath.row == 1){
        NAPinAnnotationsDemoViewController *vc = [[NAPinAnnotationsDemoViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2){
        NALoadViaNIBDemoViewController *vc = [[NALoadViaNIBDemoViewController alloc] initWithNibName:@"NALoadViaNIBDemoViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 3){
        NAAnimatedDemoViewController *vc = [[NAAnimatedDemoViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 4){
        NAInteractiveDemoViewController *vc = [[NAInteractiveDemoViewController alloc] initWithNibName:@"NAInteractiveDemoViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 5){
        NATiledImageDemoViewController *vc = [[NATiledImageDemoViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    } else if(indexPath.row == 6){
        NAPinAnnotationsPopupMenuDemoViewController *vc = [[NAPinAnnotationsPopupMenuDemoViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
