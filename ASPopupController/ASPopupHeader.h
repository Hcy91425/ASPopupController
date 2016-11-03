//
//  ASPopupHeader.h
//  ASPopupControllerDemo
//
//  Created by Cyrus on 16/11/3.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#ifndef ASPopupHeader_h
#define ASPopupHeader_h

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

#endif /* ASPopupHeader_h */
