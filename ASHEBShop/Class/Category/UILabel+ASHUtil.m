//
//  UILabel+ASHUtil.m
//  ASHEBShop
//
//  Created by xmfish on 17/3/15.
//  Copyright © 2017年 ash. All rights reserved.
//

#import "UILabel+ASHUtil.h"

@implementation UILabel (ASHUtil)

- (void)ash_labelByStrikeline
{
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    [self ash_setAttDic:attribtDic];
}
- (void)ash_labelByUnderline
{
    
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    [self ash_setAttDic:attribtDic];
}
- (void)ash_setAttDic:(NSDictionary*)attribtDic
{
    if (!self.text.length) {
        return;
    }
    NSMutableAttributedString *attribtStr =  [[NSMutableAttributedString alloc]initWithString:self.text attributes:attribtDic];
    self.attributedText = attribtStr;
}
@end
