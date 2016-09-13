//
//  MKJRequestHelper.h
//  AutoLayoutShowTime
//
//  Created by MKJING on 16/8/19.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^requestHelperBlock)(id obj,NSError *err);

@interface MKJRequestHelper : NSObject

+ (instancetype)shareRequestHelper;

- (void)requestShoppingCartInfo:(requestHelperBlock)block;

- (void)requestMoreRecommandInfo:(requestHelperBlock)block;

- (BOOL)isEmptyArray:(NSArray *)array;

- (NSAttributedString *)recombinePrice:(CGFloat)CNPrice orderPrice:(CGFloat)unitPrice;

@end
