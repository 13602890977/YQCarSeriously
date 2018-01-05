//
//  YQHomeCell.h
//  CarSeriously
//
//  Created by apple on 2017/12/26.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YQHomeCell;
@protocol YQHomeCellDelegate<NSObject>

@optional
- (void)homeQueryVinCellSelector:(YQHomeCell *)cell;
@end

@interface YQHomeCell : UITableViewCell


@property(nonatomic,weak) id<YQHomeCellDelegate> delegate;

+ (instancetype)homeCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
