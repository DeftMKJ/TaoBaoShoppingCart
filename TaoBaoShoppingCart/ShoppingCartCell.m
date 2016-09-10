//
//  ShoppingCartCell.m
//  TaoBaoShoppingCart
//
//  Created by MKJING on 16/9/10.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "ShoppingCartCell.h"

@implementation ShoppingCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.productImageView.layer.cornerRadius = 5.0f;
    self.productImageView.layer.masksToBounds = YES;
    self.productImageView.clipsToBounds = YES;
    self.buyerImageView.layer.cornerRadius = 20;
    self.buyerImageView.layer.masksToBounds = YES;
    self.buyerImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
