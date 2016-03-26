//
//  CYAlertController.m
//  CYAlertController
//
//  Created by Cyrus on 16/3/26.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import "CYAlertController.h"

#import "CYAlertPresentSystem.h"
#import "CYAlertPresentFadeIn.h"
#import "CYAlertPresentBounce.h"
#import "CYAlertPresentExpandHorizontal.h"
#import "CYAlertPresentExpandVertical.h"
#import "CYAlertPresentSlideDown.h"
#import "CYAlertPresentSlideUp.h"
#import "CYAlertPresentSlideLeft.h"
#import "CYAlertPresentSlideRight.h"


#import "CYAlertDismissFadeOut.h"
#import "CYAlertDismissContractHorizontal.h"
#import "CYAlertDismissContractVertical.h"
#import "CYAlertDismissSlideDown.h"
#import "CYAlertDismissSlideUp.h"
#import "CYAlertDismissSlideLeft.h"
#import "CYAlertDismissSlideRight.h"




#import "CYAlertView.h"

@interface CYAlertController ()<UIViewControllerTransitioningDelegate>

@end

@implementation CYAlertController

- (instancetype)init {
    if (self = [super init]) {
        self.transitioningDelegate = self;          // 设置自己为转场代理
        self.modalPresentationStyle = UIModalPresentationCustom;    // 自定义转场模式
        
        // 灰色半透明背景
        _backgroundView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.5;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 背景透明
    self.view.backgroundColor = [UIColor clearColor];
    
    // 设置 alertView 在屏幕中心
    _alertView.center = self.view.center;

    [self.view addSubview:_backgroundView];
    [self.view addSubview:_alertView];
}


#pragma mark - 类方法返回实例

// 自定义弹出的view
+ (instancetype)alertWithCustomView:(UIView *)customView presentStyle:(CYAlertPresentStyle)presentStyle dismissStyle:(CYAlertDismissStyle)dismissStyle{
    CYAlertController *alertController = [[CYAlertController alloc] init];
    alertController.presentStyle = presentStyle;
    alertController.dismissStyle = dismissStyle;
    alertController.alertView = customView;
    return alertController;
}

// 完整的初始化方法，供其他初始化方法调用
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message leftButtonTitle:(NSString *)leftButtonTitle leftButtonAction:(EmptyBlock)leftButtonAction rightButtonTitle:(NSString *)rightButtonTitle rightButtonAction:(EmptyBlock)rightButtonAction presentStyle:(CYAlertPresentStyle)presentStyle dismissStyle:(CYAlertDismissStyle)dismissStyle {
    
    CYAlertController *alertController = [[CYAlertController alloc] init];
    alertController.presentStyle = presentStyle;
    alertController.dismissStyle = dismissStyle;
    // 因为 alertView 要持有这两个block，所以传进去的 alertController 要转成 __weak
    __weak CYAlertController *weakAlert = alertController;
    alertController.alertView = [[CYAlertView alloc] initWithTitle:title
                                                           message:message
                                                   leftButtonTitle:leftButtonTitle
                                                  leftButtonAction:^{
                                                      if (leftButtonAction){ leftButtonAction(); }
                                                      [weakAlert dismissViewControllerAnimated:YES completion:nil];
                                                  }
                                                  rightButtonTitle:rightButtonTitle rightButtonAction:^{
                                                      if (rightButtonAction){ rightButtonAction(); }
                                                      [weakAlert dismissViewControllerAnimated:YES completion:nil];
                                                  }];
    return alertController;
    
}

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message leftButtonTitle:(NSString *)leftButtonTitle leftButtonAction:(EmptyBlock)leftButtonAction rightButtonTitle:(NSString *)rightButtonTitle rightButtonAction:(EmptyBlock)rightButtonAction {
    
    CYAlertController *alertController = [self alertWithTitle:title message:message leftButtonTitle:leftButtonTitle leftButtonAction:leftButtonAction rightButtonTitle:rightButtonTitle rightButtonAction:rightButtonAction presentStyle:CYAlertPresentStyleSystem dismissStyle:CYAlertDismissStyleFadeOut];

    return alertController;
}

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle buttonAction:(EmptyBlock)buttonAction presentStyle:(CYAlertPresentStyle)presentStyle dismissStyle:(CYAlertDismissStyle)dismissStyle {
    
    CYAlertController *alertController = [self alertWithTitle:title message:message leftButtonTitle:buttonTitle leftButtonAction:buttonAction rightButtonTitle:nil rightButtonAction:nil presentStyle:presentStyle dismissStyle:dismissStyle];
    
    return alertController;
}

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle buttonAction:(EmptyBlock)buttonAction {
    
    CYAlertController *alertController = [self alertWithTitle:title message:message leftButtonTitle:buttonTitle leftButtonAction:buttonAction rightButtonTitle:nil rightButtonAction:nil presentStyle:CYAlertPresentStyleSystem dismissStyle:CYAlertDismissStyleFadeOut];
    
    return alertController;
}

#pragma mark - UIViewControllerTransitioningDelegate

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
