//
//  NSBundle+ASHVersion.m
//  ASHEBShop
//
//  Created by xmfish on 17/4/5.
//  Copyright © 2017年 ash. All rights reserved.
//

#import "NSBundle+ASHVersion.h"

@implementation NSBundle (ASHVersion)

- (NSString*)version
{
    return self.infoDictionary[@"CFBundleShortVersionString"];
}

- (NSString*)buildVersion
{
    return self.infoDictionary[@"CFBundleVersion"];
}

- (NSString*)identifier
{
    return self.infoDictionary[@"CFBundleIdentifier"];
}
@end
