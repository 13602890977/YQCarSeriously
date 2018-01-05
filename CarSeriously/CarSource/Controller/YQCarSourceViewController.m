//
//  YQCarSourceViewController.m
//  CarSeriously
//
//  Created by apple on 2017/12/20.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQCarSourceViewController.h"

#import "YQRightImgButton.h"
#import "YQReportMenuItem.h"
#import "YQReportStateMenuView.h"

#import "YQCarCollectionCell.h"
#import "YQCarBrandViewController.h"
#import "YQCarSourceReportStateMenuView.h"
#import "YQReportDetailViewController.h"

#define KCarConditionBtnTag 333
@interface YQCarSourceViewController ()<YQReportStateMenuViewDelegate>
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UIView *headerBtnView;

@property(nonatomic,strong)NSMutableArray<YQReportMenuItem *> *sortArr;
@end

@implementation YQCarSourceViewController

- (instancetype)init {
    
    return [self initWithStyle:UITableViewStylePlain];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"heading"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnClick:)];
    self.navigationItem.leftBarButtonItem.enabled = false;
    
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = false;
    
    self.navigationItem.titleView = self.searchBar;
    
    
}
- (void)setHeaderViewBtn {
    NSArray<NSString *> *arr = @[@"排序",@"品牌",@"价格",@"筛选"];
    NSArray<NSString *> *iconArr = @[@"down-icon",@"down-icon",@"down-icon",@"screening-icon"];
    YQRightImgButton *nextButton = nil;
    for (int i = 0; i < arr.count; i++) {
        YQRightImgButton *button = [YQRightImgButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*self.headerBtnView.width*0.25, 10, self.headerBtnView.width*0.25, 40);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:iconArr[i]] forState:UIControlStateNormal];
        button.tag = i + KCarConditionBtnTag;
        [button addTarget:self action:@selector(conditionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerBtnView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (nextButton) {
                make.left.equalTo(nextButton.mas_right);
            }else {
                make.left.equalTo(self.headerBtnView);
            }
            make.width.equalTo(self.headerBtnView).multipliedBy(0.25);
            make.height.mas_equalTo(40);
            make.top.equalTo(self.headerBtnView).offset(10);
        }];
        nextButton = button;
    }
}

- (void)conditionBtnClick:(UIButton *)button {
    switch (button.tag - KCarConditionBtnTag) {
        case 0://排序按钮
        {
            YQReportStateMenuView *menuView = [YQReportStateMenuView menuShowWithViewBottom:button toView:self.tableView.superview];
            
            menuView.menuDataArr = self.sortArr;
            menuView.delegate = self;
            break;
        }
        case 1://品牌按钮
        {
            YQCarBrandViewController *brand = [[YQCarBrandViewController alloc] init];
            brand.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:brand animated:true];
            break;
        }
        case 2://价格按钮
        {
            YQCarSourceReportStateMenuView *view = [YQCarSourceReportStateMenuView menuShowWithViewBottom:button toView:self.tableView.superview];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"endFullScreen" object:nil];
            YQReportMenuItem *item = [[YQReportMenuItem alloc] init];
            item.name = @"自定义价格";
            item.titleArr = @[@"0",@"10",@"20",@"30",@"40",@"50",@"不限"];
            item.itemId = @012;
            item.unit = @"万";
            view.menuDataArr = [NSMutableArray arrayWithObjects:item, nil];
            
            view.delegate = self;
            break;
        }
        case 3://高级筛选按钮
        {
            YQCarSourceReportStateMenuView *view = [YQCarSourceReportStateMenuView menuShowWithViewBottom:button toView:self.tableView.superview];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"endFullScreen" object:nil];
            YQReportMenuItem *cotyItem = [[YQReportMenuItem alloc] init];
            cotyItem.name = @"车龄";
            cotyItem.titleArr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"不限"];
            cotyItem.itemId = @123;
            cotyItem.unit = @"年";
            YQReportMenuItem *mileageItem = [[YQReportMenuItem alloc] init];
            mileageItem.name = @"里程";
            mileageItem.titleArr = @[@"0",@"2",@"4",@"6",@"8",@"10",@"不限"];
            mileageItem.unit = @"公里";
            mileageItem.itemId = @234;
            YQReportMenuItem *displacementItem = [[YQReportMenuItem alloc] init];
            displacementItem.name = @"排量";
            displacementItem.titleArr = @[@"0",@"1.0",@"2.0",@"3.0",@"4.0",@"不限"];
            displacementItem.itemId = @345;
            displacementItem.unit = @"L";
            view.menuDataArr = [NSMutableArray arrayWithObjects:cotyItem,mileageItem,displacementItem, nil];
            
            view.delegate = self;
            break;
        }
        default:
            break;
    }
}

- (void)leftBtnClick:(UIBarButtonItem *)barBtn {
    
}
#pragma mark - yqreportMenuView delegate
- (void)menuCellDidSelector:(YQReportStateMenuView *)menuView cellItem:(YQReportMenuItem *)cellItem {
    //GCD 快速迭代  异步执行刷新数据，但是要执行完迭代才会回到主线程，继续走下面的方法，保证数据刷新完成
    dispatch_apply(self.sortArr.count, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
        YQReportMenuItem *item = self.sortArr[index];
        if ([item isEqual:cellItem]) {
            item.isSelector = true;
        }else {
            item.isSelector = false;
        }
    });
    [menuView menuHidden];
}
- (void)menuTouchBegin:(YQReportStateMenuView *)menuView {
    
    [menuView menuHidden];
}
#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YQReportDetailViewController *detailVC = [[YQReportDetailViewController alloc] init];
    detailVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:detailVC animated:true];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    [self setHeaderViewBtn];
    return self.headerBtnView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YQCarCollectionCell *cell = [YQCarCollectionCell cellCreatWithTabelView:tableView indexPath:indexPath];
    
    return cell;
}
- (UISearchBar *)searchBar {
    if (_searchBar == nil) {
        
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCRW - 100, 44)];
        searchBar.placeholder = @"请输入您要搜索的车辆条件";
        _searchBar = searchBar;
    }
    return _searchBar;
}
- (UIView *)headerBtnView {
    if (_headerBtnView == nil) {
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCRW, 60)];
        baseView.backgroundColor = [UIColor whiteColor];
        _headerBtnView = baseView;
    }
    return _headerBtnView;
}
- (NSMutableArray<YQReportMenuItem *> *)sortArr {
    if (_sortArr == nil) {
        //使用KVC将数据转模型，数据的key要跟model一致
        NSArray<NSDictionary *> *arr = @[@{@"name":@"最新上架",@"itemId":@"11"},@{@"name":@"价格最低",@"itemId":@"12"},@{@"name":@"价格最高",@"itemId":@"13"},@{@"name":@"车龄最短",@"itemId":@"14"},@{@"name":@"里程最少",@"itemId":@"15"}];
        NSMutableArray<YQReportMenuItem *> *dataArr = [NSMutableArray array];
        //需要顺序的不能使用GCD 快速迭代
//        dispatch_apply(arr.count, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t i) {
//
//        });
        for (int i = 0;i < arr.count;i++) {
            NSDictionary *dict = arr[i];
            
            YQReportMenuItem *item = [YQReportMenuItem menuItemWithDic:dict];
            if (i == 0) {
                item.isSelector = true;
            }
            [dataArr addObject:item];
        }
        _sortArr = dataArr;
    }
    return _sortArr;
}
@end
