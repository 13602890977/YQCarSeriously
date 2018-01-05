//
//  YQReportDetailViewController.m
//  CarSeriously
//
//  Created by apple on 2018/1/4.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//
//报告详情

#import "YQReportDetailViewController.h"
#import "YQReportDetailHeaderView.h"
#import "YQCarReportDetailCell.h"
#import "YQCarPartReportDetailItem.h"
#import "YQReportDetailSectionHeaderView.h"
#import "YQCarReportDetailRepairCell.h"
#import "YQHomeHeaderLabel.h"

@interface YQReportDetailViewController ()

@property(nonatomic,strong)YQReportDetailHeaderView *headerView;

@property(nonatomic,strong)NSMutableArray<YQCarPartReportDetailItem *> *firstSectionDataArr;
@property(nonatomic,strong)NSMutableArray<NSMutableDictionary *> *sectionHeaderDataArr;
@property(nonatomic,strong)NSMutableArray<NSMutableArray<NSString *> *> *secondSectionDataArr;

@end

@implementation YQReportDetailViewController

- (instancetype)init {
    return [super initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"报告详情";
    
    YQReportDetailHeaderView *headerView = [[YQReportDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 310)];
    self.tableView.tableHeaderView = headerView;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    
    [self setFooterView];
    
    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"YQCarPart.plist" ofType:nil];
    NSArray<NSDictionary *> *arr = [NSArray arrayWithContentsOfFile:pathStr];
    for (NSDictionary *dit in arr) {
        YQCarPartReportDetailItem *item = [YQCarPartReportDetailItem itemWithDict:dit];
        [self.firstSectionDataArr addObject:item];
    }
    
}
- (void)setFooterView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.contentSize.width, 200)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    
    YQHomeHeaderLabel *footerHeaderLabel = [YQHomeHeaderLabel labelHasLineWithFrame:CGRectMake(0, 0, footerView.width, 40) text:@"免责声明"];
    [footerView addSubview:footerHeaderLabel];
    [footerHeaderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footerView.yq_safeAreaLayoutGuideLeft);
        make.right.equalTo(footerView.yq_safeAreaLayoutGuideRight);
        make.top.equalTo(footerView.yq_safeAreaLayoutGuideTop);
        make.height.mas_equalTo(40);
    }];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, footerView.width, 21)];
    label.text = @"        本报告提供的所有内容及判断仅截止至到报告购买日期收集的相关数据信息。关于此车辆其他信息（包括但不仅限于在非4S店或非授权制造商的维修保养信息）可能未被采集和收录。本报告仅是交易参考资料之一。请你结合实车勘验结果和试乘体验，做出更准确的决策。";
    label.numberOfLines = 0;
