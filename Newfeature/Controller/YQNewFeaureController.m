//
//  YQNewFeaureController.m
//  CarSeriously
//
//  Created by apple on 2017/12/19.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQNewFeaureController.h"

#import "YQNewFeatureCell.h"

@interface YQNewFeaureController ()

@end

@implementation YQNewFeaureController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init {
    //创建流水布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [self initWithCollectionViewLayout:flowLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //必须先注册cell
    [self.collectionView registerClass:[YQNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //开启分页
    self.collectionView.pagingEnabled = true;
    //取消弹簧效果
    self.collectionView.bounces = false;
    //隐藏水平指示线
    self.collectionView.showsHorizontalScrollIndicator = false;
}
//返回每行cell的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 3;
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YQNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"leadpage%ld",indexPath.row + 1]];
    cell.image = image;
    //给最后一个cell添加跳转按钮
    [cell setBtnWithIndexPath:indexPath count:3];
    
    cell.backgroundColor = [UIColor greenColor];
    
    return cell;
    
    
}

@end
