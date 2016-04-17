//
//  CYAlertController.m
//  CYAlertController
//
//  Created by Cyrus on 16/3/26.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import "CYAlertController.h"
#import "CYAlertView.h"

// Present
#import "CYAlertPresentSystem.h"
#import "CYAlertPresentFadeIn.h"
#import "CYAlertPresentBounce.h"
#import "CYAlertPresentExpandHorizontal.h"
#import "CYAlertPresentExpandVertical.h"
#import "CYAlertPresentSlideDown.h"
#import "CYAlertPresentSlideUp.h"
#import "CYAlertPresentSlideLeft.h"
#import "CYAlertPresentSlideRight.h"

// Dismiss
#import "CYAlertDismissFadeOut.h"
#import "CYAlertDismissContractHorizontal.h"
#import "CYAlertDismissContractVertical.h"
#import "CYAlertDismissSlideDown.h"
#import "CYAlertDismissSlideUp.h"
#import "CYAlertDismissSlideLeft.h"
#import "CYAlertDismissSlideRight.h"


@interface CYAlertController ()<UIViewControllerTransitioningDelegate>

@end

@implementation CYAlertController

- (instancetype)init {
    if (self = [super init]) {
        self.transitioningDelegate = self;                          // 设置自己为转场代理
        self.modalPresentationStyle = UIModalPresentationCustom;    // 自定义转场模式
        
        // 灰色半透明背景
        _backgroundView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = cy_backgroundAlpha;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 背景透明
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_backgroundView];
    [self.view addSubview:_alertView];

    // 设置 alertView 在屏幕中心
    [NSLayoutConstraint constraintWithItem:_alertView
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:_alertView
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0
                                  constant:0.0].active = YES;
}

/** 添加 action */
- (void)addAction:(CYAlertAction * _Nonnull)action {
    if ([_alertView isMemberOfClass:[CYAlertView class]]) {
        [(CYAlertView *)_alertView addAction: action];
    }
}

/** 直接添加一个数组的 action */
- (void)addActions:(NSArray<CYAlertAction *> * _Nonnull)actions {
    for (CYAlertAction *action in actions) {
        [self addAction:action];
    }
}

/** 设置 alertView 的圆角半径 */
- (void)setAlertViewCornerRadius:(CGFloat)cornerRadius {
    _alertView.layer.cornerRadius = cornerRadius;
}

#pragma mark - 类方法返回实例

/** 标准初始化方法 */
+ (_Nonnull instancetype)alertWithTitle:(NSString * _Nullable)title
                                message:(NSString * _Nullable)message
                           presentStyle:(CYAlertPresentStyle)presentStyle
                           dismissStyle:(CYAlertDismissStyle)dismissStyle {
    
    CYAlertController *alertController = [[CYAlertController alloc] init];
    alertController.presentStyle = presentStyle;
    alertController.dismissStyle = dismissStyle;
    alertController.alertView = [[CYAlertView alloc] initWithTitle:title message:message];
    ((CYAlertView *)(alertController.alertView)).controller = alertController;
    return alertController;
}

/** 默认转场初始化 */
+ (_Nonnull instancetype)alertWithTitle:(NSString * _Nullable)title
                                message:(NSString * _Nullable)message {
    
    CYAlertController *alertController = [[CYAlertController alloc] init];
    alertController.presentStyle = CYAlertPresentStyleSystem;
    alertController.dismissStyle = CYAlertDismissStyleFadeOut;
    alertController.alertView = [[CYAlertView alloc] initWithTitle:title message:message];
    ((CYAlertView *)(alertController.alertView)).controller = alertController;
    return alertController;
}

#pragma mark - UIViewControllerTransitioningDelegate

/** 返回Present动画 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    switch (_presentStyle) {
        case CYAlertPresentStyleFadeIn:
            return [[CYAlertPresentFadeIn alloc] init];
            break;
        case CYAlertPresentStyleBounce:
            return [[CYAlertPresentBounce alloc] init];
            break;
        case CYAlertPresentStyleExpandHorizontal:
            return [[CYAlertPresentExpandHorizontal alloc] init];
            break;
        case CYAlertPresentStyleExpandVertical:
            return [[CYAlertPresentExpandVertical alloc] init];
            break;
        case CYAlertPresentStyleSlideDown:
            return [[CYAlertPresentSlideDown alloc] init];
            break;
        case CYAlertPresentStyleSlideUp:
            return [[CYAlertPresentSlideUp alloc] init];
            break;
        case CYAlertPresentStyleSlideLeft:
            return [[CYAlertPresentSlideLeft alloc] init];
            break;
        case CYAlertPresentStyleSlideRight:
            return [[CYAlertPresentSlideRight alloc] init];
        default:
            return [[CYAlertPresentSystem alloc] init];
            break;
    }
}

/** 返回Dismiss动画 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    switch (_dismissStyle) {
        case CYAlertDismissStyleContractHorizontal:
            return [[CYAlertDismissContractHorizontal alloc] init];
            break;
        case CYAlertDismissStyleContractVertical:
            return [[CYAlertDismissContractVertical alloc] init];
            break;
        case CYAlertDismissStyleSlideDown:
            return [[CYAlertDismissSlideDown alloc] init];
            break;
        case CYAlertDismissStyleSlideUp:
            return [[CYAlertDismissSlideUp alloc] init];
            break;
        case CYAlertDismissStyleSlideLeft:
            return [[CYAlertDismissSlideLeft alloc] init];
            break;
        case CYAlertDismissStyleSlideRight:
            return [[CYAlertDismissSlideRight alloc] init];
            break;
        default:
            return [[CYAlertDismissFadeOut alloc] init];
            break;
    }
}

@end
