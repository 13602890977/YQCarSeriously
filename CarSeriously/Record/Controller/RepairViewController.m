//
//  RepairViewController.m
//  CarSeriously
//
//  Created by apple on 17/7/5.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "RepairViewController.h"

#import "RepairTableViewCell.h"
#import "YQRightImgButton.h"

#import "YQReportStateMenuView.h"
#import "YQReportMenuItem.h"
#import "YQSelectReportViewController.h"
@interface RepairViewController ()<YQReportStateMenuViewDelegate>

@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)YQRightImgButton *screenBtn;
@end

@implementation RepairViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)setHeaderView {
    //tableview 的headerView 不需要约束，系统自动适应
//    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
//    }];
    
    UIView *headerContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, self.tableView.width, 40)];
    headerContentView.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:headerContentView];
    [headerContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
    }];
    [self.headerView addSubview:self.screenBtn];
    [self.screenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        
    }];
}
#pragma mark - 状态选择按钮点击事件
- (void)screenBtnClick:(UIButton *)button {
    button.enabled = false;
    button.imageView.transform = CGAffineTransformMakeRotation(M_PI);
  
    YQReportStateMenuView *menuView = [YQReportStateMenuView menuShowWithViewBottom:button toView:self.tableView.superview];
    //使用KVC将数据转模型，数据的key要跟model一致
    NSArray<NSDictionary *> *arr = @[@{@"name":@"全部",@"itemId":@"11"},@{@"name":@"待支付",@"itemId":@"12"},@{@"name":@"完成支付",@"itemId":@"13"}];
    NSMutableArray<YQReportMenuItem *> *dataArr = [NSMutableArray array];
    for (NSDictionary *dict in arr) {
        YQReportMenuItem *item = [YQReportMenuItem menuItemWithDic:dict];
        [dataArr addObject:item];
    }
    menuView.menuDataArr = dataArr;
    menuView.delegate = self;
}
#pragma mark - yqreportStateMenuView delegate
- (void)menuCellDidSelector:(YQReportStateMenuView *)menuView cellItem:(YQReportMenuItem *)cellItem {
    
    self.screenBtn.enabled = true;
    self.screenBtn.imageView.transform = CGAffineTransformIdentity;
    
    [self.screenBtn setTitle:[NSString stringWithFormat:@"状态：%@",cellItem.name] forState:UIControlStateNormal];
    
    [menuView removeFromSuperview];
}
- (void)menuTouchBegin:(YQReportStateMenuView *)menuView {
    self.screenBtn.enabled = true;
    self.screenBtn.imageView.transform = CGAffineTransformIdentity;
    [menuView removeFromSuperview];
}
#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YQSelectReportViewController *selectVC = [[YQSelectReportViewController alloc] init];
    selectVC.hidesBottomBarWhenPushed = true;
    
    [self.navigationController pushViewController:selectVC animated:true];
}
#pragma mark - tableView dataSource
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
     [self setHeaderView];
    return self.headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *repairIdentifier = @"repairIdentifierCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:repairIdentifier];
    if (cell == nil) {
        cell = [[RepairTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:repairIdentifier];
    }
    return cell;
}

#pragma mark - lazy load
- (UIView *)headerView {
    if (_headerView == nil) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 60)];
        
        view.backgroundColor = COLOR_RGB(230, 230, 230);
        _headerView = view;
    }
    return _headerView;
}
- (YQRightImgButton *)screenBtn {
    if (_screenBtn == nil) {
        YQRightImgButton *button = [YQRightImgButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, 0, self.tableView.width - 20, 40);
        
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setTitle:@"状态：全部" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"down-icon"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(screenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _screenBtn = button;
    }
    return _screenBtn;
}

@end
