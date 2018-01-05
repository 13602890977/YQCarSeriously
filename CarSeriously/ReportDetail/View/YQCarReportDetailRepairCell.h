//
//  YQCarReportDetailRepairCell.h
//  CarSeriously
//
//  Created by apple on 2018/1/5.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQCarReportDetailRepairCell : UITableViewCell
//数据测试
@property(nonatomic,strong)NSArray *labelStrArr;
+ (instancetype)repairCellWithTableView:(UITableView *)tableView;
@end
