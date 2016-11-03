//
//  ASPopupPresentAnimator.m
//  ASPopupControllerDemo
//
//  Created by Cyrus on 16/11/3.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import "ASPopupPresentAnimator.h"
#import "ASPopupController.h"

@implementation ASPopupPresentAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (self.presentStyle) {
        case ASPopupPresentStyleSystem:
            return 0.3;
        case ASPopupPresentStyleFadeIn:
            return 0.2;
        case ASPopupPresentStyleBounce:
            return 0.42;
        case ASPopupPresentStyleExpandHorizontal:
            return 0.3;
        case ASPopupPresentStyleExpandVertical:
            return 0.3;
        case ASPopupPresentStyleSlideDown:
            return 0.5;
        case ASPopupPresentStyleSlideUp:
            return 0.5;
        case ASPopupPresentStyleSlideLeft:
            return 0.4;
        case ASPopupPresentStyleSlideRight:
            return 0.4;
    }
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    [self animateWithStyle:self.presentStyle context:transitionContext];
}

- (void)animateWithStyle:(ASPopupPresentStyle)style context:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (style) {
        case ASPopupPresentStyleSystem:
            [self systemAnimationWithContext:transitionContext];
            break;
        case ASPopupPresentStyleFadeIn:
            [self fadeInAnimationWithContext:transitionContext];
            break;
        case ASPopupPresentStyleBounce:
            [self bounceAnimationWithContext:transitionContext];
            break;
        case ASPopupPresentStyleExpandHorizontal:
            [self expandHorizontalAnimationWithContext:transitionContext];
            break;
        case ASPopupPresentStyleExpandVertical:
            [self expandVerticalAnimationWithContext:transitionContext];
            break;
        case ASPopupPresentStyleSlideDown:
            [self slideDownAnimationWithContext:transitionContext];
            break;
        case ASPopupPresentStyleSlideUp:
            [self slideUpAnimationWithContext:transitionContext];
            break;
        case ASPopupPresentStyleSlideLeft:
            [self slideLeftAnimationWithContext:transitionContext];
            break;
        case ASPopupPresentStyleSlideRight:
            [self slideRightAnimationWithContext:transitionContext];
            break;
    }
}

- (void)systemAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    ASPopupController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.backgroundView.alpha = 0;
    toVC.alertView.alpha = 0;
    toVC.alertView.transform = CGAffineTransformMakeScale(1.3, 1.3);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                     animations:^{
                         toVC.backgroundView.alpha = as_backgroundAlpha;
                         toVC.alertView.alpha = 1;
                         toVC.alertView.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)fadeInAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.alpha = 0;
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                     animations:^{
                         toVC.view.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)bounceAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    ASPopupController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.backgroundView.alpha = 0;
    toVC.alertView.alpha = 0;
    toVC.alertView.transform = CGAffineTransformMakeScale(0, 0);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         toVC.backgroundView.alpha = as_backgroundAlpha;
                         toVC.alertView.alpha = 1;
                         toVC.alertView.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)expandHorizontalAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    ASPopupController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.backgroundView.alpha = 0;
    toVC.alertView.alpha = 0;
    toVC.alertView.transform = CGAffineTransformMakeScale(0, 1);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:0.75
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         toVC.backgroundView.alpha = as_backgroundAlpha;
                         toVC.alertView.alpha = 1;
                         toVC.alertView.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)expandVerticalAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    ASPopupController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.backgroundView.alpha = 0;
    toVC.alertView.alpha = 0;
    toVC.alertView.transform = CGAffineTransformMakeScale(1, 0);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:0.75
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         toVC.backgroundView.alpha = as_backgroundAlpha;
                         toVC.alertView.alpha = 1;
                         toVC.alertView.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)slideDownAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    ASPopupController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.backgroundView.alpha = 0;
    toVC.alertView.center = CGPointMake(toVC.view.center.x, -toVC.alertView.frame.size.height/2.0);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         toVC.backgroundView.alpha = as_backgroundAlpha;
                         toVC.alertView.center = toVC.view.center;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)slideUpAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    ASPopupController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.backgroundView.alpha = 0;
    toVC.alertView.center = CGPointMake(toVC.view.center.x, toVC.view.frame.size.height+toVC.alertView.frame.size.height/2.0);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         toVC.backgroundView.alpha = as_backgroundAlpha;
                         toVC.alertView.center = toVC.view.center;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)slideLeftAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    ASPopupController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.backgroundView.alpha = 0;
    toVC.alertView.center = CGPointMake(toVC.view.frame.size.width+toVC.alertView.frame.size.width/2.0, toVC.view.center.y);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         toVC.backgroundView.alpha = as_backgroundAlpha;
                         toVC.alertView.center = toVC.view.center;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)slideRightAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    ASPopupController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.backgroundView.alpha = 0;
    toVC.alertView.center = CGPointMake(-toVC.alertView.frame.size.width/2.0, toVC.view.center.y);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         toVC.backgroundView.alpha = as_backgroundAlpha;
                         toVC.alertView.center = toVC.view.center;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

@end


