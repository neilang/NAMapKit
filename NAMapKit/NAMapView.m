//
// NAMapView.h
// NAMapKit
//
// Created by Neil Ang on 21/07/10.
// Copyright 2010 neilang.com. All rights reserved.
//

#import "NAMapView.h"
#import "NAPinAnnotationView.h"
#import "NACallOutView.h"

#define NA_PIN_ANIMATION_DURATION 0.5f
#define NA_CALLOUT_ANIMATION_DURATION 0.1f
#define NA_ZOOM_STEP 1.5

@interface NAMapView()

@property (nonatomic, strong) UIImageView    *imageView;
@property (nonatomic, strong) NACallOutView  *calloutView;
@property (nonatomic, strong) NSMutableArray *annotationViews;
@property (nonatomic, assign) CGSize orignalSize;

-(void)addAnimatedAnnontation:(NAAnnotation *)annontation;
-(IBAction)showCallOut:(id)sender;
-(void)hideCallOut;
-(void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer;
-(void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer;
-(void)viewSetup;

@end

@implementation NAMapView

@synthesize imageView       = _imageView; 
@synthesize orignalSize     = _orignalSize;
@synthesize calloutView     = _calloutView;
@synthesize annotationViews = _annotationViews;

-(void)viewSetup{
    self.delegate = self;
    
    UITapGestureRecognizer *doubleTap    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
	UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
    
	[doubleTap setNumberOfTapsRequired:2];
	[twoFingerTap setNumberOfTouchesRequired:2];
    
	[self addGestureRecognizer:doubleTap];
	[self addGestureRecognizer:twoFingerTap];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.imageView];
    
    self.calloutView = [[NACallOutView alloc] initOnMapView:self];
    [self addObserver:self.calloutView forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    [self addSubview:self.calloutView];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self viewSetup];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self viewSetup];
    }
    return self;
}

- (void)displayMap:(UIImage *)map{
    self.imageView.frame = CGRectMake(0.0f, 0.0f, map.size.width, map.size.height);
    self.imageView.image = map;
    CGRect imageFrame    = self.imageView.frame;
    self.orignalSize     = CGSizeMake(CGRectGetWidth(imageFrame), CGRectGetHeight(imageFrame));
    self.contentSize     = self.orignalSize;
}

-(void)addAnimatedAnnontation:(NAAnnotation *)annontation {
    [self addAnnotation:annontation animated:YES];
}

- (void)addAnnotation:(NAAnnotation *)annotation animated:(BOOL)animate {
    
    NAPinAnnotationView *annontationView = [[NAPinAnnotationView alloc] initWithAnnotation:annotation onMapView:self];
    
    [annontationView addTarget:self action:@selector(showCallOut:) forControlEvents:UIControlEventTouchDown];
    [self addObserver:annontationView forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
    if(animate){
        annontationView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0.0f, -annontationView.center.y);
    }
    
    [self addSubview:annontationView];
    
    if(animate){
        annontationView.animating = YES;
        [UIView animateWithDuration:NA_PIN_ANIMATION_DURATION animations:^{
            annontationView.transform = CGAffineTransformIdentity;
        }
        completion:^ (BOOL finished) {
            annontationView.animating = NO;
        }];
    }
    
    if(!self.annotationViews){
        self.annotationViews = [[NSMutableArray alloc] init];
    }
    
    [self.annotationViews addObject:annontationView];
    [self bringSubviewToFront:self.calloutView];
}

- (void)addAnnotations:(NSArray *)annotations animated:(BOOL)animate {
    int i = 0;
	for (NAAnnotation *annotation in annotations) {
        if(animate){
            [self performSelector:@selector(addAnimatedAnnontation:) withObject:annotation afterDelay:(NA_PIN_ANIMATION_DURATION * (i++ / 2.0f))];
        }
        else{
            [self addAnnotation:annotation animated:NO];
        }
		
	}
}

// Untested!!
-(void)removeAnnotation:(NAAnnotation *)annotation{
    for(NAPinAnnotationView *annotationView in self.annotationViews){
        if (annotationView.annotation == annotation) {
            [annotationView removeFromSuperview];
            [self removeObserver:annotationView forKeyPath:@"contentSize"];
            [self.annotationViews removeObject:annotationView];
            break;
        }
    }
}

- (IBAction)showCallOut:(id)sender {
    
    if(![sender isKindOfClass:[NAPinAnnotationView class]]) return;
    
    NAPinAnnotationView *annontationView = (NAPinAnnotationView *)sender;
    NAAnnotation        *annotation      = annontationView.annotation;
    
    if(!annotation || !annotation.title) return;
    
    [self hideCallOut];
    
    [self.calloutView setAnnotation:annotation];
    
    [self centreOnPoint:annotation.point animated:YES];
    
    self.calloutView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4f, 0.4f);
    self.calloutView.hidden    = NO;
    
    [UIView animateWithDuration:NA_CALLOUT_ANIMATION_DURATION animations:^{
        self.calloutView.transform = CGAffineTransformIdentity;
    }];
}

- (void)centreOnPoint:(CGPoint)point animated:(BOOL)animate {
	float x = (point.x * self.zoomScale) - (self.frame.size.width / 2.0f);
	float y = (point.y * self.zoomScale) - (self.frame.size.height / 2.0f);
	[self setContentOffset:CGPointMake(round(x), round(y)) animated:animate];
}

- (void)hideCallOut {
	self.calloutView.hidden = YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if (!self.dragging) {
		[self hideCallOut];
	}
    
	[super touchesEnded:touches withEvent:event];
}

-(CGPoint)zoomRelativePoint:(CGPoint)point{
    float x = (self.contentSize.width / self.orignalSize.width) * point.x;
    float y = (self.contentSize.height / self.orignalSize.height) * point.y;
    return CGPointMake(round(x), round(y));
}

- (void)dealloc {
    for(NAPinAnnotationView *annotationView in self.annotationViews){
        [self removeObserver:annotationView forKeyPath:@"contentSize"];
    }
    
    if(self.calloutView){
        [self removeObserver:self.calloutView forKeyPath:@"contentSize"];
    }
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return self.imageView;
}

#pragma mark - Tap to Zoom

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
	// double tap zooms in, but returns to normal zoom level if it reaches max zoom
	float  newScale = self.zoomScale >= self.maximumZoomScale ? self.minimumZoomScale : self.zoomScale * NA_ZOOM_STEP;
	[self setZoomScale:newScale animated:YES];
}

- (void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer {
	// two-finger tap zooms out, but returns to normal zoom level if it reaches min zoom
	float  newScale = self.zoomScale <= self.minimumZoomScale ? self.maximumZoomScale : self.zoomScale / NA_ZOOM_STEP;
	[self setZoomScale:newScale animated:YES];
}

@end

#undef NA_PIN_ANIMATION_DURATION
#undef NA_CALLOUT_ANIMATION_DURATION
#undef NA_ZOOM_STEP