//
//  NAInteractiveDemoViewController.m
//  Demo
//
//  Created by Neil Ang on 6/05/12.
//  Copyright (c) 2012 neilang.com. All rights reserved.
//

#import "NAInteractiveDemoViewController.h"
#import "NAPinAnnotation.h"

@interface NAInteractiveDemoViewController (){
    int _count;
    NAPinAnnotation *_lastFocused;
}
@property (nonatomic, strong) NSMutableArray *annotations;
@property (nonatomic, assign) CGSize size;
@property (weak, nonatomic) IBOutlet UILabel *zoomLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedPinLabel;
@end

@implementation NAInteractiveDemoViewController

-(void)viewDidLoad
{
    [super viewDidLoad];

    self.annotations = [[NSMutableArray alloc] init];

    UIImage *image = [UIImage imageNamed:@"australia"];

    self.mapView.backgroundColor = [UIColor colorWithRed:0.000f green:0.475f blue:0.761f alpha:1.000f];
    self.mapView.mapViewDelegate = self;
    
    [self.mapView displayMap:image];

    [self mapView:self.mapView hasChangedZoomLevel:self.mapView.zoomLevel];
    self.selectedPinLabel.text = @"";

    self.size = image.size;

    _count = 0;
    _lastFocused = nil;
}

-(IBAction)addPin:(id)sender{

    int x = (arc4random() % (int)self.size.width);
    int y = (arc4random() % (int)self.size.width);

    CGPoint point = CGPointMake(x, y);
    
    [self addPinAt:point withColor:arc4random() % 3];
}

-(void)addPinAt:(CGPoint)point withColor:(NAPinColor)color{

    [self.mapView centreOnPoint:point animated:YES];

    NAPinAnnotation *annotation = [NAPinAnnotation annotationWithPoint:point];

    annotation.title = [NSString stringWithFormat:@"Pin %d", ++_count];

    annotation.color = color;

    [self.mapView addAnnotation:annotation animated:YES];

    [self.annotations addObject:annotation];

    _lastFocused = annotation;

}

-(IBAction)removePin:(id)sender{

    if([self.annotations count] <= 0 || _lastFocused == nil) return;

    [self.mapView centreOnPoint:_lastFocused.point animated:YES];

    [self.mapView removeAnnotation:_lastFocused];

    [self.annotations removeObject:_lastFocused];

    _lastFocused = ([self.annotations count] > 0) ? [self.annotations objectAtIndex:[self.annotations count]-1] : nil;
}

-(IBAction)selectRandom:(id)sender{
    if([self.annotations count] <= 0) return;

    int rand = (arc4random() % (int)[self.annotations count]);
    [self selectPinAt:rand];
}

-(void)selectPinAt:(NSInteger)index{
    NAPinAnnotation *annotation = [self.annotations objectAtIndex:index];
   
    self.selectedPinLabel.text = [NSString stringWithFormat:@"%@", annotation.title];

    [self.mapView selectAnnotation:annotation animated:YES];
    
    _lastFocused = annotation;
}

- (void)mapView:(NAMapView *)mapView tappedOnAnnotation:(NAPinAnnotation *)annotation
{
    self.selectedPinLabel.text = [NSString stringWithFormat:@"%@", annotation.title];
}

- (void)mapView:(NAMapView *)mapView hasChangedZoomLevel:(CGFloat)level
{
    self.zoomLevelLabel.text = [NSString stringWithFormat:@"%.2f", level];
}

@end
