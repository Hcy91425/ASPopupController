//
//  CYAlertView.h
//  CYAlertController
//
//  Created by Cyrus on 16/3/26.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^EmptyBlock) ();

@interface CYAlertView : UIView
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message leftButtonTitle:(NSString *)leftButtonTitle leftButtonAction:(EmptyBlock)leftButtonAction rightButtonTitle:(NSString *)rightButtonTitle rightButtonAction:(EmptyBlock)rightButtonAction;
@end
