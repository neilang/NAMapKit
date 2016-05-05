//
//  NAPinAnnotationPopupMapView.m
//  NAMapKit
//
//  Created by xdzhangm on 16/5/4.
//

#import "NAPinAnnotationPopupMapView.h"
#import "NAPinAnnotationPopupCircleCallOutView.h"
#import <pop/POP.h>

const CGFloat NAMapViewAnnotationCalloutAnimationDemoDuration = 0.1f;

@interface NAPinAnnotationPopupMapView()<NAPinAnnotationPopupCircleCallOutViewDelegate>

@property (nonatomic, strong) NAPinAnnotationCallOutView *calloutView;
@property (nonatomic, strong) NAPinAnnotationPopupCircleCallOutView *circleCalloutView;

- (IBAction)showCallOut:(id)sender;
- (void)hideCallOut;
@end

@implementation NAPinAnnotationPopupMapView

- (void)setupMap
{
    [super setupMap];

    _calloutView = [[NAPinAnnotationCallOutView alloc] initOnMapView:self];
    [self addSubview:self.calloutView];
    
    _circleCalloutView = [[NAPinAnnotationPopupCircleCallOutView alloc] initOnMapView:self];
    _circleCalloutView.delegate = self;
    [self addSubview:_circleCalloutView];
}

- (void)addAnnotation:(NAAnnotation *)annotation animated:(BOOL)animate
{
    [super addAnnotation:annotation animated:animate];
    if ([annotation.view isKindOfClass:NAPinAnnotationView.class]) {
        NAPinAnnotationView *annotationView = (NAPinAnnotationView *) annotation.view;
        [annotationView addTarget:self action:@selector(showCallOut:) forControlEvents:UIControlEventTouchDown];
    }
    [self bringSubviewToFront:self.calloutView];
    [self bringSubviewToFront:self.circleCalloutView];
}

- (void)selectAnnotation:(NAAnnotation *)annotation animated:(BOOL)animate
{
    if([annotation isKindOfClass:NAPinAnnotation.class]) {
        [self showCalloutForAnnotation:(NAPinAnnotation *)annotation animated:animate];
    }
    else{
        [self hideCallOut];
    }
}

- (void)removeAnnotation:(NAAnnotation *)annotation
{
    [self hideCallOut];
    [super removeAnnotation:annotation];
}

- (IBAction)showCallOut:(id)sender
{
    if([sender isKindOfClass:[NAPinAnnotationView class]]) {
        NAPinAnnotationView *annontationView = (NAPinAnnotationView *)sender;
        
        if ([self.mapViewDelegate respondsToSelector:@selector(mapView:tappedOnAnnotation:)]) {
            [self.mapViewDelegate mapView:self tappedOnAnnotation:annontationView.annotation];
        }
        
        [self showCalloutForAnnotation:annontationView.annotation animated:YES];
    }
}

- (void)showCalloutForAnnotation:(NAPinAnnotation *)annotation animated:(BOOL)animated
{
    NSLog(@"%f, %f", annotation.point.x, annotation.point.y);
    
    if(!self.circleCalloutView.hidden)
    {
        [self.circleCalloutView hideMenu:NO];
    }
    else
    {
        [self hideCallOut];
    }
    
    if([annotation isKindOfClass:[NAPinAnnotationPopup class]] && ((NAPinAnnotationPopup *)annotation).menuStyle == POP_UP_MENU_STYLE_CIRCLE)
    {
        NAPinAnnotationPopup *annotationPopup = (NAPinAnnotationPopup *)annotation;
        [self bringSubviewToFront:self.circleCalloutView];
        for(NSInteger i = 0; i < annotationPopup.subTitleList.count; i++)
        {
            NSString *title = annotationPopup.subTitleList[i];
            UIButton *btnView = [self.circleCalloutView menuAtIndex:i];
            [btnView setTitle:title forState:UIControlStateNormal];
        }
        self.circleCalloutView.annotation = annotation;
    }
    else
    {
        self.calloutView.annotation = annotation;
        
        [self centerOnPoint:annotation.point animated:animated];
        
        CGFloat animationDuration = animated ? NAMapViewAnnotationCalloutAnimationDemoDuration : 0.0f;
        
        self.calloutView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4f, 0.4f);
        self.calloutView.hidden = NO;
        
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:animationDuration animations:^{
            weakSelf.calloutView.transform = CGAffineTransformIdentity;
        }];
    }
}

- (void)hideCallOut
{
	self.calloutView.hidden = YES;
    if(!self.circleCalloutView.hidden)
    {
        [self.circleCalloutView hideMenu:YES];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (!self.dragging) {
		[self hideCallOut];
	}

	[super touchesEnded:touches withEvent:event];
}

- (void)updatePositions
{
    [self.calloutView updatePosition];
    [self.circleCalloutView updatePosition];
    [super updatePositions];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(!self.circleCalloutView.hidden)
    {
        [self.circleCalloutView updatePosition];
    }
    [self checkAnnotationViewVisible];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(!self.circleCalloutView.hidden)
    {
        [self.circleCalloutView updatePosition];
    }
    [self checkAnnotationViewVisible];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(!self.circleCalloutView.hidden)
    {
        [self.circleCalloutView updatePosition];
    }
    [self checkAnnotationViewVisible];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [super scrollViewDidZoom:scrollView];
    if(!self.circleCalloutView.hidden)
    {
        [self.circleCalloutView updatePosition];
    }
    [self checkAnnotationViewVisible];
}

- (void)checkAnnotationViewVisible
{
    if(_circleCalloutView.hidden && _calloutView.hidden)
    {
        return;
    }
    UIView *view = _circleCalloutView.hidden ? _calloutView.annotation.view : _circleCalloutView.annotation.view;
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGRect viewBounds = [view convertRect:view.bounds toView:nil];
    if(!CGRectIntersectsRect(viewBounds, screenBounds))
    {
        [self hideCallOut];
    }
}

- (NSInteger)numbersOfCircleForCallOutView
{
    return ((NAPinAnnotationPopup *)_circleCalloutView.annotation).subTitleList.count;
}
@end
