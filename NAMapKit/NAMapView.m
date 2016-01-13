//
//  NAMapView.m
//  NAMapKit
//
//  Created by Neil Ang on 21/07/10.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NAMapView.h"

const CGFloat NAMapViewDefaultZoomStep = 1.5f;

@interface NAMapView()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, readonly) NSMutableArray *annotations;
@property (nonatomic, assign) BOOL contentSizeObserving;

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer;
- (void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer;

@end

@implementation NAMapView

- (void)createImageView
{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.imageView];
}

- (void)setupMap
{
    self.delegate = self;

    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
	UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];

	[doubleTap setNumberOfTapsRequired:2];
    
	[twoFingerTap setNumberOfTouchesRequired:2];

	[self addGestureRecognizer:doubleTap];
	[self addGestureRecognizer:twoFingerTap];

    [self createImageView];

    _annotations = [NSMutableArray array];
    _zoomStep = NAMapViewDefaultZoomStep;
    _doubleTapGesture = doubleTap;
    _twoFingerTapGesture = twoFingerTap;

    [self.panGestureRecognizer addTarget:self action:@selector(mapPanGestureHandler:)];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupMap];
}

- (id)initWithFrame:(CGRect)frame
{
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

- (void)registerObservers
{
    if (!self.contentSizeObserving) {
        [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        _contentSizeObserving = YES;
    }
}

- (void)displayMap:(UIImage *)map
{
    self.imageView.frame = CGRectMake(0.0f, 0.0f, map.size.width, map.size.height);
    self.imageView.image = map;
    CGRect imageFrame = self.imageView.frame;
    self.originalSize = CGSizeMake(CGRectGetWidth(imageFrame), CGRectGetHeight(imageFrame));
    self.contentSize = self.originalSize;
}

- (void)addAnnotation:(NAAnnotation *)annotation animated:(BOOL)animate
{
    [annotation addToMapView:self animated:animate];
    [self.annotations addObject:annotation];
}

- (void)addAnnotations:(NSArray *)annotations animated:(BOOL)animate
{
	for (NAAnnotation *annotation in annotations) {
        [self addAnnotation:annotation animated:animate];
	}
}

- (void)removeAnnotation:(NAAnnotation *)annotation
{
    [annotation removeFromMapView];
    [self.annotations removeObject:annotation];
}

- (void)centerOnPoint:(CGPoint)point animated:(BOOL)animate
{
	CGFloat x = (point.x * self.zoomScale) - (self.frame.size.width / 2.0f);
	CGFloat y = (point.y * self.zoomScale) - (self.frame.size.height / 2.0f);
	[self setContentOffset:CGPointMake(round(x), round(y)) animated:animate];
    _centerPoint = point;
}

- (void)updateContentOffsetToCenterPoint:(CGPoint)point animated:(BOOL)animate
{
	CGFloat x = point.x - (self.frame.size.width / 2.0f);
	CGFloat y = point.y - (self.frame.size.height / 2.0f);
	[self setContentOffset:CGPointMake(round(x), round(y)) animated:animate];
}

- (CGPoint)zoomRelativePoint:(CGPoint)point
{
    BOOL hasContentSize = ABS(self.originalSize.width) > 0 && ABS(self.originalSize.height) > 0;
    NSAssert(hasContentSize, @"originalSize dimension is zero, will result in NaN in returned value.");
    
    CGFloat x = (self.contentSize.width / self.originalSize.width) * point.x;
    CGFloat y = (self.contentSize.height / self.originalSize.height) * point.y;
    return CGPointMake(round(x), round(y));
}

- (void)selectAnnotation:(NAAnnotation *)annotation animated:(BOOL)animate
{
    [self centerOnPoint:annotation.point animated:animate];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];

    BOOL zoomedOut = self.zoomScale == self.minimumZoomScale;
    if (!CGPointEqualToPoint(self.centerPoint, CGPointZero) && !zoomedOut) {
        [self centerOnPoint:self.centerPoint animated:NO];
    }
    
    if (!CGRectIsEmpty(frame)) {
        [self registerObservers];
    }
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    if ([self.mapViewDelegate respondsToSelector:@selector(mapView:hasChangedZoomLevel:)]) {
        [self.mapViewDelegate mapView:self hasChangedZoomLevel:self.zoomLevel];
    }
}

- (CGFloat)zoomLevel
{
    return self.zoomScale / self.maximumZoomScale;
}

#pragma mark - Tap to Zoom

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer
{
	// double tap zooms in, but returns to normal zoom level if it reaches max zoom
    if (self.zoomScale >= self.maximumZoomScale) {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    } else {
        // the location tapped becomes the new center
        CGPoint tapCenter = [gestureRecognizer locationInView:self.imageView];
        CGFloat newScale = MIN(self.zoomScale * self.zoomStep, self.maximumZoomScale);
        CGRect maxZoomRect = [self rectAroundPoint:tapCenter atZoomScale:newScale];
        [self zoomToRect:maxZoomRect animated:YES];
    }
}

- (CGRect)rectAroundPoint:(CGPoint)point atZoomScale:(CGFloat)zoomScale
{
    // define the shape of the zoom rect
    CGSize boundsSize = self.bounds.size;
    // modify the size according to the requested zoom level
    // for example, if we're zooming in to 0.5 zoom, then this will increase the bounds size by a factor of two
    CGSize scaledBoundsSize = CGSizeMake(boundsSize.width / zoomScale, boundsSize.height / zoomScale);

    return CGRectMake(point.x - scaledBoundsSize.width / 2,
                      point.y - scaledBoundsSize.height / 2,
                      scaledBoundsSize.width,
                      scaledBoundsSize.height);
}

- (void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer
{
	// two-finger tap zooms out, but returns to normal zoom level if it reaches min zoom
	CGFloat newScale = self.zoomScale <= self.minimumZoomScale ? self.maximumZoomScale : self.zoomScale / self.zoomStep;
	[self setZoomScale:newScale animated:YES];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
        [self updatePositions];
    }
}

- (void)updatePositions
{
    [self.annotations makeObjectsPerformSelector:@selector(updatePosition)];
}

- (void)dealloc
{
    if (self.contentSizeObserving) {
        [self removeObserver:self forKeyPath:@"contentSize"];
    }
}

@end
