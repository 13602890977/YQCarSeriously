//
//  HomeTableViewCell.m
//  CarSeriously
//
//  Created by apple on 17/7/7.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "HomeTableViewCell.h"

#import "HomeCollectionViewCell.h"
#import "YQHomeHeaderLabel.h"

@interface HomeTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)YQHomeHeaderLabel *headerLabel;

@property (nonatomic,strong) UICollectionView *mainCollectionView;


@property(nonatomic,strong) UIImageView *collectionCellImageView;
@property(nonatomic,strong) UILabel *collectionCellLabel;



@end


@implementation HomeTableViewCell

@synthesize mainCollectionView = _mainCollectionView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = COLOR_RGB(230, 230, 230);
        
        [self.contentView addSubview:self.mainCollectionView];
        
        
        [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
           
            make.height.mas_equalTo(self.mainCollectionView.height);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.contentView);
        }];
        
        _mainCollectionView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
        self.headerLabel.frame = CGRectMake(0, -21, self.mainCollectionView.width, 21);
        [_mainCollectionView addSubview:self.headerLabel];
        
    }
    return self;
}

+ (instancetype)homeCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"homeCollectionCellIdentifier";
    
    HomeTableViewCell *cell = (HomeTableViewCell *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    return cell;
}

#pragma mark - collectionView delegate 
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionCellDataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeMainCollectionViewCellIdentifier" forIndexPath:indexPath];
    cell.imageName = self.collectionCellDataArr[indexPath.row];
    
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(homeCollectionCellDidSelectedBackStr:)]) {
        [self.delegate homeCollectionCellDidSelectedBackStr:self.collectionCellDataArr[indexPath.row]];
    }
}

//setter / getter

#pragma mark - 懒加载控件


- (YQHomeHeaderLabel *)headerLabel {
    if (_headerLabel == nil) {
        _headerLabel = [YQHomeHeaderLabel labelHasLineWithFrame:CGRectMake(0, 8, 300, 21) text:@"验真服务"];
    }
    return _headerLabel;
}
- (UICollectionView *)mainCollectionView{
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(SCRW / 3 - 30, SCRW / 3 - 20);
        flowLayout.sectionInset = UIEdgeInsetsMake(15, 10, self.contentView.height - (SCRW / 3 - 20) - 15 , 10);
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCRW, 160) collectionViewLayout:flowLayout];
        
        collectionView.backgroundColor = [UIColor whiteColor];
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        [collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"homeMainCollectionViewCellIdentifier"];
        
        _mainCollectionView = collectionView;
        
    }
    return _mainCollectionView;
}

@end
