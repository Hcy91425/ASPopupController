//
//  ASPopupAction.m
//  ASPopupView
//
//  Created by Cyrus on 16/4/13.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import "ASPopupAction.h"

@implementation ASPopupAction

+ (instancetype)actionWithTitle:(NSString *)title style:(ASPopupActionStyle)style handler:(void(^)())handler {
    ASPopupAction *action = [[ASPopupAction alloc] init];
    action.title = title;
    action.handler = handler;
    action.style = style;
    return action;
}


@end
