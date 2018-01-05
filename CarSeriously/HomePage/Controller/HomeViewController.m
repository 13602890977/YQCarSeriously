//
//  HomeViewController.m
//  CarSeriously
//
//  Created by apple on 17/7/4.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "HomeViewController.h"

#import "HomeRepairViewController.h"

#import "YQHomeHeaderView.h"
#import "YQHomeVINView.h"

#import "YQHomeCell.h"

#import "HomeTableViewCell.h"
#import "HomeTableViewScrollCell.h"
#import "HomeTableViewQACell.h"

#import "LoginViewController.h"

#import "YQHomeHeaderLabel.h"
#import "YQHomeLoanViewController.h"
#import "YQSellCarViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,YQHomeCellDelegate,HomeCollectionCellDelegate>

@property(nonatomic,strong)UITableView *mainTableView;

@property(nonatomic,strong)YQHomeHeaderView *adsHeaderView;



@end

@implementation HomeViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    self.view.backgroundColor = COLOR_RGB(230, 230, 230);
    
    //设置首页导航栏标题文字
    UIImageView *navTitleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"heading"]];
    self.navigationItem.titleView = navTitleImage;
    
    UIImage *image = [[UIImage imageNamed:@"heading-icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(leftNavBtnClick:)];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.yq_safeAreaLayoutGuideTop);
        make.left.equalTo(self.view.yq_safeAreaLayoutGuideLeft);
        make.right.equalTo(self.view.yq_safeAreaLayoutGuideRight);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    
    self.mainTableView.tableHeaderView = self.adsHeaderView;
    
    self.mainTableView.rowHeight = UITableViewAutomaticDimension;
    self.mainTableView.estimatedRowHeight = 300;
    
    
    [self setAdsScrollView];
    
    
}

- (void)leftNavBtnClick:(UIBarButtonItem *)btn {
    
}
- (void)deviceChange:(NSNotification *)nito {
    [self.mainTableView reloadData];
}
- (void)setAdsScrollView {
    //请求广告数据
    
    //根据广告数据改变adsScrollView和adsPage
    self.adsHeaderView.dataArr = @[@"banner",@"feedback",@"leadpage1",@"leadpage2",@"leadpage3"];
}


#pragma mark - tableview delegate/datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        
        HomeTableViewCell *cell = [HomeTableViewCell homeCellWithTableView:tableView indexPath:indexPath];
        cell.delegate = self;
        cell.collectionCellDataArr = @[@"sellCars",@"loan"];
        return cell;
    }else if (indexPath.row == 0){
        
        YQHomeCell *cell = [YQHomeCell homeCellWithTableView:tableView indexPath:indexPath];
        cell.delegate = self;
        
        return cell;
    }else if(indexPath.row == 2){
        HomeTableViewScrollCell *cell = [HomeTableViewScrollCell homeCellWithTableView:tableView indexPath:indexPath];
        
        return cell;
    }else {
        return [HomeTableViewQACell homeCellWithTableView:tableView indexPath:indexPath];
    }
    
}
#pragma mark - HomeTableViewCell delegate
- (void)homeCollectionCellDidSelectedBackStr:(NSString *)cellName {
    if ([cellName isEqualToString:@"loan"]) {//贷款
        YQHomeLoanViewController *loanVC = [[YQHomeLoanViewController alloc] init];
        loanVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:loanVC animated:true];
    }else {//卖车
        YQSellCarViewController *sellCarVC = [[YQSellCarViewController alloc] init];
        sellCarVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:sellCarVC animated:true];
    }
}
#pragma mark - YQHomeCell delegate
- (void)homeQueryVinCellSelector:(YQHomeCell *)cell {
    
}
#pragma mark - 懒加载属性控件
- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCRW, SCRH) style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = COLOR_RGB(230, 230, 230);
        
        [_mainTableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"homeCollectionCellIdentifier"];
        [_mainTableView registerClass:[YQHomeCell class] forCellReuseIdentifier:@"homeCellIdentifier"];
        [_mainTableView registerClass:[HomeTableViewScrollCell class] forCellReuseIdentifier:@"homeTableViewScrollCellIdentifier"];
        [_mainTableView registerClass:[HomeTableViewQACell class] forCellReuseIdentifier:@"homeTableViewQACellIdentifier"];
        
    }
    return _mainTableView;
}
- (YQHomeHeaderView *)adsHeaderView {
    if (_adsHeaderView == nil) {
        YQHomeHeaderView *view = [[YQHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCRW, 200)];
        _adsHeaderView = view;
    }
    return _adsHeaderView;
}


@end
