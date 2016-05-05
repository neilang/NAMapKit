//
//  NAPinAnnotationPopup.h
//  NAMapKit
//
//  Created by xdzhangm on 16/5/4.
//

#import "NAPinAnnotation.h"

// 弹出菜单样式
typedef NS_ENUM(NSInteger, NAPopupMenuStyle)
{
    POP_UP_MENU_STYLE_DEFAULT       = 0,
    POP_UP_MENU_STYLE_CIRCLE        = 1,    // 圆形
};

/**
 *  An annotation that looks like a pin.
 */
@interface NAPinAnnotationPopup : NAPinAnnotation

@property (nonatomic, assign) NAPopupMenuStyle menuStyle;
@property (nonatomic, strong) NSArray *subTitleList;

@end
