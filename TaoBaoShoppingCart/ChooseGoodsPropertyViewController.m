//
//  ChooseGoodsPropertyViewController.m
//  购物车弹窗
//
//  Created by 宓珂璟 on 16/6/23.
//  Copyright © 2016年 宓珂璟. All rights reserved.
//

#import "ChooseGoodsPropertyViewController.h"
#import "ProductTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "UIViewController+KNSemiModal.h"
#import <UIImageView+WebCache.h>

@interface ChooseGoodsPropertyViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,assign) NSInteger idx1;
@property (nonatomic,assign) NSInteger idx2;

@property (weak, nonatomic) IBOutlet UIButton *confirmButtom;
@end


static NSString *identyfy1 = @"ProductTableViewCell";
static NSString *identyfy2 = @"CountTableViewCell";

@implementation ChooseGoodsPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (self.enterType == FirstEnterType) {
        [self.confirmButtom setTitle:@"去购物车" forState:UIControlStateNormal];
    }
    else
    {
        [self.confirmButtom setTitle:@"确定" forState:UIControlStateNormal];
    }
    
    self.imageView.layer.cornerRadius = 5.0f;
    self.imageView.clipsToBounds = YES;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://p3.wmpic.me/article/2016/07/08/1467959558_eOMTgkCd.jpg"] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image && cacheType == SDImageCacheTypeNone) {
            self.imageView.alpha = 0;
            [UIView animateWithDuration:1.0 animations:^{
               
                self.imageView.alpha = 1.0f;
            }];
        }
        else
        {
            self.imageView.alpha = 1.0f;
        }
        
        
    }];
    [self.tableView registerNib:[UINib nibWithNibName:identyfy1 bundle:nil] forCellReuseIdentifier:identyfy1];
    [self.tableView registerNib:[UINib nibWithNibName:identyfy2 bundle:nil] forCellReuseIdentifier:identyfy2];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIViewController * parent = [self.view containingViewController];
    if ([parent respondsToSelector:@selector(dismissSemiModalView)]) {
        [parent dismissSemiModalView];
    }
}

- (IBAction)confirm:(id)sender
{
    UIViewController * parent = [self.view containingViewController];
    if ([parent respondsToSelector:@selector(dismissSemiModalView)]) {
        [parent dismissSemiModalView];
    }
    if (self.enterType == FirstEnterType)
    {
        self.block();
    }
    
    

}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = nil;
    if (indexPath.row == self.dataSource.count) {
        ID = identyfy2;
    }
    else
    {
        ID = identyfy1;
    }
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self congifCell:cell indexpath:indexPath];
    return cell;
}

- (void)congifCell:(ProductTableViewCell *)cell indexpath:(NSIndexPath *)indexpath
{
    if (indexpath.row < self.dataSource.count) {
        UIColor *selectedColor = [UIColor colorWithRed:255/255.0 green:174/255.0 blue:1/255.0 alpha:1];
        
        cell.leftTitleLabel.text = [self.dataSource[indexpath.row] allKeys][0];
        [cell.tagView removeAllTags];
        // 这东西非常关键
        cell.tagView.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 70;
        cell.tagView.padding = UIEdgeInsetsMake(5, 10, 5, 10);
        cell.tagView.lineSpacing = 20;
        cell.tagView.interitemSpacing = 11;
        
        NSArray *arr = [self.dataSource[indexpath.row] allValues][0];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            SKTag *tag = [[SKTag alloc] initWithText:arr[idx]];
            tag.font = [UIFont boldSystemFontOfSize:13];
//
//            tag.bgImg = [UIImage imageNamed:@"FE9C970DA8AD4263ABA40AFA572A0538.jpg"];
            tag.padding = UIEdgeInsetsMake(5, 5, 5, 5);
            tag.cornerRadius = 5;
            tag.borderWidth = 0;
            if (indexpath.row == 0) {
                if (idx == self.idx1) {
                    tag.textColor = selectedColor;
                    tag.bgColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
                }
            }
            else
            {
                if (idx == self.idx2) {
                    tag.textColor = selectedColor;
                    tag.bgColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
                }
            }
            [cell.tagView addTag:tag];
            
            
        }];
        
        cell.tagView.didTapTagAtIndex = ^(NSUInteger idx,SKTagView *tagView)
        {
            
            ProductTableViewCell *cell = (ProductTableViewCell *)[[tagView superview] superview];
            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
            if (indexPath.row == 0) {
                self.idx1 = idx;
            }
            else
            {
                self.idx2 = idx;
            }
            NSLog(@"点击了第%ld行，第%ld个",indexPath.row,idx);
//            NSString *name = [self.dataSource[indexPath.row] allValues][0][idx];
            
            self.chooseLabel.text = [NSString stringWithFormat:@"%@:%@,%@:%@",[self.dataSource[0] allKeys][0],[self.dataSource[0] allValues][0][self.idx1],[self.dataSource[1] allKeys][0],[self.dataSource[1] allValues][0][self.idx2]];
            [self.tableView reloadData];
//            TWTProductModelDetail *modelDetail = self.modelDetailDataSource[indexPath.row - 1];
//            for (NSInteger i = 0; i < modelDetail.values.count; i ++)
//            {
//                if (i == idx)
//                {
//                    modelDetail.selectValue = modelDetail.values[i];
//                }
//            }
//            [self.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
        };
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.dataSource.count) {
        return 50;
    }
    else
    {
        return [tableView fd_heightForCellWithIdentifier:identyfy1 cacheByIndexPath:indexPath configuration:^(id cell) {
           
            [self congifCell:cell indexpath:indexPath];
        }];
    }
}

- (void)dealloc
{
    NSLog(@"%s____dealloc",object_getClassName(self));
}




- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] initWithArray:@[@{@"颜色":@[@"红色",@"蓝色",@"藏青色",@"超级无敌屎黄色",@"超级鲜艳绿油油",@"白色",@"黑色",@"图图图图图色"]},@{@"尺码":@[@"L",@"M",@"X",@"XXXL",@"XXXXXXXXL",@"超级无敌大",@"超级无敌小",@"真的小道没朋友,那你买个P啊",@"地表最强",@"真的小道没朋友",@"大到没朋友，那么胖，别买了"]}]];
    }
    return _dataSource;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
