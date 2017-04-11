//
//  ASHCommonUtil.m
//  ASHEBShop
//
//  Created by xmfish on 17/4/5.
//  Copyright © 2017年 ash. All rights reserved.
//

#import "ASHCommonUtil.h"

@implementation ASHCommonUtil

+(NSString*)getVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //    NSString *buildVersion = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSString *version = [NSString stringWithFormat:@"%@",app_Version];
    return version;
}
@end
