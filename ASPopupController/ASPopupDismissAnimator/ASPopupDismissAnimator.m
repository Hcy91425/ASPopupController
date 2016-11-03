//
//  ASPopupDismissAnimator.m
//  ASPopupControllerDemo
//
//  Created by Cyrus on 16/11/3.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import "ASPopupDismissAnimator.h"
#import "ASPopupController.h"

@implementation ASPopupDismissAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (self.dismissStyle) {
        case ASPopupDismissStyleFadeOut:
            return 0.15;
        case ASPopupDismissStyleContractHorizontal:
            return 0.2;
        case ASPopupDismissStyleContractVertical:
            return 0.2;
        case ASPopupDismissStyleSlideDown:
            return 0.25;
        case ASPopupDismissStyleSlideUp:
            return 0.25;
        case ASPopupDismissStyleSlideLeft:
            return 0.2;
        case ASPopupDismissStyleSlideRight:
            return 0.2;
    }
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    [self animateWithStyle:self.dismissStyle context:transitionContext];
}

- (void)animateWithStyle:(ASPopupDismissStyle)style context:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (self.dismissStyle) {
        case ASPopupDismissStyleFadeOut:
            [self fadeOutAnimationWithContext:transitionContext];
            break;
        case ASPopupDismissStyleContractHorizontal:
            [self contractHorizontalAnimationWithContext:transitionContext];
            break;
        case ASPopupDismissStyleContractVertical:
            [self contractVerticalAnimationWithContext:transitionContext];
            break;
        case ASPopupDismissStyleSlideDown:
            [self slideDownAnimationWithContext:transitionContext];
            break;
        case ASPopupDismissStyleSlideUp:
            [self slideUpAnimationWithContext:transitionContext];
            break;
        case ASPopupDismissStyleSlideLeft:
            [self slideLeftAnimationWithContext:transitionContext];
            break;
        case ASPopupDismissStyleSlideRight:
            [self slideRightAnimationWithContext:transitionContext];
            break;
    }
}

- (void)fadeOutAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                     animations:^{
                         fromVC.view.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)contractHorizontalAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    ASPopupController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                     animations:^{
                         fromVC.backgroundView.alpha = 0;
                         fromVC.alertView.transform = CGAffineTransformMakeScale(0.001, 1);
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)contractVerticalAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    ASPopupController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                     animations:^{
                         fromVC.backgroundView.alpha = 0;
                         fromVC.alertView.transform = CGAffineTransformMakeScale(1, 0.01);
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)slideDownAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    ASPopupController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                     animations:^{
                         fromVC.backgroundView.alpha = 0;
                         fromVC.alertView.center = CGPointMake(fromVC.view.center.x, fromVC.view.frame.size.height + fromVC.alertView.frame.size.height/2.0);
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)slideUpAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    ASPopupController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                     animations:^{
                         fromVC.backgroundView.alpha = 0;
                         fromVC.alertView.center = CGPointMake(fromVC.view.center.x, -fromVC.alertView.frame.size.height/2.0);
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)slideLeftAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    ASPopupController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                     animations:^{
                         fromVC.backgroundView.alpha = 0;
                         fromVC.alertView.center = CGPointMake(-fromVC.alertView.frame.size.width/2.0, fromVC.view.center.y);
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)slideRightAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    ASPopupController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                     animations:^{
                         fromVC.backgroundView.alpha = 0;
                         fromVC.alertView.center = CGPointMake(fromVC.view.frame.size.width + fromVC.alertView.frame.size.width/2.0, fromVC.view.center.y);
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

@end
