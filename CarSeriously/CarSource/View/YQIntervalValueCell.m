//
//  YQIntervalValueCell.m
//  CarSeriously
//
//  Created by apple on 2017/12/29.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQIntervalValueCell.h"

#import "YQSectionSlider.h"

@interface YQIntervalValueCell()<YQSectionSliderDelegate>
{
    NSString *_minStr;
    NSString *_maxStr;
}
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *resultLabel;

@property(nonatomic,strong)YQSectionSlider *mainSlider;
@end

@implementation YQIntervalValueCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.resultLabel];
        [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).with.offset(10);
            make.right.equalTo(self.contentView).with.offset(-10);
            make.height.mas_equalTo(30);
            make.width.greaterThanOrEqualTo(@60);
        }];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).with.offset(10);
            make.left.equalTo(self.contentView).with.offset(10);
            make.height.mas_equalTo(30);
            make.right.lessThanOrEqualTo(self.resultLabel.mas_left).offset(-10);
        }];
        
    }
    return self;
}

+ (instancetype)cellCreatWithTabelView:(UITableView *)tableView {
    static NSString *identifier = @"intervalValueCellIdentifier";
    YQIntervalValueCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark -setter
- (void)setMenuItem:(YQReportMenuItem *)menuItem {
    _menuItem = menuItem;
    
    self.titleLabel.text = menuItem.name;
    
    [self.contentView addSubview:self.mainSlider];
    _mainSlider.delegate = self;
    [self.mainSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.resultLabel.mas_bottom).offset(10);
        
    }];
}

#pragma mark - yqsectionslider delegate
- (void)didSelectorSectionMinNum:(NSString *)minNumStr {
    _minStr = minNumStr;
    [self changeResultLabel];
}
- (void)didSelectorSectionMaxNum:(NSString *)maxNumStr {
    _maxStr = maxNumStr;
    [self changeResultLabel];
}
- (void)changeResultLabel {
    if ((KStrIsEmpty(_minStr) || [_minStr isEqualToString:_menuItem.titleArr.firstObject]) && ![_maxStr isEqualToString:_menuItem.titleArr.lastObject]) {
        self.resultLabel.text = [NSString stringWithFormat:@"%@%@以下",_maxStr,_menuItem.unit];
    }else if ((KStrIsEmpty(_minStr) || [_minStr isEqualToString:_menuItem.titleArr.firstObject]) && ([_maxStr isEqualToString:_menuItem.titleArr.lastObject] || _maxStr == nil)){
        self.resultLabel.text = @"不限";
    }else if (_maxStr == nil || [_maxStr isEqualToString:_menuItem.titleArr.lastObject]) {
        self.resultLabel.text = [NSString stringWithFormat:@"%@%@以上",_minStr,_menuItem.unit];
    }else if([_maxStr isEqualToString:_minStr]){
        self.resultLabel.text = [NSString stringWithFormat:@"%@%@",_minStr,_menuItem.unit];
    }else {
        self.resultLabel.text = [NSString stringWithFormat:@"%@%@至%@%@",_minStr,_menuItem.unit,_maxStr,_menuItem.unit];
    }
}
#pragma mark - lazy load
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
        _titleLabel = label;
    }
    return _titleLabel;
}
- (UILabel *)resultLabel {
    if (_resultLabel == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
        label.text = @"不限";
        label.textColor = [UIColor orangeColor];
        _resultLabel = label;
    }
    return _resultLabel;
}
- (YQSectionSlider *)mainSlider {
    if (_mainSlider == nil) {
        YQSectionSlider *slider = [[YQSectionSlider alloc] initWithFrame:CGRectMake(0, 0, SCRW - 20, 40)];
        //划过的颜色
        slider.minimumTrackTintColor = KCarSeriouslyMainColor;
        slider.sectionTitleArr = self.menuItem.titleArr;
        
        _mainSlider = slider;
    }
    return _mainSlider;
}

@end
