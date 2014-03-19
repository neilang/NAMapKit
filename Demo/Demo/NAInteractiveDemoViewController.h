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
- (IBAction)removePin:(id)sender;
- (IBAction)selectRandom:(id)sender;

- (void)addPinAt:(CGPoint)point withColor:(NAPinColor)color animated:(BOOL)animated;
- (void)selectPinAt:(NSInteger)index animated:(BOOL)animated;
- (void)removePinAt:(NSInteger)index animated:(BOOL)animated;

@end
