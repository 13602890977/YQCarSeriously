//
//  YQCarCollectionCell.h
//  CarSeriously
//
//  Created by apple on 2017/12/25.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQCarCollectionCell : UITableViewCell

@property (nonatomic, strong)NSDictionary *dictData;

+ (YQCarCollectionCell *)cellCreatWithTabelView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@end
