//
//  ASHHomeModel.h
//  ASHEBShop
//
//  Created by xmfish on 17/4/5.
//  Copyright © 2017年 ash. All rights reserved.
//

#import "ASHBaseModel.h"

@protocol ASHHomeItemModel <NSObject>
@end
@interface ASHHomeItemModel : NSObject
@property (nonatomic, assign)NSInteger sourceStore;
@property (nonatomic, copy)NSString* content;
@property (nonatomic, copy)NSString* goodsUrl;
@property (nonatomic, assign)NSInteger id;
@property (nonatomic, assign)float oldPrice;
@property (nonatomic, assign)float goodType;
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* imageUrl;
@property (nonatomic, assign)NSTimeInterval createAt;
@property (nonatomic, assign)float price;
@property (nonatomic, assign)NSTimeInterval updateAt;
@end
@interface ASHHomeModel : ASHBaseModel
@property (nonatomic, strong)NSMutableArray<ASHHomeItemModel>* goodsJa;
@end
