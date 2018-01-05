//
//  YQCarSourceCell.m
//  CarSeriously
//
//  Created by apple on 2017/12/29.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQCarSourceCell.h"

@interface YQCarSourceCell()

@end

@implementation YQCarSourceCell

+ (instancetype)carSourceCellCreatWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"carSourceCellIdentifier";
    
    YQCarSourceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

@end
