//
//  ASPopupController.h
//  ASPopupController
//
//  Created by Cyrus on 16/3/26.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASPopupAction.h"

@class ASPopupView;

/** 灰色背景透明度 */
static const CGFloat as_backgroundAlpha = 0.4;

/** present style */
typedef NS_ENUM(NSInteger, ASPopupPresentStyle) {
    ASPopupPresentStyleSystem,          // 系统样式
    ASPopupPresentStyleFadeIn,          // 渐入
    ASPopupPresentStyleBounce,          // 弹出
    ASPopupPresentStyleExpandHorizontal,// 水平展开
    ASPopupPresentStyleExpandVertical,  // 垂直展开
    ASPopupPresentStyleSlideDown,       // 从上往下划入
    ASPopupPresentStyleSlideUp,         // 从下往上划入
    ASPopupPresentStyleSlideLeft,       // 从右往左划入
    ASPopupPresentStyleSlideRight,      // 从左往右划入
    ASPopupPresentStyleFlipHorizontal   // 水平翻转
};

/** dismiss style */
typedef NS_ENUM(NSInteger, ASPopupDismissStyle) {
    ASPopupDismissStyleFadeOut,             // 渐出
    ASPopupDismissStyleContractHorizontal,  // 水平收起
    ASPopupDismissStyleContractVertical,    // 垂直收起
    ASPopupDismissStyleSlideDown,           // 向下划出
    ASPopupDismissStyleSlideUp,             // 向上划出
    ASPopupDismissStyleSlideLeft,           // 向左划出
    ASPopupDismissStyleSlideRight,          // 向右划出
};

@interface ASPopupController : UIViewController

/** alert 视图 */
@property (nonnull, nonatomic, strong)UIView *alertView;

/** 半透明背景 */
@property (nonnull, nonatomic, strong)UIView *backgroundView;

/** present 转场风格 */
@property (nonatomic, assign)ASPopupPresentStyle presentStyle;

/** dismiss 转场风格 */
@property (nonatomic, assign)ASPopupDismissStyle dismissStyle;

- (void)setAlertViewCornerRadius:(CGFloat)cornerRadius;

/**
 *    添加 action
 *
 *    @param action action
 */
- (void)addAction:(ASPopupAction * _Nonnull)action;

/**
 *    直接添加一个数组的 action
 *
 *    @param actions 放有 action 的数组
 */
- (void)addActions:(NSArray<ASPopupAction *> * _Nonnull)actions;

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
                           presentStyle:(ASPopupPresentStyle)presentStyle
                           dismissStyle:(ASPopupDismissStyle)dismissStyle;

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
