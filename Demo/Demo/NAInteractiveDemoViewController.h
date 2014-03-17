//
//  NAInteractiveDemoViewController.h
//  Demo
//
//  Created by Neil Ang on 6/05/12.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAMapView.h"
#import "NAPinAnnotation.h"

@interface NAInteractiveDemoViewController : UIViewController<NAMapViewDelegate>

@property (nonatomic, weak) IBOutlet NAMapView *mapView;

- (IBAction)addPin:(id)sender;
- (void)addPinAt:(CGPoint)point withColor:(NAPinColor)color;

- (IBAction)removePin:(id)sender;

- (IBAction)selectRandom:(id)sender;
- (void)selectPinAt:(NSInteger)index;

@end
