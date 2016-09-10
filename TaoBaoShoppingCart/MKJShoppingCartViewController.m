//
//  MKJShoppingCartViewController.m
//  TaoBaoShoppingCart
//
//  Created by MKJING on 16/9/10.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "MKJShoppingCartViewController.h"
#import <MJRefresh.h>
#import "shoppingCartModel.h"
#import "MKJRequestHelper.h"
#import "ShoppingCartCell.h"
#import <UIImageView+WebCache.h>
#import <UITableView+FDTemplateLayoutCell.h>

@interface MKJShoppingCartViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *buyerLists;
@property (nonatomic,strong) UIButton *rightButton;

// 底部统计View的控件 （normal）
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *allSelectedButton;
@property (weak, nonatomic) IBOutlet UIView *normalBottomRightView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *normalBottomRightWidthConstraint;
@property (weak, nonatomic) IBOutlet UIButton *accountButton;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

// 底部全局编辑按钮
@property (weak, nonatomic) IBOutlet UIView *editBottomRightView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *editBottomRightWidthConstraint;
@property (weak, nonatomic) IBOutlet UIButton *editBaby;
@property (weak, nonatomic) IBOutlet UIButton *bottomDelete;
@property (weak, nonatomic) IBOutlet UIButton *storeButton;

@end


static NSString *shoppongID = @"ShoppingCartCell";
static NSString *shoppingHeaderID = @"BuyerHeaderCell";

@implementation MKJShoppingCartViewController


- (void)dealloc
{
    NSLog(@"%s____dealloc",object_getClassName(self));
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 设置底部按钮
    CGRect rec = self.bottomView.frame;
    rec.size.width = [UIScreen mainScreen].bounds.size.width;
    rec.size.height = 50;
    rec.origin.x = 0;
    rec.origin.y = [UIScreen mainScreen].bounds.size.height - 50;
    self.bottomView.frame = rec;
    self.normalBottomRightWidthConstraint.constant = [UIScreen mainScreen].bounds.size.width * 2 / 3;
    self.editBottomRightWidthConstraint.constant = [UIScreen mainScreen].bounds.size.width * 2 / 3;
    [self.view addSubview:self.bottomView];
    self.editBottomRightView.hidden = YES;
    
    
    // 右上角编辑
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(0, 0, 40, 40);
    [self.rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(clickAllEdit:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *batbutton = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = batbutton;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:shoppongID bundle:nil] forCellReuseIdentifier:shoppongID];
    [self.tableView registerNib:[UINib nibWithNibName:shoppingHeaderID bundle:nil] forCellReuseIdentifier:shoppingHeaderID];
    self.title = @"购物车";
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    header.stateLabel.hidden = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 点击全部编辑按钮
- (void)clickAllEdit:(UIButton *)button
{
    
}



- (void)refreshData
{
    [[MKJRequestHelper shareRequestHelper] requestShoppingCartInfo:^(id obj, NSError *err) {
       // buyer Array
        [self.buyerLists removeAllObjects];
        self.buyerLists = (NSMutableArray *)obj;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
    }];
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.buyerLists.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BuyerInfo *buyer = self.buyerLists[section];
    return buyer.prod_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:shoppongID forIndexPath:indexPath];
    [self configCell:cell indexPath:indexPath];
    return cell;
}


- (void)configCell:(ShoppingCartCell *)cell indexPath:(NSIndexPath *)indexPath
{
    BuyerInfo *buyer = self.buyerLists[indexPath.section];
    ProductInfo *product = buyer.prod_list[indexPath.row];
    cell.leftChooseButton.selected = product.productIsChoosed;
    __weak typeof(cell)weakCell = cell;
    [cell.productImageView sd_setImageWithURL:[NSURL URLWithString:product.image] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image && cacheType == SDImageCacheTypeNone)
        {
            weakCell.productImageView.alpha = 0;
            [UIView animateWithDuration:1.0 animations:^{
               
                weakCell.productImageView.alpha = 1.0f;
            }];
            
        }
        else
        {
            weakCell.productImageView.alpha = 1.0f;
        }
    }];
    cell.titleLabel.text = product.title;
    if ([[MKJRequestHelper shareRequestHelper] isEmptyArray:product.model_detail])
    {
        cell.sizeDetailLabel.text = @"";
        cell.editDetailView.hidden = YES;
    }
    else
    {
        cell.editDetailView.hidden = NO;
        cell.sizeDetailLabel.text = @"这里测试规格数据这里测试规格数据这里测试规格数据这里测试规格数据这里测试规格数据这里测试规格数据这里测试规格数据";
        cell.editDetailTitleLabel.text = @"这里测试规格数据这里测试规格数据";
    }
    
    cell.priceLabel.attributedText = [[MKJRequestHelper shareRequestHelper] recombinePrice:product.cn_price orderPrice:product.order_price];
    
    cell.countLabel.text = [NSString stringWithFormat:@"x%ld",product.count];
    
    cell.editCountLabel.text = [NSString stringWithFormat:@"%ld",product.count];
    
    
    
    // 正常模式下面 非编辑
    if (!buyer.buyerIsEditing)
    {
        cell.normalBackView.hidden = NO;
        cell.editBackView.hidden = YES;
    }
    else
    {
        cell.normalBackView.hidden = YES;
        cell.editBackView.hidden = NO;
    }
}

// 高度计算
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuyerInfo *buyer = self.buyerLists[indexPath.section];
    if (buyer.buyerIsEditing)
    {
        return 100;
    }
    else
    {
        CGFloat actualHeight = [tableView fd_heightForCellWithIdentifier:shoppongID cacheByIndexPath:indexPath configuration:^(ShoppingCartCell *cell) {
            
            [self configCell:cell indexPath:indexPath];
            
        }];
        return actualHeight >= 100 ? actualHeight : 100;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BuyerInfo *buyer = self.buyerLists[section];
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:shoppingHeaderID];
    cell.headerSelectedButton.selected = buyer.buyerIsChoosed;
    [cell.buyerImageView sd_setImageWithURL:[NSURL URLWithString:buyer.user_avatar]];
    cell.buyerNameLabel.text = buyer.nick_name;
    cell.editSectionHeaderButton.selected = buyer.buyerIsEditing;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}






- (NSMutableArray *)buyerLists
{
    if (_buyerLists == nil) {
        _buyerLists = [[NSMutableArray alloc] init];
    }
    return _buyerLists;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
