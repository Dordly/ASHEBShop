//
//  ALPBasePlugin.h
//  ALPLinkPartnerSDK
//
//  Created by czp on 16/9/26.
//  Copyright © 2016年 czp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALPBasePluginParam.h"


@protocol ALPPluginProtocol <NSObject>

@required

/**
 *  插件通用协议
 *
 *  @param param 通用参数
 *  @param block 插件处理完回调
 */
- (void)pluginService:(ALPBasePluginParam *)param;



@end

typedef NS_ENUM(NSInteger, ALPLinkPartnerPrior) {
    ALPLinkPartnerPriorLow     = -2,
    ALPLinkPartnerPriorDefault = 0,
    ALPLinkPartnerPriorHigh    = 2,
};

FOUNDATION_EXTERN NSString *const kAuthPluginKey;
FOUNDATION_EXTERN NSString *const kAuthRouteRule;


@interface ALPBasePlugin : NSObject

/**
 *  插件的唯一标识
 */
@property (nonatomic, copy) NSString *pluginKey;

/**
 *  插件匹配规则
 */
@property (nonatomic, strong) NSArray *routerRules;

/**
 *  初始化插件
 *
 *  @param key  插件对应的key
 *  @param rule 路由规则
 *
 *  @return 插件
 */
+ (instancetype)initPluginWithKey:(NSString *)key
                        routeRule:(NSString *)rule;

/**
 *  初始化插件，对应多个路由规则
 *
 *  @param key   插件对应的key
 *  @param rules 路由规则数组
 *
 *  @return 插件
 */
+ (instancetype)initPluginWithKey:(NSString *)key
                       routeRules:(NSArray<NSString *> *)rules;


@end
