//
//  YQIntervalValueCell.h
//  CarSeriously
//
//  Created by apple on 2017/12/29.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQReportMenuItem.h"

@interface YQIntervalValueCell : UITableViewCell

@property(nonatomic,strong)YQReportMenuItem *menuItem;

+ (instancetype)cellCreatWithTabelView:(UITableView *)tableView;
@end
