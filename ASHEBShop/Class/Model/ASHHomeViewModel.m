//
//  ASHHomeViewModel.m
//  ASHEBShop
//
//  Created by xmfish on 17/4/5.
//  Copyright © 2017年 ash. All rights reserved.
//

#import "ASHHomeViewModel.h"
#import "ASHHomeModel.h"
#import "ASHNetWork.h"
#import "ASHPropertyEntity.h"
#import <ReactiveCocoa.h>
@interface ASHHomeViewModel()
@property (nonatomic, strong)ASHHomeModel* model;
@end
@implementation ASHHomeViewModel


- (void)requestData
{
    [self requestHomeDataWithPage:1];
}
- (void)loadMore
{
    [self requestHomeDataWithPage:self.page + 1];
}

- (void)requestHomeDataWithPage:(NSInteger)page
{
    [requestDisposable dispose];
    ASHPropertyEntity* proEntity = [[ASHPropertyEntity alloc] init];
    proEntity.requireType = HTTPRequestTypeWithPOST;
    proEntity.isCache = YES;
    proEntity.responesOBJ = [ASHHomeModel class];
    proEntity.command = 10001;
    proEntity.param = @{@"page":@(page), @"pageSize":@(kDefaultPageSize)};
    requestDisposable = [[ASHNetWork requestSignWithEneity:proEntity] subscribeNext:^(ASHHomeModel* model) {
        self.page++;
        
        if (model.goodsJa.count < kDefaultPageSize) {
            self.hasMore = NO;
        }else{
            self.hasMore = YES;
        }
        if (page == 1) {
            self.page = 1;
            self.model = model;
        }else if(model.goodsJa){
            NSMutableArray<ASHHomeItemModel>* array = (NSMutableArray<ASHHomeItemModel>*)[NSMutableArray arrayWithArray:[(ASHHomeModel*)self.model goodsJa]];
            [array addObjectsFromArray:model.goodsJa];
            ((ASHHomeModel*)self.model).goodsJa = array;
        }
        [self.ash_requestFinishedSubscriber sendNext:self.model];
        [self.ash_requestFinishedSubscriber sendCompleted];
        
        
    } error:^(NSError *error) {
        [self.ash_requestFinishedSubscriber sendError:error];
    }];
}
@end
 
