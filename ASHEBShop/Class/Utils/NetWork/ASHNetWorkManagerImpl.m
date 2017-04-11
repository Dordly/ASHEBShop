//
//  ASHNetWorkManagerImpl.m
//  ASHEBShop
//
//  Created by xmfish on 17/3/16.
//  Copyright © 2017年 ash. All rights reserved.
//

#import "ASHNetWorkManagerImpl.h"
#import <AFNetworking.h>
#import "ASHPropertyEntity.h"
#import <YYModel.h>
#import <ReactiveCocoa.h>
@interface ASHNetWorkManagerImpl()
@property (nonatomic, strong)AFHTTPSessionManager* manager;
@end
@implementation ASHNetWorkManagerImpl

+(ASHNetWorkManagerImpl*)shareInstance
{
    static ASHNetWorkManagerImpl* shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}
- (id)init
{
    self = [super init];
    if (self) {
        self.manager = [self setupManager];
    }
    return self;
}

- (AFHTTPSessionManager*)setupManager
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kASH_EBSHOP_API_URL]];
    
    manager.requestSerializer.timeoutInterval = kTimeOutInterval;
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    [manager.requestSerializer setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",@"application/xml", nil];
    return manager;
}

#pragma mark networdmanager delegate
- (void)getWithUrl:(NSString *)url param:(NSDictionary *)param success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    [self.manager GET:url parameters:param progress:nil success:success failure:failure];
}
- (void)postWithUrl:(NSString *)url param:(NSDictionary *)param success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
//    [self.manager POST:url parameters:param progress:nil success:success failure:failure];
    [self.manager POST:url parameters:param constructingBodyWithBlock:nil progress:nil success:success failure:false];
}
- (void)requestWithEntity:(ASHPropertyEntity *)eneity success:(void (^)(id))success failure:(void (^)(NSError * _Nonnull))failure
{
    
    NSString* requestUrl = [[NSURL URLWithString:eneity.path relativeToURL:[NSURL URLWithString:eneity.baseUrl]] absoluteString];
    void(^successBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)  = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        if (responseObject) {
            id model = [[eneity.responesOBJ class] yy_modelWithJSON:responseObject];
            if (success) {
                success(model);
            }
        }
    };
    void(^failureBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        if (failure) {
            failure(error);
        }
    };
    
    if (eneity.requireType == HTTPRequestTypeWithGET) {
        [self getWithUrl:requestUrl param:[eneity encodePro] success:successBlock failure:failureBlock];
    }else if(eneity.requireType == HTTPRequestTypeWithPOST){
        [self postWithUrl:requestUrl param:[eneity encodePro] success:successBlock failure:failureBlock];
    }
}
- (RACSignal*)requestSignWithEneity:(ASHPropertyEntity *)eneity
{
    RACSignal* signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString* requestUrl = [[NSURL URLWithString:eneity.path relativeToURL:[NSURL URLWithString:eneity.baseUrl]] absoluteString];
        if (!requestUrl) {
            requestUrl = @"";
        }
        void(^successBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            if (responseObject) {
                id model = [[eneity.responesOBJ class] yy_modelWithJSON:responseObject];
                [subscriber sendNext:model];
            }else{
                [subscriber sendNext:nil];
            }
            [subscriber sendCompleted];
        };
        void(^failBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
            [subscriber sendError:error];
        };
        
        if (eneity.requireType == HTTPRequestTypeWithGET) {
            [self getWithUrl:requestUrl param:[eneity encodePro] success:successBlock failure:failBlock];
        }else if(eneity.requireType == HTTPRequestTypeWithPOST){
            [self postWithUrl:requestUrl param:[eneity encodePro] success:successBlock failure:failBlock];
        }
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    return signal;
}
@end
