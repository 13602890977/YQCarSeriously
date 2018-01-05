//
//  HomeTableViewCell.h
//  CarSeriously
//
//  Created by apple on 17/7/7.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeCollectionCellDelegate <NSObject>

- (void)homeCollectionCellDidSelectedBackStr:(NSString *)cellName;

@end

@interface HomeTableViewCell : UITableViewCell

/**用于接受图片的名称*/
@property(nonatomic,strong) NSArray<NSString *> *collectionCellDataArr;

@property(nonatomic,assign) id<HomeCollectionCellDelegate> delegate;

+ (instancetype)homeCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
