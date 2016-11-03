//
//  ASPopupPresentAnimator.h
//  ASPopupControllerDemo
//
//  Created by Cyrus on 16/11/3.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASPopupHeader.h"

@interface ASPopupPresentAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic) ASPopupPresentStyle presentStyle;

@end
