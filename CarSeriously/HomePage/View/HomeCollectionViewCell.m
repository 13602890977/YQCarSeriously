//
//  HomeCollectionViewCell.m
//  CarSeriously
//
//  Created by apple on 17/7/7.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@interface HomeCollectionViewCell()

@property(nonatomic,strong) UIView *baseView;
/**cell上的图片*/
@property(nonatomic,strong) UIImageView *collectionCellImageView;

/**cell的类型名称Label*/
@property(nonatomic,strong) UILabel *collectionCellLabel;

@end
@implementation HomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.baseView];

        [self.baseView addSubview:self.collectionCellImageView];

        [self.contentView addSubview:self.collectionCellLabel];

    }
    return self;
}

- (void)setImageName:(NSString *)imageName {
    
    _imageName = imageName;
    _collectionCellImageView.image = [UIImage imageNamed:imageName];
    NSDictionary *dict = @{@"loan":@"我要贷款",@"sellCars":@"我要卖车"};
    _collectionCellLabel.text = [dict objectForKey:imageName];
}


- (UIView *)baseView {
    if (_baseView == nil) {
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 80 , 80)];
        
        _baseView.backgroundColor = COLOR_RGB(239, 239, 244);
        _baseView.layer.borderColor = [UIColor grayColor].CGColor;
        _baseView.layer.borderWidth = 1;
        _baseView.layer.cornerRadius = 10;
    }
    return _baseView;
}
- (UIImageView *)collectionCellImageView {
    if (!_collectionCellImageView) {
        _collectionCellImageView = [[UIImageView alloc] initWithFrame:CGRectMake((_baseView.width - 64) * 0.5, (_baseView.height - 64) * 0.5, 64, 64)];
        _collectionCellImageView.image = [UIImage imageNamed:@"insurance"];
    }
    return _collectionCellImageView;
}

- (UILabel *)collectionCellLabel {
    if (!_collectionCellLabel) {
        _collectionCellLabel = [[UILabel alloc] initWithFrame:CGRectMake(_baseView.x, _baseView.maxY + 5, _baseView.width, 21)];
        _collectionCellLabel.text = @"查出险";
        _collectionCellLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _collectionCellLabel;
}
@end
