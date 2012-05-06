//
//  NAInteractiveDemoViewController.h
//  Demo
//
//  Created by Neil Ang on 6/05/12.
//  Copyright (c) 2012 neilang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAMapView.h"

@interface NAInteractiveDemoViewController : UIViewController

@property (nonatomic, weak) IBOutlet NAMapView *mapView;

-(IBAction)addPin:(id)sender;
-(IBAction)removePin:(id)sender;

@end
