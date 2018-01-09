//
//  YQSelectReportViewController.m
//  CarSeriously
//
//  Created by apple on 2018/1/5.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//
//选择报告
#import "YQSelectReportViewController.h"

#import "YQSelectReportHeaderView.h"
#import "YQSelectReportTypeCell.h"
#import "YQSelectReportTypeItem.h"
@interface YQSelectReportViewController ()

@property(nonatomic,strong)NSMutableArray<YQSelectReportTypeItem *> *dataArr;
@end

@implementation YQSelectReportViewController

- (instancetype)init {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YQSelectReportHeaderView *headerView = [[YQSelectReportHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.contentSize.width, 400)];
    headerView.fraction = 800;
    self.tableView.tableHeaderView = headerView;
    
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"选择报告类型:";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YQSelectReportTypeCell *cell = [YQSelectReportTypeCell reportTypeCellWithTableView:tableView];
    cell.dataItem = self.dataArr[indexPath.row];
    return cell;
}

- (NSMutableArray<YQSelectReportTypeItem *> *)dataArr {
    if (_dataArr == nil) {
        NSMutableArray *arr = [NSMutableArray array];
        NSArray *arr2 = @[
                          @{@"rightImgStr":@"maintenance-icon",@"titleStr":@"维修保养记录",@"priceStr":@"8.88",@"contentStr":@"查询一辆车的泡水、过火、维修保养记录",@"isSelect":@true,@"attStr":@"维修保养",@"hasIsData":@true},
  @{@"rightImgStr":@"insurance-icon",@"titleStr":@"保险记录",@"priceStr":@"18.88",@"contentStr":@"查询一辆车投保记录，包括投保险种、保险信息",@"isSelect":@true,@"attStr":@"险种、保险",@"hasIsData":@true},
  @{@"rightImgStr":@"transfer-icon",@"titleStr":@"过户记录",@"priceStr":@"",@"contentStr":@"查询一辆车过户记录",@"isSelect":@false,@"attStr":@"",@"hasIsData":@false},
  @{@"rightImgStr":@"modified-icon",@"titleStr":@"改装记录",@"priceStr":@"",@"contentStr":@"查询一辆车的改装记录",@"isSelect":@false,@"attStr":@"",@"hasIsData":@false},
  @{@"rightImgStr":@"outInsurance-icon",@"titleStr":@"出险记录",@"priceStr":@"",@"contentStr":@"查询一辆车的出险记录",@"isSelect":@false,@"attStr":@"",@"hasIsData":@false},
  @{@"rightImgStr":@"mortgage-icon",@"titleStr":@"抵押记录",@"priceStr":@"",@"contentStr":@"查询一辆车的抵押记录",@"isSelect":@false,@"attStr":@"",@"hasIsData":@false}
  ];
        for (NSDictionary *dict in arr2) {
            YQSelectReportTypeItem *item = [YQSelectReportTypeItem selectItemWithDict:dict];
            [arr addObject:item];
        }
        _dataArr = arr;
    }
    return _dataArr;
}
@end
