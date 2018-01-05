//
//  HomeTableViewScrollCell.h
//  CarSeriously
//
//  Created by apple on 17/7/10.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewScrollCell : UITableViewCell

@property(nonatomic,strong)NSArray *imageArr;

+ (instancetype)homeCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@end
