//
//  ShoppingCartCell.h
//  TaoBaoShoppingCart
//
//  Created by MKJING on 16/9/10.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShoppingCartCell;

@protocol ShoppingCartCellDelegate <NSObject>

// 点击单个商品选择按钮回调
- (void)productSelected:(ShoppingCartCell *)cell isSelected:(BOOL)choosed;
// 点击buyer选择按钮回调
- (void)buyerSelected:(NSInteger)sectionIndex;
// 点击buyer编辑回调按钮
- (void)buyerEditingSelected:(NSInteger)sectionIdx;
// 点击垃圾桶删除
- (void)productGarbageClick:(ShoppingCartCell *)cell;
// 点击编辑规格按钮下拉回调
- (void)clickEditingDetailInfo:(ShoppingCartCell *)cell;
// 商品的增加或者减少回调
- (void)plusOrMinusCount:(ShoppingCartCell *)cell tag:(NSInteger)tag;
// 点击图片回调到主页显示
- (void)clickProductIMG:(ShoppingCartCell *)cell;


@end

@interface ShoppingCartCell : UITableViewCell

@property (nonatomic,assign) id<ShoppingCartCellDelegate>delegate;
// 左侧选择按钮
@property (weak, nonatomic) IBOutlet UIButton *leftChooseButton;
// 图片
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;


// 普通模式下的容器View
@property (weak, nonatomic) IBOutlet UIView *normalBackView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;


// 编辑模式下的View
@property (weak, nonatomic) IBOutlet UIView *editBackView;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UILabel *editCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIView *editDetailView;
@property (weak, nonatomic) IBOutlet UILabel *editDetailTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *downArrowButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;


// sectionHeader
@property (weak, nonatomic) IBOutlet UIButton *headerSelectedButton;
@property (weak, nonatomic) IBOutlet UIImageView *buyerImageView;
@property (weak, nonatomic) IBOutlet UIView *buyerNameBackView;
@property (weak, nonatomic) IBOutlet UIButton *editSectionHeaderButton;
@property (weak, nonatomic) IBOutlet UILabel *buyerNameLabel;
@property (nonatomic,assign) NSInteger sectionIndex;





@end
