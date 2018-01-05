//
//  YQCarCollectionCell.m
//  CarSeriously
//
//  Created by apple on 2017/12/25.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//
//车辆收藏

#import "YQCarCollectionCell.h"

@interface YQCarCollectionCell()

@property(nonatomic,strong)UIView *baseView;
@property(nonatomic,strong)UIImageView*carImageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UIButton *reportBtn;

@property(nonatomic,strong)NSIndexPath *path;
@end

@implementation YQCarCollectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.baseView];
        [self.baseView addSubview:self.carImageView];
        [self.baseView addSubview:self.titleLabel];
        [self.baseView addSubview:self.contentLabel];
        [self.baseView addSubview:self.reportBtn];
        [self.baseView addSubview:self.priceLabel];
        [self setAllConstraints];
    }
    return self;
}


+ (YQCarCollectionCell *)cellCreatWithTabelView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"collectionIdentifier";
    YQCarCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[YQCarCollectionCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.path = indexPath;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = COLOR_RGB(230, 230, 0xe6);
    }
    return cell;
}

#pragma mark - reportBtn click
- (void)reportBtnClick:(UIButton *)button {
    NSLog(@"%ld",self.path.row);
}
#pragma mark - lazy control
- (UIView *)baseView {
    if (_baseView == nil) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(8, 8, self.contentView.width - 16, 100)];
        view.backgroundColor = [UIColor whiteColor];
        _baseView = view;
    }
    return _baseView;
}

- (UIImageView *)carImageView {
    if (_carImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 120, self.baseView.height - 16)];
        imageView.backgroundColor = [UIColor blueColor];
        _carImageView = imageView;
        
    }
    return _carImageView;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.carImageView.maxX + 8, 10, self.baseView.width - 16 - self.carImageView.width, 20)];
        label.text = @"宝马 宝马7系 2009款 730Li豪华型";
        
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.carImageView.maxX + 8, self.titleLabel.maxY + 10, self.baseView.width - 16 - self.carImageView.width, 20)];
        label.text = @"宝马 宝马7系 2009款 730Li豪华型";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor grayColor];
        _contentLabel = label;
    }
    return _contentLabel;
}

- (UIButton *)reportBtn {
    if (_reportBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.baseView.width - 8 - 60, self.contentLabel.maxY + 10, 80, 24);
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor = KCarSeriouslyMainColor;
        [btn setTitle:@"车较真报告" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(reportBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _reportBtn = btn;
    }
    return _reportBtn;
}

- (UILabel *)priceLabel {
    if (_priceLabel == nil) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.carImageView.maxX + 8, self.contentLabel.maxY + 10, self.baseView.width - 16 - self.carImageView.width - self.reportBtn.width, 24)];
        label.text = @"￥13.90万";
        label.font = [UIFont systemFontOfSize:18];
        label.textColor = [UIColor orangeColor];
        _priceLabel = label;
    }
    return _priceLabel;
}

#pragma mark - 添加控件的约束
- (void)setAllConstraints {
    
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.yq_safeAreaLayoutGuideLeft).offset(8);
        make.right.equalTo(self.contentView.yq_safeAreaLayoutGuideRight).offset(-8);
        make.top.equalTo(self.contentView.yq_safeAreaLayoutGuideTop).offset(8);
        make.height.mas_equalTo(self.baseView.height);
        make.bottom.mas_equalTo(-8);
    }];
    [self.carImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.carImageView.width);
        make.left.top.equalTo(self.baseView).offset(8);
        make.bottom.equalTo(self.baseView.mas_bottom).offset(-8);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top).offset(10);
        make.left.equalTo(self.carImageView.mas_right).offset(8);
        make.right.equalTo(self.baseView.mas_right).offset(-8);
        make.height.mas_equalTo(self.titleLabel.height);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
        make.left.equalTo(self.carImageView.mas_right).offset(8);
        make.right.equalTo(self.baseView.mas_right).offset(-8);
        make.height.mas_equalTo(self.contentLabel.height);
    }];
    
    [self.reportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.baseView.mas_bottom).offset(-8);
        make.right.equalTo(self.baseView.mas_right).offset(-8);
        make.height.mas_equalTo(self.reportBtn.height);
        make.width.mas_equalTo(self.reportBtn.width);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.baseView.mas_bottom).offset(-8);
        make.left.equalTo(self.carImageView.mas_right).offset(8);
        make.right.equalTo(self.reportBtn.mas_left).offset(-8);
        make.height.mas_equalTo(self.priceLabel.height);
    }];
    
}
@end
