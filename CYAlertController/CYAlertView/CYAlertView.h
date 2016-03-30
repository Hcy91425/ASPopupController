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
- (_Nonnull instancetype)initWithTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message leftButtonTitle:(NSString * _Nullable)leftButtonTitle leftButtonAction:(nullable EmptyBlock)leftButtonAction rightButtonTitle:(NSString * _Nullable)rightButtonTitle rightButtonAction:(nullable EmptyBlock)rightButtonAction;
@end
