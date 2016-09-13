//
//  ChooseGoodsPropertyViewController.h
//  购物车弹窗
//
//  Created by 宓珂璟 on 16/6/23.
//  Copyright © 2016年 宓珂璟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,EnterType){
  
    FirstEnterType = 0,
    SecondEnterType
};


typedef void(^callBack)();

@interface ChooseGoodsPropertyViewController : UIViewController

@property (nonatomic,assign) CGFloat price;

@property (nonatomic,copy) callBack block;

@property (nonatomic,assign) EnterType enterType;

@end
