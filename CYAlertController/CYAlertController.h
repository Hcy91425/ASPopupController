//
//  CYAlertController.h
//  CYAlertController
//
//  Created by Cyrus on 16/3/26.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYAlertAction.h"

@class CYAlertView;

/** 灰色背景透明度 */
static const CGFloat cy_backgroundAlpha = 0.4;

/** present style */
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

/** dismiss style */
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

/** alert 视图 */
@property (nonnull, nonatomic, strong)UIView *alertView;

/** 半透明背景 */
@property (nonnull, nonatomic, strong)UIView *backgroundView;

/** present 转场风格 */
@property (nonatomic, assign)CYAlertPresentStyle presentStyle;

/** dismiss 转场风格 */
@property (nonatomic, assign)CYAlertDismissStyle dismissStyle;

- (void)setAlertViewCornerRadius:(CGFloat)cornerRadius;

/**
 *    添加 action
 *
 *    @param action action
 */
- (void)addAction:(CYAlertAction * _Nonnull)action;

/**
 *    直接添加一个数组的 action
 *
 *    @param actions 放有 action 的数组
 */
- (void)addActions:(NSArray<CYAlertAction *> * _Nonnull)actions;

/**
 *    标准初始化方法
 *
 *    @param title        标题
 *    @param message      消息
 *    @param presentStyle present 转场风格
 *    @param dismissStyle dismiss 转场风格
 *
 *    @return alert控制器
 */
+ (_Nonnull instancetype)alertWithTitle:(NSString * _Nullable)title
                                message:(NSString * _Nullable)message
                           presentStyle:(CYAlertPresentStyle)presentStyle
                           dismissStyle:(CYAlertDismissStyle)dismissStyle;

/**
 *    默认转场初始化方法
 *
 *    @param title   标题
 *    @param message 消息
 *
 *    @return alert控制器
 */
+ (_Nonnull instancetype)alertWithTitle:(NSString * _Nullable)title
                                message:(NSString * _Nullable)message;

@end
