//
//  ASHBaseViewModel.m
//  ASHEBShop
//
//  Created by xmfish on 17/4/5.
//  Copyright © 2017年 ash. All rights reserved.
//

#import "ASHBaseViewModel.h"

@implementation ASHBaseViewModel
{
    RACSignal *requestFinishedSignal;
    RACSignal *loadMoreFinishedSignal;
    
    id<RACSubscriber> requestFinishedSubscriber;
    id<RACSubscriber> loadMoreFinishedSubscriber;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _page = 0;
        _hasMore = YES;
    }
    return self;
}

- (RACSignal*)requestFinishedSignal
{
    if (requestFinishedSignal == nil) {
        @synchronized (self) {
            RACSubject *subject = [RACSubject subject];
            
            requestFinishedSignal = [subject deliverOnMainThread];
            requestFinishedSubscriber = subject;
        }
    }
    return requestFinishedSignal;
}
- (void)requestData
{
    [requestFinishedSubscriber sendNext:nil];
}

- (RACSignal*)loadMoreFinishedSignal
{
    if(loadMoreFinishedSignal == nil)
    {
        @synchronized(self)
        {
            RACSubject *subject = [RACSubject subject];
            
            loadMoreFinishedSignal = [subject deliverOnMainThread];
            loadMoreFinishedSubscriber = subject;
        }
    }
    return loadMoreFinishedSignal;
}
- (void)loadMore
{
    [requestFinishedSubscriber sendNext:nil];
}
- (BOOL)isSuccess
{
    return (self.baseModel.ret == 0);
}
@end

@implementation ASHBaseViewModel(ASH_Private)
- (id<RACSubscriber>)ash_requestFinishedSubscriber
{
    return requestFinishedSubscriber;
}
- (id<RACSubscriber>)ash_loadMoreFinishedSubscriber
{
    return loadMoreFinishedSubscriber;
}
@end
