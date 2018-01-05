//
//  YQNewFeatureCell.h
//  CarSeriously
//
//  Created by apple on 2017/12/19.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQNewFeatureCell : UICollectionViewCell

@property(nonatomic,strong)UIImage *image;

- (void)setBtnWithIndexPath:(NSIndexPath *)indexPath count:(int)count;
@end
