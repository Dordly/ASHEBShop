//
//  ASHBaseViewModel.h
//  ASHEBShop
//
//  Created by xmfish on 17/4/5.
//  Copyright © 2017年 ash. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASHBaseModel.h"
#import <ReactiveCocoa.h>
@interface ASHBaseViewModel : NSObject
{
    __weak RACDisposable *requestDisposable;
    __weak RACDisposable *loadMoreDisposable;
}

@property (nonatomic, copy)ASHBaseModel* baseModel;

@property (nonatomic, assign)BOOL hasMore;

@property (nonatomic, assign)NSInteger page;
/**
 请求是否成功

 @return isSuccess
 */
- (BOOL)isSuccess;


/**
 请求数据
 */
- (void)requestData;


/**
 数据加载结束

 @return 数据信号
 */
- (RACSignal*)requestFinishedSignal;

/**
 加载更多
 */
- (void)loadMore;

/**
 加载更多结束

 @return 数据信号
 */
- (RACSignal *)loadMoreFinishedSignal;


@end

@interface ASHBaseViewModel(ASH_Private)
- (id<RACSubscriber>)ash_requestFinishedSubscriber;
- (id<RACSubscriber>)ash_loadMoreFinishedSubscriber;
@end
