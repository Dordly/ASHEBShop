//
//  UIColor+CustomColor.h
//  ASHEBShop
//
//  Created by xmfish on 17/3/15.
//  Copyright © 2017年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CustomColor)

/**
 * 十六进制数转换UIColor
 * 例如： 0x123456
 */
+ (UIColor *)colorWithHex:(UInt32)col alpha:(CGFloat)alpha;

/**
 * 十六进制字符串转换UIColor
 * 例如： @"#123456"
 */
+ (UIColor *)colorWithHexString:(NSString *)str alpha:(CGFloat)alpha;

+ (UIColor *)mainColor;
@end
