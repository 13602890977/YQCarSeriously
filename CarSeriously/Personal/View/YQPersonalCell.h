//
//  YQPersonalCell.h
//  CarSeriously
//
//  Created by apple on 2017/12/20.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQPersonalCellItem.h"

@interface YQPersonalCell : UITableViewCell


@property(nonatomic,strong)YQPersonalCellItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView cellStyle:(UITableViewCellStyle)cellStyle;
@end
