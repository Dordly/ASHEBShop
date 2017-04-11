//
//  ASHNetWork.h
//  ASHEBShop
//
//  Created by xmfish on 17/4/5.
//  Copyright © 2017年 ash. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ASHPropertyEntity, RACSignal;
@interface ASHNetWork : NSObject



/**
 根据请求实体获取signal

 @param eneity 请求实体
 @return signal
 */
+ (RACSignal*)requestSignWithEneity:(ASHPropertyEntity*)eneity;
@end
