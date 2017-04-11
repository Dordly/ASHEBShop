//
//  ASHPropertyEntity.h
//  ASHEBShop
//
//  Created by xmfish on 17/3/17.
//  Copyright © 2017年 ash. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASHTypedefDefine.h"
@interface ASHPropertyEntity : NSObject


/**
 请求方式,默认get
 */
@property (nonatomic, assign) HTTPRequestType requireType;

/**
 基础域名
 */
@property (nonatomic, copy) NSString *baseUrl;

/**
 请求路径
 */
@property (nonatomic, copy) NSString *path;


/**
 请求命令
 */
@property (nonatomic, assign)NSInteger command;
/**
 缓存key
 */
@property (nonatomic, strong)NSString* cacheKey;

/**
 请求参数
 */
@property (nonatomic, strong) id param;

/**
 要转换的model类
 */
@property (nonatomic, assign) Class responesOBJ;

/**
 是否需要缓存,默认不需要
 */
@property (nonatomic, assign) BOOL isCache;


/**
 加密参数param

 @return 加密之后的参数
 */
- (NSDictionary *)encodePro;
@end
