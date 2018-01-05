//
//  YQCarReportDetailCell.h
//  CarSeriously
//
//  Created by apple on 2018/1/4.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQCarPartReportDetailItem.h"

@interface YQCarReportDetailCell : UITableViewCell

@property(nonatomic,strong)YQCarPartReportDetailItem *detailItem;

+ (instancetype)carReportCellWithTableView:(UITableView *)tableView;
@end
