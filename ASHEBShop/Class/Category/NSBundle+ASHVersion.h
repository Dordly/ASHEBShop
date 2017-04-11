//
//  NSBundle+ASHVersion.h
//  ASHEBShop
//
//  Created by xmfish on 17/4/5.
//  Copyright © 2017年 ash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (ASHVersion)

@property (nonatomic, readonly, copy) NSString* version;

@property (nonatomic, readonly, copy) NSString* buildVersion;

@property (nonatomic, readonly, copy) NSString* identifier;
@end
