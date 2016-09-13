//
//  shoppingCartModel.h
//  TaoBaoShoppingCart
//
//  Created by MKJING on 16/9/10.
//  Copyright © 2016年 MKJING. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BuyerInfo : NSObject

@property (nonatomic,copy) NSString *buyer_id;
@property (nonatomic,copy) NSString *last_update_ts;
@property (nonatomic,copy) NSString *nick_name;
@property (nonatomic,copy) NSString *user_avatar;
@property (nonatomic,strong) NSMutableArray *prod_list;

// 买手左侧按钮是否选中
@property (nonatomic,assign) BOOL buyerIsChoosed;

// 买手下面商品是否全部编辑状态
@property (nonatomic,assign) BOOL buyerIsEditing;

@end



@interface ProductInfo : NSObject

@property (nonatomic,assign) CGFloat cn_price;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,assign) CGFloat order_price;
@property (nonatomic,assign) CGFloat price;
@property (nonatomic,copy) NSString *prod_id;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) NSArray *model_detail;

// 商品左侧按钮是否选中
@property (nonatomic,assign) BOOL productIsChoosed;

@end

@interface ModelDeatail : NSObject

@property (nonatomic,copy) NSString *key;
@property (nonatomic,copy) NSString *type_name;
@property (nonatomic,copy) NSString *value;

@end


@interface RelatedProducts : NSObject

@property (nonatomic,strong) NSArray *list;

@end


@interface SingleProduct : NSObject

@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,assign) CGFloat order_price;
@property (nonatomic,assign) CGFloat cn_price;
@property (nonatomic,copy) NSString *user_id;

@end










