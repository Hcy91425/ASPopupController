//
//  NSString+Size.m
//  Gank
//
//  Created by Cyrus on 16/3/24.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)
- (CGFloat)heightWithWidth:(CGFloat)width andFont:(UIFont *)font{
    NSDictionary *attribute = @{NSFontAttributeName:font,
                                NSForegroundColorAttributeName:[UIColor blackColor]};
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
    return rect.size.height;
}

- (CGFloat)widthWithHeight:(CGFloat)height andFont:(UIFont *)font{
    NSDictionary *attribute = @{NSFontAttributeName:font,
                                NSForegroundColorAttributeName:[UIColor blackColor]};
    CGRect rect = [self boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
    
    return rect.size.width;
}
@end
