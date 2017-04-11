//
//  UIColor+CustomColor.m
//  ASHEBShop
//
//  Created by xmfish on 17/3/15.
//  Copyright © 2017年 ash. All rights reserved.
//

#import "UIColor+CustomColor.h"

@implementation UIColor (CustomColor)
// 例如： @"#123456"
+ (UIColor *)colorWithHexString:(NSString *)str alpha:(CGFloat)alpha
{
    const char *cStr = [str cStringUsingEncoding:NSASCIIStringEncoding];
    UInt32 x = (UInt32)strtol(cStr+1, NULL, 16);
    return [UIColor colorWithHex:x alpha:alpha];
}

// 例如 0x123456
+ (UIColor *)colorWithHex:(UInt32)col alpha:(CGFloat)alpha
{
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:alpha];
}
+ (UIColor *)mainColor
{
    return [UIColor colorWithHexString:@"#61BFA9" alpha:1.0];
}
@end
