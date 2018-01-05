//
//  PersonalViewController.m
//  CarSeriously
//
//  Created by apple on 17/7/4.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "PersonalViewController.h"

#import "LoginViewController.h"
#import "YQPersonalInfoViewController.h"
#import "AboutTableViewController.h"

#import "YQGroupItem.h"
#import "YQPersonalCellArrowItem.h"
#import "YQPersonalCell.h"
#import "YQPersonalHeaderCellItem.h"
#import "YQCarCollectionViewController.h"
#import "YQFeedbackViewController.h"


@interface PersonalViewController()

@property(nonatomic,strong)NSMutableArray<YQGroupItem *> *cellDataArr;

@end

@implementation PersonalViewController

- (instancetype)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCRW, 0.000001)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    //初始化固定cell的数据
    [self setCellData];
    
}
- (void)setCellData {
    YQGroupItem *section1item = [[YQGroupItem alloc] init];
    
    //个人中心cell
    YQPersonalHeaderCellItem *persoonalCellItem = [YQPersonalHeaderCellItem itemWithImage:[UIImage imageNamed:@"HeadPortrait"] title:@"jack"];
    persoonalCellItem.detailTitle = @"136****9876";
    if (/* DISABLES CODE */ (1)) {//没登录
        persoonalCellItem.descC = LoginViewController.class;
    }else {
        persoonalCellItem.descC = [YQPersonalInfoViewController class];
    }
    
    
    //我的车辆
    YQPersonalCellArrowItem *carCellItem = [YQPersonalCellArrowItem itemWithImage:[UIImage imageNamed:@"exponent-icon"] title:@"我的车辆"];
    //我的收藏
    YQPersonalCellArrowItem *collectCellItem = [YQPersonalCellArrowItem itemWithImage:[UIImage imageNamed:@"collect-icon"] title:@"我的收藏"];
    collectCellItem.descC = [YQCarCollectionViewController class];
    
    section1item.itemArr = @[persoonalCellItem,carCellItem,collectCellItem];
    [self.cellDataArr addObject:section1item];
    
    YQGroupItem *section2item = [[YQGroupItem alloc] init];
    
    YQPersonalCellArrowItem *shareCellItem = [YQPersonalCellArrowItem itemWithImage:[UIImage imageNamed:@"sharing"] title:@"分享给好友"];
    YQPersonalCellArrowItem *opinionCellItem = [YQPersonalCellArrowItem itemWithImage:[UIImage imageNamed:@"feedback-icon"] title:@"意见反馈"];
    opinionCellItem.descC = [YQFeedbackViewController class];
    
    YQPersonalCellArrowItem *aboutCellItem = [YQPersonalCellArrowItem itemWithImage:[UIImage imageNamed:@"about-icon"] title:@"关于"];
    aboutCellItem.descC = [AboutTableViewController class];
    
    section2item.itemArr = @[shareCellItem,opinionCellItem,aboutCellItem];
    [self.cellDataArr addObject:section2item];
}
#pragma mark - tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cellDataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.cellDataArr[section].itemArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YQPersonalCell *cell = [YQPersonalCell cellWithTableView:tableView cellStyle:UITableViewCellStyleSubtitle];
    YQPersonalCellItem *item = self.cellDataArr[indexPath.section].itemArr[indexPath.row];
    if ([item isKindOfClass:[YQPersonalHeaderCellItem class]]) {
        tableView.rowHeight = 104.0f;
    }else {
        tableView.rowHeight = 50.0f;
    }
    cell.item = item;
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.00001;
    }
    return 0;//返回0等于使用系统默认高度
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YQPersonalCellItem *item = self.cellDataArr[indexPath.section].itemArr[indexPath.row];
    if (item.descC) {
        UIViewController *pushVC = [[item.descC alloc] init];
        pushVC.hidesBottomBarWhenPushed = true;
        
        [self.navigationController pushViewController:pushVC animated:true];
    }
    if (item.cellClickBlock != nil) {
        item.cellClickBlock(indexPath);
    }
}
#pragma mark - 切换横竖屏时响应这个方法
- (void)deviceOrientationDidChange:(id)changeObj {
    [self.tableView reloadData];
}
#pragma mark - 懒加载控件
- (NSMutableArray<YQGroupItem *> *)cellDataArr {
    if (_cellDataArr == nil) {
        _cellDataArr = [NSMutableArray array];
    }
    return _cellDataArr;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




@end
