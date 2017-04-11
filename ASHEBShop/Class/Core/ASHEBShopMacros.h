//
//  ASHEBShopMacros.h
//  ASHEBShop
//
//  Created by xmfish on 17/3/16.
//  Copyright © 2017年 ash. All rights reserved.
//

#ifndef ASHEBShopMacros_h
#define ASHEBShopMacros_h
#import "NSBundle+ASHVersion.h"

/**
 网络请求超时时间
 */
#define kTimeOutInterval 30


/**
 每页的个数
 */
#define kDefaultPageSize 200
/**
 app信息
 */
#define APPVersion              [NSBundle mainBundle].version
#define APPBuildVersion         [NSBundle mainBundle].buildVersion
#define APPBundleIdentifier     [NSBundle mainBundle].identifier

#endif /* ASHEBShopMacros_h */
