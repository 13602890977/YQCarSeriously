//
//  YQSelectReportTypeCell.h
//  CarSeriously
//
//  Created by apple on 2018/1/8.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YQSelectReportTypeItem.h"
@interface YQSelectReportTypeCell : UITableViewCell

@property(nonatomic,strong)YQSelectReportTypeItem *dataItem;
+ (instancetype)reportTypeCellWithTableView:(UITableView *)tableView;
@end
