//
//  NAInteractiveDemoViewController.m
//  Demo
//
//  Created by Neil Ang on 6/05/12.
//  Copyright (c) 2012 neilang.com. All rights reserved.
//

#import "NAInteractiveDemoViewController.h"

@interface NAInteractiveDemoViewController ()
    @property (nonatomic, strong) NSMutableArray *annotations;
    @property (nonatomic, assign) CGSize size;
@end

@implementation NAInteractiveDemoViewController

@synthesize mapView = _mapView;
@synthesize annotations = _annotations;
@synthesize size = _size;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.annotations = [[NSMutableArray alloc] init];
    
    UIImage *image = [UIImage imageNamed:@"australia"];
    
    self.mapView.backgroundColor = [UIColor colorWithRed:0.000 green:0.475 blue:0.761 alpha:1.000];
    
    [self.mapView displayMap:image];
    
    self.size = image.size;
}


-(IBAction)addPin:(id)sender{
    
    int x = (arc4random() % (int)self.size.width);
    int y = (arc4random() % (int)self.size.width);
    
    CGPoint point = CGPointMake(x, y);
    
    [self.mapView centreOnPoint:point animated:YES];
    
    NAAnnotation *annotation = [NAAnnotation annotationWithPoint:point];
    
    annotation.color = arc4random() % 3;
    
    [self.mapView addAnnotation:annotation animated:YES];
    
    [self.annotations addObject:annotation];
    
}

-(IBAction)removePin:(id)sender{
    
    if([self.annotations count] <= 0) return;
    
    int rand = (arc4random() % (int)[self.annotations count]);
    
    NAAnnotation *annotation = [self.annotations objectAtIndex:rand];
    [self.annotations removeObjectAtIndex:rand];
    
    [self.mapView centreOnPoint:annotation.point animated:YES];
    
    [self.mapView removeAnnotation:annotation];
    
}

@end
