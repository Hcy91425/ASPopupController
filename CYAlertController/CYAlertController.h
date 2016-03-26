//
//  CYAlertController.h
//  CYAlertController
//
//  Created by Cyrus on 16/3/26.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import <UIKit/UIKit.h>

// 灰色背景透明度
static const CGFloat backgroundAlpha = 0.4;

typedef void (^EmptyBlock) ();

// present style
typedef NS_ENUM(NSInteger, CYAlertPresentStyle) {
    CYAlertPresentStyleSystem,          // 系统样式
    CYAlertPresentStyleFadeIn,          // 渐入
    CYAlertPresentStyleBounce,          // 弹出
    CYAlertPresentStyleExpandHorizontal,// 水平展开
    CYAlertPresentStyleExpandVertical,  // 垂直展开
    CYAlertPresentStyleSlideDown,       // 从上往下划入
    CYAlertPresentStyleSlideUp,         // 从下往上划入
    CYAlertPresentStyleSlideLeft,       // 从右往左划入
    CYAlertPresentStyleSlideRight,      // 从左往右划入
};

// dismiss style
typedef NS_ENUM(NSInteger, CYAlertDismissStyle) {
    CYAlertDismissStyleFadeOut,             // 渐出
    CYAlertDismissStyleContractHorizontal,  // 水平收起
    CYAlertDismissStyleContractVertical,    // 垂直收起
    CYAlertDismissStyleSlideDown,           // 向下划出
    CYAlertDismissStyleSlideUp,             // 向上划出
    CYAlertDismissStyleSlideLeft,           // 向左划出
    CYAlertDismissStyleSlideRight,          // 向右划出
};

@interface CYAlertController : UIViewController
@property (nonatomic, strong)UIView *alertView;
@property (nonatomic, strong)UIView *backgroundView;
@property (nonatomic, assign)CYAlertPresentStyle presentStyle;
@property (nonatomic, assign)CYAlertDismissStyle dismissStyle;


/**
 *    自定义 alertView， 自定义style
 *
 *    @param customView   自定义view
 *    @param presentStyle present风格
 *    @param dismissStyle dismiss风格
 */
+ (instancetype)alertWithCustomView:(UIView *)customView presentStyle:(CYAlertPresentStyle)presentStyle dismissStyle:(CYAlertDismissStyle)dismissStyle;

/**
 *    左右两个按钮，自定义style
 *
 *    @param title             标题
 *    @param message           信息
 *    @param leftButtonTitle   左边的按钮标题
 *    @param leftButtonAction  左边按钮事件
 *    @param rightButtonTitle  右边按钮标题
 *    @param rightButtonAction 右边按钮事件
 *    @param presentStyle      present风格
 *    @param dismissStyle      dismiss风格
 */
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message leftButtonTitle:(NSString *)leftButtonTitle leftButtonAction:(EmptyBlock)leftButtonAction rightButtonTitle:(NSString *)rightButtonTitle rightButtonAction:(EmptyBlock)rightButtonAction presentStyle:(CYAlertPresentStyle)presentStyle dismissStyle:(CYAlertDismissStyle)dismissStyle;

/**
 *    一个按钮，自定义style
 *
 *    @param title        标题
 *    @param message      信息
 *    @param buttonTitle  按钮标题
 *    @param buttonAction 按钮事件
 *    @param presentStyle present风格
 *    @param dismissStyle dismiss风格
 */
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle buttonAction:(EmptyBlock)buttonAction presentStyle:(CYAlertPresentStyle)presentStyle dismissStyle:(CYAlertDismissStyle)dismissStyle;

/**
 *    两个按钮，默认style
 *
 *    @param title             标题
 *    @param message           信息
 *    @param leftButtonTitle   左边的按钮标题
 *    @param leftButtonAction  左边按钮事件
 *    @param rightButtonTitle  右边按钮标题
 *    @param rightButtonAction 右边按钮事件
 */
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message leftButtonTitle:(NSString *)leftButtonTitle leftButtonAction:(EmptyBlock)leftButtonAction rightButtonTitle:(NSString *)rightButtonTitle rightButtonAction:(EmptyBlock)rightButtonAction ;


/**
 *    一个按钮，默认风格
 *
 *    @param title        标题
 *    @param message      信息
 *    @param buttonTitle  按钮标题
 *    @param buttonAction 按钮事件
 */
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle buttonAction:(EmptyBlock)buttonAction ;
@end
