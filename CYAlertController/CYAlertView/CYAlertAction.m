//
//  CYAlertAction.m
//  CYAlertView
//
//  Created by Cyrus on 16/4/13.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import "CYAlertAction.h"

@implementation CYAlertAction

+ (instancetype)actionWithTitle:(NSString *)title style:(CYAlertActionStyle)style handler:(void(^)())handler {
    CYAlertAction *action = [[CYAlertAction alloc] init];
    action.title = title;
    action.handler = handler;
    action.style = style;
    return action;
}


@end
