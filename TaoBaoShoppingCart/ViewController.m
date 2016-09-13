//
//  ViewController.m
//  TaoBaoShoppingCart
//
//  Created by MKJING on 16/9/10.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "ViewController.h"
#import "ChooseGoodsPropertyViewController.h"
#import "UIViewController+KNSemiModal.h"
#import "WZLBadgeImport.h"
#import "MKJShoppingCartViewController.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *shoppingCart;

@property (nonatomic,strong) ChooseGoodsPropertyViewController *chooseVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"点一下";
    
    self.shoppingCart.badgeBgColor = [UIColor blueColor];
    self.shoppingCart.badgeTextColor = [UIColor whiteColor];
    self.shoppingCart.badgeFont = [UIFont boldSystemFontOfSize:11];
    self.shoppingCart.badgeMaximumBadgeNumber = 99;
    self.shoppingCart.badgeCenterOffset = CGPointMake(5, 0);
    [self.shoppingCart showBadgeWithStyle:WBadgeStyleNumber value:100 animationType:WBadgeAnimTypeScale];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(show:)];
    [self.shoppingCart addGestureRecognizer:tap];
    self.shoppingCart.userInteractionEnabled = YES;
}

- (void)show:(UITapGestureRecognizer *)tap
{
    if (!self.chooseVC)
    {
        
        self.chooseVC = [[ChooseGoodsPropertyViewController alloc] init];
    
    }
    self.chooseVC.enterType = FirstEnterType;
    __weak typeof(self)weakSelf = self;
    self.chooseVC.block = ^{

        NSLog(@"点击回调去购物车");
        // 下面一定要移除，不然你的控制器结构就乱了，基本逻辑层级我们已经写在上面了，这个效果其实是addChildVC来的，最后的展示是在Window上的，一定要移除
        [weakSelf.chooseVC.view removeFromSuperview];
        [weakSelf.chooseVC removeFromParentViewController];
        weakSelf.chooseVC.view = nil;
        weakSelf.chooseVC = nil;
        
        MKJShoppingCartViewController *shop = [MKJShoppingCartViewController new];
        [weakSelf.navigationController pushViewController:shop animated:YES];
        
    };
    self.chooseVC.price = 256.0f;
    [self.navigationController presentSemiViewController:self.chooseVC withOptions:@{
                                                                                     KNSemiModalOptionKeys.pushParentBack    : @(YES),
                                                                                     KNSemiModalOptionKeys.animationDuration : @(0.6),
                                                                                     KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                                                                                     KNSemiModalOptionKeys.backgroundView : [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_01"]]
                                                                                    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
