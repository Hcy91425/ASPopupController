//
//  NSString+Size.h
//  Gank
//
//  Created by Cyrus on 16/3/24.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Size)
- (CGFloat)heightWithWidth:(CGFloat)width andFont:(UIFont *)font;
- (CGFloat)widthWithHeight:(CGFloat)height andFont:(UIFont *)font;
@end
