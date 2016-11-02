//
//  ASPopupController.m
//  ASPopupController
//
//  Created by Cyrus on 16/3/26.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import "ASPopupController.h"
#import "ASPopupView.h"

// Present
#import "ASPopupPresentSystem.h"
#import "ASPopupPresentFadeIn.h"
#import "ASPopupPresentBounce.h"
#import "ASPopupPresentExpandHorizontal.h"
#import "ASPopupPresentExpandVertical.h"
#import "ASPopupPresentSlideDown.h"
#import "ASPopupPresentSlideUp.h"
#import "ASPopupPresentSlideLeft.h"
#import "ASPopupPresentSlideRight.h"

// Dismiss
#import "ASPopupDismissFadeOut.h"
#import "ASPopupDismissContractHorizontal.h"
#import "ASPopupDismissContractVertical.h"
#import "ASPopupDismissSlideDown.h"
#import "ASPopupDismissSlideUp.h"
#import "ASPopupDismissSlideLeft.h"
#import "ASPopupDismissSlideRight.h"


@interface ASPopupController ()<UIViewControllerTransitioningDelegate>

@end

@implementation ASPopupController

- (instancetype)init {
    if (self = [super init]) {
        self.transitioningDelegate = self;                          // 设置自己为转场代理
        self.modalPresentationStyle = UIModalPresentationCustom;    // 自定义转场模式
        
        // 灰色半透明背景
        _backgroundView = [[UIView alloc] init];
        _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = as_backgroundAlpha;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 背景透明
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_backgroundView];
    [self.view addSubview:_alertView];
    
    // 设置灰色半透明背景的约束
    [NSLayoutConstraint constraintWithItem:_backgroundView
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:0.0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:_backgroundView
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:0.0].active = YES;

    [NSLayoutConstraint constraintWithItem:_backgroundView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:0.0].active = YES;

    [NSLayoutConstraint constraintWithItem:_backgroundView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0.0].active = YES;


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
- (void)addAction:(ASPopupAction * _Nonnull)action {
    if ([_alertView isMemberOfClass:[ASPopupView class]]) {
        [(ASPopupView *)_alertView addAction: action];
    }
}

/** 直接添加一个数组的 action */
- (void)addActions:(NSArray<ASPopupAction *> * _Nonnull)actions {
    for (ASPopupAction *action in actions) {
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
                           presentStyle:(ASPopupPresentStyle)presentStyle
                           dismissStyle:(ASPopupDismissStyle)dismissStyle {
    
    ASPopupController *alertController = [[ASPopupController alloc] init];
    alertController.presentStyle = presentStyle;
    alertController.dismissStyle = dismissStyle;
    alertController.alertView = [[ASPopupView alloc] initWithTitle:title message:message];
    ((ASPopupView *)(alertController.alertView)).controller = alertController;
    return alertController;
}

/** 默认转场初始化 */
+ (_Nonnull instancetype)alertWithTitle:(NSString * _Nullable)title
                                message:(NSString * _Nullable)message {
    
    ASPopupController *alertController = [[ASPopupController alloc] init];
    alertController.presentStyle = ASPopupPresentStyleSystem;
    alertController.dismissStyle = ASPopupDismissStyleFadeOut;
    alertController.alertView = [[ASPopupView alloc] initWithTitle:title message:message];
    ((ASPopupView *)(alertController.alertView)).controller = alertController;
    return alertController;
}

#pragma mark - UIViewControllerTransitioningDelegate

/** 返回Present动画 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    switch (_presentStyle) {
        case ASPopupPresentStyleFadeIn:
            return [[ASPopupPresentFadeIn alloc] init];
            break;
        case ASPopupPresentStyleBounce:
            return [[ASPopupPresentBounce alloc] init];
            break;
        case ASPopupPresentStyleExpandHorizontal:
            return [[ASPopupPresentExpandHorizontal alloc] init];
            break;
        case ASPopupPresentStyleExpandVertical:
            return [[ASPopupPresentExpandVertical alloc] init];
            break;
        case ASPopupPresentStyleSlideDown:
            return [[ASPopupPresentSlideDown alloc] init];
            break;
        case ASPopupPresentStyleSlideUp:
            return [[ASPopupPresentSlideUp alloc] init];
            break;
        case ASPopupPresentStyleSlideLeft:
            return [[ASPopupPresentSlideLeft alloc] init];
            break;
        case ASPopupPresentStyleSlideRight:
            return [[ASPopupPresentSlideRight alloc] init];
        default:
            return [[ASPopupPresentSystem alloc] init];
            break;
    }
}

/** 返回Dismiss动画 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    switch (_dismissStyle) {
        case ASPopupDismissStyleContractHorizontal:
            return [[ASPopupDismissContractHorizontal alloc] init];
            break;
        case ASPopupDismissStyleContractVertical:
            return [[ASPopupDismissContractVertical alloc] init];
            break;
        case ASPopupDismissStyleSlideDown:
            return [[ASPopupDismissSlideDown alloc] init];
            break;
        case ASPopupDismissStyleSlideUp:
            return [[ASPopupDismissSlideUp alloc] init];
            break;
        case ASPopupDismissStyleSlideLeft:
            return [[ASPopupDismissSlideLeft alloc] init];
            break;
        case ASPopupDismissStyleSlideRight:
            return [[ASPopupDismissSlideRight alloc] init];
            break;
        default:
            return [[ASPopupDismissFadeOut alloc] init];
            break;
    }
}

@end
