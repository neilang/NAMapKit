//
//  NAMasterViewController.m
//  Demo
//
//  Created by Neil Ang on 6/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NAMasterViewController.h"
#import "NAPlainDemoViewController.h"
#import "NABasicDemoViewController.h"
#import "NALoadViaNIBDemoViewController.h"
#import "NAAnimatedDemoViewController.h"
#import "NAInteractiveDemoViewController.h"

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
    return 5;
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
            cell.textLabel.text = @"Plain demo";
            break;
        case 1:
            cell.textLabel.text = @"Basic demo";
            break;
        case 2:
            cell.textLabel.text = @"Load via NIB demo";
            break;
        case 3:
            cell.textLabel.text = @"Animated pins demo";
            break;
        case 4:
            cell.textLabel.text = @"Interactive demo";
            break;
        default:
            cell.textLabel.text = @"???";
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if(indexPath.row == 0){
        NAPlainDemoViewController *vc = [[NAPlainDemoViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if(indexPath.row == 1){
        NABasicDemoViewController *vc = [[NABasicDemoViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if(indexPath.row == 2){
        NALoadViaNIBDemoViewController *vc = [[NALoadViaNIBDemoViewController alloc] initWithNibName:@"NALoadViaNIBDemoViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if(indexPath.row == 3){
        NAAnimatedDemoViewController *vc = [[NAAnimatedDemoViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if(indexPath.row == 4){
        NAInteractiveDemoViewController *vc = [[NAInteractiveDemoViewController alloc] initWithNibName:@"NAInteractiveDemoViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }

}

@end
