//
// NAMapView.h
// NAMapKit
//
// Created by Neil Ang on 21/07/10.
// Copyright 2010 neilang.com. All rights reserved.
//

#import "NAMapView.h"

const CGFloat zoomStep = 1.5f;

@interface NAMapView()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGSize originalSize;
@property (nonatomic, readonly) NSMutableArray *annotations;

-(void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer;
-(void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer;

@end

@implementation NAMapView

-(void)createImageView
{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.imageView];
}

-(void)setupMap {
    self.delegate = self;

    UITapGestureRecognizer *doubleTap    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
	UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];

	[doubleTap setNumberOfTapsRequired:2];
	[twoFingerTap setNumberOfTouchesRequired:2];

	[self addGestureRecognizer:doubleTap];
	[self addGestureRecognizer:twoFingerTap];

    [self createImageView];
    
    _annotations = [NSMutableArray array];
    
    [self.panGestureRecognizer addTarget:self action:@selector(mapPanGestureHandler:)];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupMap];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupMap];
    }
    return self;
}

- (void)mapPanGestureHandler:(UIPanGestureRecognizer *)panGesture
{
    if (panGesture.state == UIGestureRecognizerStateBegan){
        _centerPoint = CGPointZero;
    }
}

- (void)displayMap:(UIImage *)map{
    self.imageView.frame = CGRectMake(0.0f, 0.0f, map.size.width, map.size.height);
    self.imageView.image = map;
    CGRect imageFrame = self.imageView.frame;
    self.originalSize = CGSizeMake(CGRectGetWidth(imageFrame), CGRectGetHeight(imageFrame));
    self.contentSize = self.originalSize;
}

- (void)addAnnotation:(NAAnnotation *)annotation animated:(BOOL)animate {
    [annotation addToMapView:self animated:animate];
    [self.annotations addObject:annotation];
}

- (void)addAnnotations:(NSArray *)annotations animated:(BOOL)animate {
	for (NAAnnotation *annotation in annotations) {
        [self addAnnotation:annotation animated:animate];
	}
}

-(void)removeAnnotation:(NAAnnotation *)annotation {
    [annotation removeFromMapView];
    [self.annotations removeObject:annotation];
}

- (void)centreOnPoint:(CGPoint)point animated:(BOOL)animate {
	float x = (point.x * self.zoomScale) - (self.frame.size.width / 2.0f);
	float y = (point.y * self.zoomScale) - (self.frame.size.height / 2.0f);
	[self setContentOffset:CGPointMake(round(x), round(y)) animated:animate];
    _centerPoint = point;
}

-(CGPoint)zoomRelativePoint:(CGPoint)point{
    float x = (self.contentSize.width / self.originalSize.width) * point.x;
    float y = (self.contentSize.height / self.originalSize.height) * point.y;
    return CGPointMake(round(x), round(y));
}

-(void)selectAnnotation:(NAAnnotation *)annotation animated:(BOOL)animate
{
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    BOOL zoomedOut = self.zoomScale == self.minimumZoomScale;
    if (!CGPointEqualToPoint(self.centerPoint, CGPointZero) && !zoomedOut) {
        [self centreOnPoint:self.centerPoint animated:NO];
    }
}

#pragma mark - UIScrollViewDelegate

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self.mapViewDelegate mapView:self hasChangedZoomLevel:self.zoomLevel];
}

-(CGFloat)zoomLevel
{
    return self.zoomScale / self.maximumZoomScale;
}

#pragma mark - Tap to Zoom

-(void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
	// double tap zooms in, but returns to normal zoom level if it reaches max zoom
	float newScale = self.zoomScale >= self.maximumZoomScale ? self.minimumZoomScale : self.zoomScale * zoomStep;
	[self setZoomScale:newScale animated:YES];
}

-(void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer {
	// two-finger tap zooms out, but returns to normal zoom level if it reaches min zoom
	float newScale = self.zoomScale <= self.minimumZoomScale ? self.maximumZoomScale : self.zoomScale / zoomStep;
	[self setZoomScale:newScale animated:YES];
}

@end
