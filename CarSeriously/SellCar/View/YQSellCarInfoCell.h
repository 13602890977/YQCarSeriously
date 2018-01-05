//
//  YQSellCarInfoCell.h
//  CarSeriously
//
//  Created by apple on 2018/1/3.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQSellCarInfoModel.h"
@interface YQSellCarInfoCell : UITableViewCell

@property(nonatomic,strong)YQSellCarInfoModel *model;

+ (instancetype)sellCarCellWithTableView:(UITableView *)tableView;
@end
