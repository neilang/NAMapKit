//
//  NAPinAnnotationPopupCircleCallOutView.h
//  Pods
//
//  Created by xdzhangm on 16/4/29.
//
//
/*
                    |
                    |
                    |
                topLine
                    |
                    |
                    |
        b1                      b0
 
 
    b3      |  CenterView   |        b2
 
 
    b5                               b4
                    |
 
                    b6
 */
#import <UIKit/UIKit.h>

#import "NAMapView.h"
#import "NAPinAnnotation.h"

@protocol NAPinAnnotationPopupCircleCallOutViewDelegate <NSObject>
@required
- (NSInteger)numbersOfCircleForCallOutView;
@end

@interface NAPinAnnotationPopupCircleCallOutView : UIView
- (id)initOnMapView:(NAMapView *)mapView;
- (void)showMenuAtPoint:(CGPoint)point;
- (void)hideMenu:(BOOL)animated;
- (void)updatePosition;
- (void)setTitle:(NSString *)title;

// left side index: 1, 3, 5
// right side index: 0, 2, 4
- (UIButton *)menuAtIndex:(NSInteger)index;
@property (nonatomic, weak)   NAMapView *mapView;
@property (nonatomic, weak) id<NAPinAnnotationPopupCircleCallOutViewDelegate> delegate;
@property (readwrite, nonatomic, strong) NAPinAnnotation *annotation;
@end