//    label.lineBreakMode = NSLineBreakByWordWrapping;
    [footerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footerView.yq_safeAreaLayoutGuideLeft).offset(10);
        make.right.equalTo(footerView.yq_safeAreaLayoutGuideRight).offset(-10);
        make.top.equalTo(footerHeaderLabel.mas_bottom);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    self.tableView.tableFooterView = footerView;
}
#pragma mark tableView delegate/datasource
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YQReportDetailSectionHeaderView *headerView = [YQReportDetailSectionHeaderView headerViewWithFrame:CGRectMake(0, 0, self.tableView.contentSize.width, 40) section:section];
   
    headerView.dataDict = self.sectionHeaderDataArr[section];
    __weak typeof(self) weakSelf = self;
    headerView.block = ^(NSInteger section, BOOL isdwon) {
        
        [weakSelf.sectionHeaderDataArr[section] setObject:[NSNumber numberWithBool:isdwon] forKey:@"isDown"];
        
        if (section == 0) {
            
            if (isdwon) {
                NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"YQCarPart.plist" ofType:nil];
                NSArray<NSDictionary *> *arr = [NSArray arrayWithContentsOfFile:pathStr];
                for (NSDictionary *dit in arr) {
                    YQCarPartReportDetailItem *item = [YQCarPartReportDetailItem itemWithDict:dit];
                    [weakSelf.firstSectionDataArr addObject:item];
                }
            }else {
                [weakSelf.firstSectionDataArr removeAllObjects];
                weakSelf.firstSectionDataArr = nil;
                
            }
        }else {
            if (isdwon) {
                NSMutableArray<NSString *> *arr2 = [NSMutableArray array];
                [arr2 addObjectsFromArray:@[@"2015-11-10",@"35公里",@"第一次维修保养",@"第一次维修保养",@"awakeFromNib",@"客户留站，回访，手机，二十四小时，求炮友，各种打飞机，真是够了"]];
                
                NSMutableArray<NSString *> *arr3 = [NSMutableArray array];
                [arr3 addObjectsFromArray:@[@"2017-01-10",@"35789公里",@"第二次维修保养",@"第二次维修保养",@"发动机机油（4升，壳牌）*1，发动机机油（4升，壳牌）*1；油液滤清器 126005566*1发动机机油（4升，壳牌）*1，发动机机油（4升，壳牌）*1；油液滤清器 126005566*1",@"客户留站，回访，手机"]];
                [weakSelf.secondSectionDataArr addObject:arr2];
                [weakSelf.secondSectionDataArr addObject:arr3];
            }else {
                [weakSelf.secondSectionDataArr removeAllObjects];
                
            }
        }
        NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:section];
        [weakSelf.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade]; 
    };
    return headerView;
  
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.firstSectionDataArr.count;
    }
    return self.secondSectionDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        YQCarReportDetailCell *cell = [YQCarReportDetailCell carReportCellWithTableView:tableView];
        cell.detailItem = self.firstSectionDataArr[indexPath.row];
        return  cell;
    }else {
        YQCarReportDetailRepairCell *cell = [YQCarReportDetailRepairCell repairCellWithTableView:tableView];
        cell.labelStrArr = self.secondSectionDataArr[indexPath.row];
        return cell;
    }
    
}

#pragma mark - lazy load
- (NSMutableArray<YQCarPartReportDetailItem *> *)firstSectionDataArr {
    if (_firstSectionDataArr == nil) {
        NSMutableArray *arr = [NSMutableArray array];
        _firstSectionDataArr = arr;
    }
    return _firstSectionDataArr;
}
- (NSMutableArray<NSMutableDictionary *> *)sectionHeaderDataArr {
    if (_sectionHeaderDataArr == nil) {
        NSMutableDictionary *dit = [[NSMutableDictionary alloc] initWithDictionary:@{@"isDown":@1,@"title":@"概要信息"}
         ];
        NSMutableDictionary *dit2 = [[NSMutableDictionary alloc] initWithDictionary:@{@"isDown":@1,@"title":@"保养记录"}];
        NSMutableDictionary *dit3 = [[NSMutableDictionary alloc] initWithDictionary:@{@"isDown":@1,@"title":@"免责条款"}];
        NSMutableArray<NSMutableDictionary*> *arr = [NSMutableArray arrayWithObjects:dit,dit2,dit3,nil];
        _sectionHeaderDataArr = arr;
    }
    return _sectionHeaderDataArr;
}

- (NSMutableArray<NSMutableArray<NSString *> *> *)secondSectionDataArr {
    if (_secondSectionDataArr == nil) {
        
        NSMutableArray<NSMutableArray<NSString *> *> *arr = [NSMutableArray array];
        NSMutableArray<NSString *> *arr2 = [NSMutableArray array];
        [arr2 addObjectsFromArray:@[@"2015-11-10",@"35公里",@"第一次维修保养",@"第一次维修保养",@"awakeFromNib",@"客户留站，回访，手机，二十四小时，求炮友，各种打飞机，真是够了"]];
        
        NSMutableArray<NSString *> *arr3 = [NSMutableArray array];
        [arr3 addObjectsFromArray:@[@"2017-01-10",@"35789公里",@"第二次维修保养",@"第二次维修保养",@"发动机机油（4升，壳牌）*1，发动机机油（4升，壳牌）*1；油液滤清器 126005566*1发动机机油（4升，壳牌）*1，发动机机油（4升，壳牌）*1；油液滤清器 126005566*1",@"客户留站，回访，手机"]];
        
        [arr addObject:arr2];
        [arr addObject:arr3];
        _secondSectionDataArr = arr;
    }
    return _secondSectionDataArr;
}

@end
