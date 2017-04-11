//
//  ALPJumpParam.h
//  ALPLinkPartnerSDK
//
//  Created by czp on 16/9/22.
//  Copyright © 2016年 czp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALPError.h"

//对应的linkKey
FOUNDATION_EXTERN NSString *const kTaobaoLinkKey;       //打开淘宝
FOUNDATION_EXTERN NSString *const kTmallLinkKey;        //打开天猫

@interface ALPJumpParam : NSObject

/**
 * 优先拉起的app，link协议key，linkKey为空，默认是拉起手淘
 */
@property (nonatomic, copy) NSString *linkKey;

/**
 *  返回的跳转地址(可选)
 */
@property (nonatomic, copy) NSString *backURL;

/**
 *  跳转时当前页面，用于坑位统计
 */
@property (nonatomic, copy) NSString *currentViewName;

/**
 *  AlibcFlowCustoms SDK 插件匹配规则，触发对应插件执行
 */
@property (nonatomic, copy) NSString *routeRule;

/**
 *  额外参数(可选)
 */
@property (nonatomic, strong) NSMutableDictionary *extraParam;








@end
