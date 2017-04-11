//
//  ALPPluginManager.h
//  ALPLinkPartnerSDK
//
//  Created by czp on 16/9/26.
//  Copyright © 2016年 czp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALPBasePlugin.h"

@interface ALPPluginManager : NSObject


+ (nonnull instancetype)shareInstance;

/**
 *  添加插件，同一类型的插件只能添加一次
 *
 *  @param plugin 插件
 *
 *  @return 添加插件是否成功
 */
- (BOOL)registerPlugin:(nonnull ALPBasePlugin<ALPPluginProtocol> *)plugin;

/**
 *  根据插件的key查找 对应插件
 *
 *  @param pluginKey 插件的key
 *
 *  @return 插件
 */
- (nullable ALPBasePlugin<ALPPluginProtocol> *)searchPluginWithKey:(nonnull NSString *)pluginKey;

/**
 *  所有插件
 *
 *  @return 所有插件
 */
- (nullable NSArray *)plugins;


@end
