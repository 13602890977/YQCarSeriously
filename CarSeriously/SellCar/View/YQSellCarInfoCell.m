//
//  YQSellCarInfoCell.m
//  CarSeriously
//
//  Created by apple on 2018/1/3.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//

#import "YQSellCarInfoCell.h"

@interface YQSellCarInfoCell()

@property(nonatomic,strong)UILabel *infoTitleLabel;
@property(nonatomic,strong)UITextField *infoTextField;
@end
@implementation YQSellCarInfoCell

- (void)setModel:(YQSellCarInfoModel *)model {
    _model = model;
    [self.contentView addSubview:self.infoTitleLabel];
    self.infoTitleLabel.text = model.titleStr;
    [self.infoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(10);
        make.width.mas_equalTo(100);
        make.bottom.mas_equalTo(-10);
    }];
    [self.contentView addSubview:self.infoTextField];
    [self.infoTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.mas_equalTo(10);
        make.left.equalTo(self.infoTitleLabel.mas_right).offset(10);
    }];
    self.infoTextField.placeholder = model.placeholderStr;
    if (model.keyBoardType) {
        self.infoTextField.keyboardType = model.keyBoardType;
    }else {
        self.infoTextField.enabled = false;
    }
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.infoTextField resignFirstResponder];
}
+ (instancetype)sellCarCellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"sellCarInfoCellIdentifier";
    YQSellCarInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    return cell;
}

- (UILabel *)infoTitleLabel {
    if (_infoTitleLabel == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 21)];
        _infoTitleLabel = label;
    }
    return _infoTitleLabel;
}
- (UITextField *)infoTextField {
    if (_infoTextField == nil) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
        _infoTextField = textField;
    }
    return _infoTextField;
}
@end
