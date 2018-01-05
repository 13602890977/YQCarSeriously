//
//  YQQACellCell.h
//  CarSeriously
//
//  Created by apple on 2017/12/27.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YQQACellItem.h"

@interface YQQACellCell : UITableViewCell

@property(nonatomic,strong)YQQACellItem *item;

+ (instancetype)qaCellCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@end
