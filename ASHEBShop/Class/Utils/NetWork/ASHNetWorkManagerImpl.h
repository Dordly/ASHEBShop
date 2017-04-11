//
//  ASHNetWorkManagerImpl.h
//  ASHEBShop
//
//  Created by xmfish on 17/3/16.
//  Copyright © 2017年 ash. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASHNetWorkManagerProtocol.h"
@interface ASHNetWorkManagerImpl : NSObject<ASHNetWorkManagerProtocol>


/**
 获取网络管理单例实例

 @return 返回 网络管理类
 */
+(ASHNetWorkManagerImpl*)shareInstance;
@end
