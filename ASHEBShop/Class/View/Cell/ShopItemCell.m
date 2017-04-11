//
//  ShopItemCell.m
//  ASHEBShop
//
//  Created by xmfish on 17/3/15.
//  Copyright © 2017年 ash. All rights reserved.
//

#import "ShopItemCell.h"
#import "UILabel+ASHUtil.h"
#import "ASHHomeModel.h"
#import "UIColor+CustomColor.h"

@interface ShopItemCell()
@property (weak, nonatomic) IBOutlet UIView *shopContentView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *oriPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;

@end
@implementation ShopItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    
    self.shopContentView.backgroundColor = [UIColor whiteColor];
//    self.shopContentView.backgroundColor = [UIColor colorWithHexString:@"#ffffff" alpha:0.8];
    self.shopContentView.layer.masksToBounds = YES;
    self.shopContentView.layer.cornerRadius = 5.0;
//    
//    self.shopContentView.layer.shadowOffset = CGSizeMake(0, 0);
//    self.shopContentView.layer.shadowRadius = 2;
//    self.shopContentView.layer.shadowOpacity = 1.0;
//    self.shopContentView.layer.shadowColor = [UIColor colorWithWhite:0.6 alpha:0.8].CGColor;
    
    
    self.titleLabel.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ASHHomeItemModel *)model
{
    self.titleLabel.text = model.title;
    self.detailLabel.text = model.content;
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f", model.price];
    self.oriPriceLabel.text = [NSString stringWithFormat:@"%.2f", model.oldPrice];
    [self.oriPriceLabel ash_labelByStrikeline];
}
@end
