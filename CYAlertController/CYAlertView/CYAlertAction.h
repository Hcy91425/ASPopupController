//
//  CYAlertAction.h
//  CYAlertView
//
//  Created by Cyrus on 16/4/13.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CYAlertActionStyle) {
    CYAlertActionStyleDefault,
    CYAlertActionStyleCancel,
    CYAlertActionStyleDestructive
};

@interface CYAlertAction : NSObject

/** action 标题 */
@property (nonatomic, copy)NSString *title;

/** action 事件 */
@property (nonatomic, copy)void (^handler) ();

/** action 风格 */
@property (nonatomic, assign)CYAlertActionStyle style;

/**
 *    创建一个 action
 *
 *    @param title   标题
 *    @param style   风格
 *    @param handler 回调
 *
 */
+ (instancetype)actionWithTitle:(NSString *)title style:(CYAlertActionStyle)style handler:(void(^)())handler;

@end
