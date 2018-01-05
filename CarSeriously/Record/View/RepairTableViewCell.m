//
//  RepairTableViewCell.m
//  CarSeriously
//
//  Created by apple on 17/7/5.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "RepairTableViewCell.h"

@interface RepairTableViewCell()

/**车辆品牌*/
@property(nonatomic,strong)UILabel *carNameLabel;


/**保养记录+保险记录*/
@property(nonatomic,strong)UILabel *catalogLabel;

/**VIN码*/
@property(nonatomic,strong)UILabel *VinLabel;

@property(nonatomic,strong)UILabel *timeLabel;

/**记录状态btn*/
@property(nonatomic,strong)UIButton *orderTypeBtn;

@end

@implementation RepairTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.catalogLabel];
        //不确定宽度时，添加这句 -- 设置Label的挤压优先级，默认为default(250) UILayoutPriorityRequired(1000)，优先级越高，同级显示内容越完整
        [self.catalogLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.catalogLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-8);
            make.height.mas_equalTo(30);
            make.width.greaterThanOrEqualTo(@60);
        }];
        [self.contentView addSubview:self.carNameLabel];
        [self.carNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(8);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(30);
            make.right.lessThanOrEqualTo(self.catalogLabel.mas_left).offset(-8);
        }];
        
        [self.contentView addSubview:self.VinLabel];
        [self.VinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.carNameLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(8);
            make.right.mas_equalTo(8);
        }];
        
        [self.contentView addSubview:self.orderTypeBtn];
        [self.orderTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(100);
            make.right.mas_equalTo(-8);
            make.bottom.mas_equalTo(-10);
        }];
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(8);
            make.right.equalTo(self.orderTypeBtn.mas_left).offset(10);
            make.bottom.mas_equalTo(-20);
        }];
        
    }
    
    return self;
}

- (UILabel *)carNameLabel{
    if (_carNameLabel == nil) {
        _carNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, SCRW/4, 30)];
        _carNameLabel.text = @"上海通用别克 君越 2.4L A/MT";
        
    }
    return _carNameLabel;
}


- (UILabel *)catalogLabel {
    if (_catalogLabel == nil) {
        _catalogLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCRW - SCRW/4, 8, SCRW/4, 30)];
        _catalogLabel.textAlignment = NSTextAlignmentRight;
        _catalogLabel.text = @"(维修保养记录+保险记录)";
        
    }
    return _catalogLabel;
}

- (UILabel *)VinLabel{
    if (_VinLabel == nil) {
        _VinLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 140 - 30 - 30, SCRW/2, 30)];
        _VinLabel.text = @"VIN: LSGV53W9H218219";
        
    }
    return _VinLabel;
}

- (UIButton *)orderTypeBtn{
    if (_orderTypeBtn == nil) {
        _orderTypeBtn = [[UIButton alloc] init];
        _orderTypeBtn.frame = CGRectMake(SCRW - 80 - 8, 140 - 40 - 10, 80, 40);
        [_orderTypeBtn setTitle:@"待支付" forState:UIControlStateNormal];
        [_orderTypeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _orderTypeBtn.layer.cornerRadius = 8;
        _orderTypeBtn.backgroundColor = KCarSeriouslyMainColor;
    }
    return _orderTypeBtn;
}

- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
        label.text = @"2017.12.27 00:00";
        _timeLabel = label;
    }
    return _timeLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
