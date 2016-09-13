//
//  MKJRequestHelper.m
//  AutoLayoutShowTime
//
//  Created by MKJING on 16/8/19.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "MKJRequestHelper.h"
#import <MJExtension.h>
#import "shoppingCartModel.h"

@implementation MKJRequestHelper


static MKJRequestHelper *_requestHelper;

static id _requestHelp;

+ (instancetype)shareRequestHelper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _requestHelp = [[self alloc] init];
    });
    return _requestHelp;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _requestHelp = [super allocWithZone:zone];
    });
    return _requestHelp;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _requestHelp;
}


- (void)requestShoppingCartInfo:(requestHelperBlock)block
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shoppingCart" ofType:@"json"];
    NSString *shoppingStr = [NSString stringWithContentsOfFile:path usedEncoding:nil error:nil];
    NSDictionary *shoppingDic = [shoppingStr mj_JSONObject];
    [BuyerInfo mj_setupObjectClassInArray:^NSDictionary *{
        
        return @{@"prod_list":@"ProductInfo"};
        
    }];
    
    [ProductInfo mj_setupObjectClassInArray:^NSDictionary *{
       
        return @{@"model_detail":@"ModelDeatail"};
        
    }];
    
    NSMutableArray *buyerLists = [BuyerInfo mj_objectArrayWithKeyValuesArray:shoppingDic[@"buyers_data"]];
    block(buyerLists,nil);
}


- (void)requestMoreRecommandInfo:(requestHelperBlock)block
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"moreRecommand" ofType:@"json"];
    NSString *relatedStr = [NSString stringWithContentsOfFile:path usedEncoding:nil error:nil];
    NSDictionary *relatedDic = [relatedStr mj_JSONObject];
    [RelatedProducts mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"list":@"SingleProduct"};
    }];
    RelatedProducts *products = [RelatedProducts mj_objectWithKeyValues:relatedDic];
    block(products.list,nil);
}


- (BOOL)isEmptyArray:(NSArray *)array
{
    return (array.count ==0 || array == nil);
}

- (NSAttributedString *)recombinePrice:(CGFloat)CNPrice orderPrice:(CGFloat)unitPrice
{
    NSMutableAttributedString *mutableAttributeStr = [[NSMutableAttributedString alloc] init];
    NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%.f",unitPrice] attributes:@{NSForegroundColorAttributeName : [UIColor redColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:12]}];
    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%.f",CNPrice] attributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:11],NSStrikethroughStyleAttributeName :@(NSUnderlineStyleSingle),NSStrikethroughColorAttributeName : [UIColor lightGrayColor]}];
    [mutableAttributeStr appendAttributedString:string1];
    [mutableAttributeStr appendAttributedString:string2];
    return mutableAttributeStr;
}

@end
