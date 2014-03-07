//
// NAPinAnnotationMapView.m
//
//  Created by Daniel Doubrovkine on 3/7/14.
//

#import "NAPinAnnotationMapView.h"

#define NA_CALLOUT_ANIMATION_DURATION 0.1f

@interface NAPinAnnotationMapView()

@property (nonatomic, strong) NAPinAnnotationCallOutView  *calloutView;

-(IBAction)showCallOut:(id)sender;
-(void)hideCallOut;

@end

@implementation NAPinAnnotationMapView

-(void)setupMap
{
    [super setupMap];
    
    self.calloutView = [[NAPinAnnotationCallOutView alloc] initOnMapView:self];
    [self addObserver:self.calloutView forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    [self addSubview:self.calloutView];
}

-(UIView *)addAnnotation:(NAAnnotation *)annotation animated:(BOOL)animate {
    UIButton *annontationView = (UIButton *) [super addAnnotation:annotation animated:animate];
    [annontationView addTarget:self action:@selector(showCallOut:) forControlEvents:UIControlEventTouchDown];
    [self bringSubviewToFront:self.calloutView];
    return annontationView;
}

- (void)selectAnnotation:(NAAnnotation *)annotation animated:(BOOL)animate {
    [self hideCallOut];
    [self showCalloutForAnnotation:(NAPinAnnotation *)annotation animated:animate];
}

-(void)removeAnnotation:(NAAnnotation *)annotation{
    [self hideCallOut];
    [super removeAnnotation:annotation];
}

-(IBAction)showCallOut:(id)sender {
    if(![sender isKindOfClass:[NAPinAnnotationView class]]) return;
    NAPinAnnotationView *annontationView = (NAPinAnnotationView *)sender;
    [self showCalloutForAnnotation:annontationView.annotation animated:YES];
}

-(void)showCalloutForAnnotation:(NAPinAnnotation *)annotation animated:(BOOL)animated {
    
    [self hideCallOut];
    
    [self.calloutView setAnnotation:annotation];
    
    [self centreOnPoint:annotation.point animated:animated];
    
    CGFloat animationDuration = animated ? NA_CALLOUT_ANIMATION_DURATION : 0.0f;
    
    self.calloutView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4f, 0.4f);
    self.calloutView.hidden    = NO;
    
    [UIView animateWithDuration:animationDuration animations:^{
        self.calloutView.transform = CGAffineTransformIdentity;
    }];    
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

- (void)dealloc {
    if(self.calloutView) {
        [self removeObserver:self.calloutView forKeyPath:@"contentSize"];
    }
}

@end

#undef NA_CALLOUT_ANIMATION_DURATION
