//
//  YQSelectReportTypeCell.m
//  CarSeriously
//
//  Created by apple on 2018/1/8.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//

#import "YQSelectReportTypeCell.h"
#import "YQRecordCarNumView.h"

@interface YQSelectReportTypeCell()<UITextFieldDelegate>

@property(nonatomic,strong)UIView *baseView;
@property(nonatomic,strong)UIImageView *rightImageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *tipLabel;
@property(nonatomic,strong)UIImageView *leftImageView;

@property(nonatomic,strong)YQRecordCarNumView *numView;

@property(nonatomic,strong)UIButton *numIconBtn;

@property(nonatomic,strong)UITextField *numTextField;
@end

@implementation YQSelectReportTypeCell

- (void)setDataItem:(YQSelectReportTypeItem *)dataItem {
    _dataItem = dataItem;
    //设置右边的图片
    self.rightImageView.image = [UIImage imageNamed:dataItem.rightImgStr];
    //如果当前选择了，就显示左边的图片
    if (dataItem.isSelect) {
        self.leftImageView.image = [UIImage imageNamed:@"select"];
    }
    //设置cell的标题文字
    self.titleLabel.text = dataItem.titleStr;
    
    //如果是保险记录选项，就添加一个车牌输入框
    if ([dataItem.titleStr isEqualToString:@"保险记录"]) {
        [self setCarNumView];
    }
    //如果没有价格，就不显示价格label
    if (KStrIsEmpty(dataItem.priceStr)){
        self.priceLabel.text = nil;
    }else {
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@",dataItem.priceStr];
    }
    //如果有需要突出的文字，使用富文本
    if (!KStrIsEmpty(dataItem.attStr)) {
        NSRange range = [dataItem.contentStr rangeOfString:dataItem.attStr];
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:dataItem.contentStr];
        [att setAttributes:@{NSForegroundColorAttributeName:KCarSeriouslyMainColor} range:range];
        self.contentLabel.attributedText = att;
    }else {
        self.contentLabel.text = dataItem.contentStr;
    }
    //是否显示暂无数据的提示label
    self.tipLabel.hidden = dataItem.hasIsData;
}

/**
 设置保险记录的textfield
 */
- (void)setCarNumView {
    [self.contentView addSubview:self.numView];
    [self.numView addSubview:self.numIconBtn];
    [self.numView addSubview:self.numTextField];
    
    [self.numIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numView).offset(20);
        make.top.equalTo(self.numView).offset(10);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(self.numIconBtn.width);
    }];
    
    [self.numTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numIconBtn.mas_right).offset(5);
        make.right.equalTo(self.numView).offset(-10);
        make.top.equalTo(self.numView).offset(10);
        make.height.mas_equalTo(40);
    }];
    [self.baseView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    [self.numView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_bottom);
        make.left.equalTo(self.contentView).offset(10);
        make.bottom.right.equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(60);
    }];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        [self setAllView];
        
    }
    return self;
}
//添加控件，设置约束
- (void)setAllView {
    [self.contentView addSubview:self.baseView];
    
    [self.baseView addSubview:self.rightImageView];
    [self.baseView addSubview:self.leftImageView];
    [self.baseView addSubview:self.titleLabel];
    [self.baseView addSubview:self.priceLabel];
    [self.baseView addSubview:self.contentLabel];
    [self.baseView addSubview:self.tipLabel];
    
    //白色底部view的约束
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).mas_offset(UIEdgeInsetsMake(0, 10, 10, 10));
    }];
    //右边图片的约束（上-30，下-30，左-20，宽高-50）
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.baseView).offset(20);
        make.top.equalTo(self.baseView).offset(30);
        make.width.height.mas_equalTo(50);
        make.bottom.equalTo(self.baseView).offset(-30);
        
    }];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.centerY.equalTo(self.baseView);
        make.right.equalTo(self.baseView).offset(-10);
    }];
    
    [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.left.equalTo(self.rightImageView.mas_right).offset(20);
        make.top.equalTo(self.baseView).offset(10);
        make.right.lessThanOrEqualTo(self.priceLabel.mas_left);
    }];
   
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.top.equalTo(self.baseView).offset(10);
        make.left.equalTo(self.titleLabel.mas_right);
        make.width.mas_greaterThanOrEqualTo(21);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rightImageView.mas_right).offset(20);
        make.right.equalTo(self.leftImageView.mas_left).offset(-10);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rightImageView.mas_right).offset(20);
        make.right.equalTo(self.leftImageView.mas_left).offset(-10);
        make.top.equalTo(self.contentLabel.mas_bottom);
        make.height.mas_equalTo(21);
    }];
    
}
+ (instancetype)reportTypeCellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"selectReportTypeCellIdentifier";
    YQSelectReportTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[YQSelectReportTypeCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    tableView.separatorColor = [UIColor clearColor];
    return cell;
}

#pragma mark - lazy load
- (UIView *)baseView {
    if (_baseView == nil) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.contentView.width - 20, self.contentView.height - 10)];
        view.backgroundColor = [UIColor whiteColor];
        _baseView = view;
    }
    return _baseView;
}
- (UIImageView *)rightImageView {
    if (_rightImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 94, 88)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        _rightImageView = imageView;
    }
    return _rightImageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.rightImageView.maxX + 10, self.rightImageView.y, 120, 30)];
        label.font = [UIFont boldSystemFontOfSize:20];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)priceLabel {
    if (_priceLabel == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.maxX + 10, self.rightImageView.y, 120, 30)];
        label.font = [UIFont boldSystemFontOfSize:20];
        label.textColor = [UIColor orangeColor];
        _priceLabel = label;
    }
    return _priceLabel;
}

- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.rightImageView.maxX + 10, self.rightImageView.y, 120, 30)];
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLabel = label;
    }
    return _contentLabel;
}

- (UILabel *)tipLabel {
    if (_tipLabel == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.rightImageView.maxX + 10, self.contentLabel.maxY, 120, 21)];
        label.text = @"(暂无数据)";
        label.textColor = [UIColor orangeColor];
        
        _tipLabel = label;
    }
    return _tipLabel;
}

- (UIImageView *)leftImageView {
    if (_leftImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.width - 60, (self.contentView.height - 40)*0.5, 40, 40)];
        imageView.backgroundColor = [UIColor lightGrayColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        _leftImageView = imageView;
    }
    return _leftImageView;
}

- (YQRecordCarNumView *)numView {
    if (_numView == nil) {
        YQRecordCarNumView *view = [[YQRecordCarNumView alloc] initWithFrame:CGRectMake(0, self.rightImageView.maxY - 10, self.baseView.width, 60)];
        _numView = view;
    }
    return _numView;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.numTextField resignFirstResponder];
    return true;
}

- (UIButton *)numIconBtn {
    if (_numIconBtn == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20, 20, 120, 40);
        [button setImage:[UIImage imageNamed:@"number-icon"] forState:UIControlStateNormal];
        [button setTitle:@" 车牌号" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.selected = false;
        [button sizeToFit];
        _numIconBtn = button;
    }
    return _numIconBtn;
}

- (UITextField *)numTextField {
    if (_numTextField == nil) {
        UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(self.numIconBtn.maxX + 10, self.numIconBtn.y, self.width - self.numIconBtn.maxX - 20, 40)];
        textfield.placeholder = @"请输入车牌号码（必填）";
        textfield.borderStyle = UITextBorderStyleNone;
        textfield.returnKeyType = UIReturnKeyGo;
        textfield.delegate = self;
        _numTextField = textfield;
    }
    return _numTextField;
}

@end
