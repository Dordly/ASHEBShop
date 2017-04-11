//
//  ViewController.m
//  ASHEBShop
//
//  Created by xmfish on 17/3/15.
//  Copyright © 2017年 ash. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+CustomColor.h"
#import "UIImage+ASHUtil.h"
#import "ShopItemCell.h"
#import "ASHHomeViewModel.h"
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import <AlibabaAuthSDK/ALBBSDK.h>
#import <ReactiveCocoa.h>
#import "ASHHomeModel.h"
#import "ASHSettingVC.h"
#import <MJRefresh.h>
#import <UMMobClick/MobClick.h>
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView* tableView;
@property (nonatomic, strong)UIButton* setBtn;
@property (nonatomic, strong)ASHHomeViewModel* viewModel;
@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"shoppage"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick endLogPageView:@"shoppage"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    UIImage* image = [UIImage imageNamed:@"backgroud13.jpg"];
    UIImage* image = [UIImage ash_imageFromColor:[UIColor whiteColor] andSize:CGSizeMake(1, 1) opaque:0.2];
//    image = [image imageByBlurRadius:10 tintColor:[UIColor colorWithWhite:0.6 alpha:0.3] tintMode:kCGBlendModeNormal saturation:1.0 maskImage:nil];;
    image = [image imageByBlurWithTint:[UIColor mainColor]];
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 456)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5.0;
    
    view.center = self.view.center;
//    [self.view addSubview:view];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(4, 0, self.view.bounds.size.width - 8, self.view.bounds.size.height - 0) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 180;
    self.tableView.layer.masksToBounds = YES;
    self.tableView.layer.cornerRadius = 5.0;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 64)];
    headerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = headerView;
    
    @weakify(self);
    MJRefreshNormalHeader* refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self requestData];
    }];
    refreshHeader.stateLabel.textColor = [UIColor whiteColor];
    refreshHeader.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];
    self.tableView.mj_header = refreshHeader;
    [self.view addSubview:self.tableView];
    
    MJRefreshAutoNormalFooter* refreshfooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self loadMore];
    }];
    refreshfooter.stateLabel.textColor = [UIColor whiteColor];
    self.tableView.mj_footer = refreshfooter;
    
    self.setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.setBtn.backgroundColor = [UIColor clearColor];
    [self.setBtn setBackgroundImage:[UIImage imageNamed:@"cart.png"] forState:UIControlStateNormal];
    self.setBtn.frame = CGRectMake(15, 25, 25, 25);
    
    
    
    [[self.setBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [MobClick event:@"shopcart"];
        id<AlibcTradePage> page = [AlibcTradePageFactory myCartsPage];
        AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
        showParam.openType = AlibcOpenTypeAuto;
//        showParam.isNeedPush = YES;
        [[AlibcTradeSDK sharedInstance].tradeService show: self page:page showParams:showParam taoKeParams: nil trackParam: nil tradeProcessSuccessCallback:nil tradeProcessFailedCallback:nil];
    }];
    [self.view addSubview:self.setBtn];
    
    
    _viewModel = [ASHHomeViewModel new];
    
    
    [self.tableView.mj_header beginRefreshing];
    
}
- (void)requestData
{
    [self bindViewModel];
    [_viewModel requestData];
}
- (void)loadMore
{
    [self bindViewModel];
    [_viewModel loadMore];
}
- (void)bindViewModel
{
    @weakify(self);
    [_viewModel.requestFinishedSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        if(!self.viewModel.hasMore){
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer resetNoMoreData];
        }
        [self.tableView reloadData];
    } error:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}
#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _viewModel.model.goodsJa.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopItemCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ShopItemCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ShopItemCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (_viewModel.model.goodsJa.count > indexPath.row) {
        ASHHomeItemModel* model = [_viewModel.model.goodsJa objectAtIndex:indexPath.row];
        cell.model = model;
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSDictionary *dict = @{@"index" : @(indexPath.row+1)};
    [MobClick event:@"shopclick" attributes:dict];
    
    AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
    showParam.openType = AlibcOpenTypeAuto;
    
    if (_viewModel.model.goodsJa.count > indexPath.row) {
        ASHHomeItemModel* model = [_viewModel.model.goodsJa objectAtIndex:indexPath.row];
        id<AlibcTradePage> page = [AlibcTradePageFactory page: model.goodsUrl];
        [[AlibcTradeSDK sharedInstance].tradeService show: self page:page showParams:showParam taoKeParams: nil trackParam: nil tradeProcessSuccessCallback:nil tradeProcessFailedCallback:nil];
        
    }
    
    //根据链接打开页面

}
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.y > 0){
        if(!self.setBtn.hidden){
            self.setBtn.hidden = YES;
        }
        
    }else{
        if (self.setBtn.hidden) {
            self.setBtn.hidden = NO;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
