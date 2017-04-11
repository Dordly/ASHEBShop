//
//  ASHNetWork.m
//  ASHEBShop
//
//  Created by xmfish on 17/4/5.
//  Copyright © 2017年 ash. All rights reserved.
//

#import "ASHNetWork.h"
#import "ASHNetWorkManagerImpl.h"
@implementation ASHNetWork

+(RACSignal*)requestSignWithEneity:(ASHPropertyEntity *)eneity
{
    return [[ASHNetWorkManagerImpl shareInstance] requestSignWithEneity:eneity];
}
@end
