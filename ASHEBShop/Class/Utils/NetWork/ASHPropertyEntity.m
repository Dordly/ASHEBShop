//
//  ASHPropertyEntity.m
//  ASHEBShop
//
//  Created by xmfish on 17/3/17.
//  Copyright © 2017年 ash. All rights reserved.
//

#import "ASHPropertyEntity.h"
#import "ASHBaseModel.h"
#import <YYModel.h>
#import <YYCategories.h>
@implementation ASHPropertyEntity

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.requireType = HTTPRequestTypeWithGET;
        self.isCache = NO;
        self.responesOBJ = [ASHBaseModel class];
        self.baseUrl = kASH_EBSHOP_API_URL;
        self.path = @"";
    }
    return self;
}

- (NSDictionary*)encodePro
{
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    if (self.param) {
        [dic addEntriesFromDictionary:self.param];
    }
    NSString* version = APPVersion;
    NSString* root = [dic yy_modelToJSONString];
    
    NSString* sign = [NSString stringWithFormat:@"%ld%@%@%@", self.command, root, version, kASH_NETWORK_SIGN];
    sign = [sign md5String];
    
    NSDictionary* resultDic = @{@"root":root,
                                @"version":version,
                                @"command":@(self.command),
                                @"sign":sign};
    
    return resultDic;
    
}
@end
