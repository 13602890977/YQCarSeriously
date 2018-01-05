//
//  YQCarReportDetailCell.m
//  CarSeriously
//
//  Created by apple on 2018/1/4.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//

#import "YQCarReportDetailCell.h"

@interface YQCarReportDetailCell()

@property(nonatomic,strong)UIImageView *carIconImageView;
@property(nonatomic,strong)UILabel *carPartsLabel;
@property(nonatomic,strong)UILabel *partDetailLabel;

@end
@implementation YQCarReportDetailCell

- (void)setDetailItem:(YQCarPartReportDetailItem *)detailItem {
    _detailItem = detailItem;
    
    self.carIconImageView.image = detailItem.partImg;
    self.carPartsLabel.text = detailItem.partName;
    self.accessoryView = [[UIImageView alloc] initWithImage:detailItem.accessoryImg];
    self.partDetailLabel.text = detailItem.partReportStr;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.carIconImageView];
        [_carIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(10);
            make.height.mas_equalTo(28);
            make.width.equalTo(_carIconImageView.mas_height);
            
        }];
        
        [self.contentView addSubview:self.carPartsLabel];
        [_carPartsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.carIconImageView.mas_right).offset(10);
            make.top.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.width.mas_equalTo(100);
            make.height.mas_greaterThanOrEqualTo(21);
        }];
        
        [self.contentView addSubview:self.partDetailLabel];
        [_partDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.carPartsLabel.mas_right).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.centerY.equalTo(self.contentView);
            make.height.mas_greaterThanOrEqualTo(21);
        }];
        
    }
    return self;
}
+ (instancetype)carReportCellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"carReportDetailCellIdentifier";
    YQCarReportDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[YQCarReportDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    return cell;
}

- (UIImageView *)carIconImageView {
    if (_carIconImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, self.contentView.height - 20, self.contentView.height - 20)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        _carIconImageView = imageView;
    }
    return _carIconImageView;
}

- (UILabel *)carPartsLabel {
    if (_carPartsLabel == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.carIconImageView.maxX + 10, 10, 100, 40)];
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        _carPartsLabel = label;
    }
    return _carPartsLabel;
}

- (UILabel *)partDetailLabel {
    if (_partDetailLabel == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.carPartsLabel.maxX + 10, 10, 100, 40)];
        _partDetailLabel = label;
    }
    return _partDetailLabel;
}
@end
