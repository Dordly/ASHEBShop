//
//  ASHNetWorkManagerProtocol.h
//  ASHEBShop
//
//  Created by xmfish on 17/3/16.
//  Copyright © 2017年 ash. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ASHPropertyEntity;
@class RACSignal;
@protocol ASHNetWorkManagerProtocol <NSObject>
NS_ASSUME_NONNULL_BEGIN

@required
/**
 post 请求
 
 @param url 请求域名
 @param param 参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)postWithUrl:(NSString*)url param:(nullable NSDictionary*)param success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

/**
 get 请求
 
 @param url 请求域名
 @param param 参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)getWithUrl:(NSString*)url param:(nullable NSDictionary*)param success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;


@optional
/**
 发送请求

 @param eneity 请求实体
 @param success 成功回调，直接回调vm
 @param failure 失败回调
 */
- (void)requestWithEntity:(ASHPropertyEntity*)eneity success:(nullable void(^)(_Nullable id))success failure:(nullable void(^)(NSError* error))failure;


/**
 RAC + NET

 @param eneity 请求实体
 @return RAC信号
 */
- (RACSignal*)requestSignWithEneity:(ASHPropertyEntity*)eneity;
NS_ASSUME_NONNULL_END
@end
