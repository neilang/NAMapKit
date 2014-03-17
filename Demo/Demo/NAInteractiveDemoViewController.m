//
//  NAInteractiveDemoViewController.m
//  Demo
//
//  Created by Neil Ang on 6/05/12.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NAInteractiveDemoViewController.h"
#import "NAPinAnnotation.h"

@interface NAInteractiveDemoViewController ()
@property (nonatomic, strong) NSMutableArray *annotations;
@property(nonatomic) NAPinAnnotation * lastFocused;
@property (nonatomic, assign) CGSize size;
@property (weak, nonatomic) IBOutlet UILabel *zoomLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedPinLabel;
@end

@implementation NAInteractiveDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.annotations = [[NSMutableArray alloc] init];

    UIImage *image = [UIImage imageNamed:@"Maps/australia"];

    self.mapView.backgroundColor = [UIColor colorWithRed:0.000f green:0.475f blue:0.761f alpha:1.000f];
    self.mapView.mapViewDelegate = self;

    [self.mapView displayMap:image];

    [self mapView:self.mapView hasChangedZoomLevel:self.mapView.zoomLevel];
    self.selectedPinLabel.text = @"";

    self.size = image.size;
}

- (IBAction)addPin:(id)sender{

    NSInteger x = (arc4random() % (int)self.size.width);
    NSInteger y = (arc4random() % (int)self.size.width);

    CGPoint point = CGPointMake(x, y);

    [self addPinAt:point withColor:arc4random() % 3];
}

- (void)addPinAt:(CGPoint)point withColor:(NAPinColor)color{

    [self.mapView centerOnPoint:point animated:YES];

    NAPinAnnotation *annotation = [NAPinAnnotation annotationWithPoint:point];
    annotation.title = [NSString stringWithFormat:@"Pin %d", self.annotations.count + 1];
    annotation.color = color;

    [self.mapView addAnnotation:annotation animated:YES];
    [self.annotations addObject:annotation];

    _lastFocused = annotation;
}

- (IBAction)removePin:(id)sender{
    if(self.annotations.count <= 0 || self.lastFocused == nil) return;
    [self.mapView centerOnPoint:self.lastFocused.point animated:YES];
    [self.mapView removeAnnotation:self.lastFocused];
    [self.annotations removeObject:self.lastFocused];
    self.lastFocused = self.annotations.lastObject;
}

- (IBAction)selectRandom:(id)sender{
    if(self.annotations.count <= 0) return;

    NSInteger rand = (arc4random() % (int)self.annotations.count);

    NAPinAnnotation *annotation = [self.annotations objectAtIndex:rand];
    if (annotation == self.lastFocused && self.annotations.count > 1) {
        rand = ((rand + 1) % (int)self.annotations.count);
        annotation = [self.annotations objectAtIndex:rand];
    }

    [self selectPin:annotation];
}

- (void)selectPinAt:(NSInteger)index
{
    [self selectPin:[self.annotations objectAtIndex:index]];
}

- (void)selectPin:(NAPinAnnotation *)annotation
{
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
