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
- (nonnull instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message leftButtonTitle:(nullable NSString *)leftButtonTitle leftButtonAction:(nullable EmptyBlock)leftButtonAction rightButtonTitle:(nullable NSString *)rightButtonTitle rightButtonAction:(nullable EmptyBlock)rightButtonAction;
@end
