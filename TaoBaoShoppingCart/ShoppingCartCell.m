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
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEdit:)];
    [self.editDetailView addGestureRecognizer:tap];
    self.editDetailView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickProductIMG:)];
    [self.productImageView addGestureRecognizer:tap1];
    self.productImageView.userInteractionEnabled = YES;
}

- (void)clickProductIMG:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickProductIMG:)]) {
        [self.delegate clickProductIMG:self];
    }
}

- (void)clickEdit:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickEditingDetailInfo:)]) {
        [self.delegate clickEditingDetailInfo:self];
    }
}


// 点击单个商品选择的按钮回调
- (IBAction)clickSelected:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(productSelected:isSelected:)])
    {
        [self.delegate productSelected:self isSelected:!sender.selected];
    }
}

// 点击买手头部选择按钮回调
- (IBAction)clickBuyerSelcted:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(buyerSelected:)]) {
     
        [self.delegate buyerSelected:self.sectionIndex];
    }
}

// 点击买手头部编辑按钮回调
- (IBAction)clickBuyerEditing:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(buyerEditingSelected:)]) {
        [self.delegate buyerEditingSelected:self.sectionIndex];
    }
}

// 点击单个cell里面的垃圾桶回调
- (IBAction)clickGarbage:(id)sender {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(productGarbageClick:)]) {
        [self.delegate productGarbageClick:self];
    }
}
// 增加商品或者减少商品
- (IBAction)plusOrMinus:(UIButton *)sender {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(plusOrMinusCount:tag:)]) {
        [self.delegate plusOrMinusCount:self tag:sender.tag];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
