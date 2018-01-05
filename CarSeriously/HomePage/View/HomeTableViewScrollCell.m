//
//  HomeTableViewScrollCell.m
//  CarSeriously
//
//  Created by apple on 17/7/10.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//


#import "HomeTableViewScrollCell.h"

#import "YQHomeHeaderView.h"
#import "YQHomeHeaderLabel.h"

@interface HomeTableViewScrollCell ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIView *baseView;
@property(nonatomic,strong)YQHomeHeaderLabel *headerLabel;
@property (nonatomic,strong)YQHomeHeaderView *mainScrollView;
@end

@implementation HomeTableViewScrollCell

- (void)setImageArr:(NSArray *)imageArr {
    _imageArr = imageArr;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.baseView];
        [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).mas_offset(UIEdgeInsetsMake(0, 10, 10, 10));
        }];
        [self.baseView addSubview:self.headerLabel];
        [self.headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(21);
            make.left.right.equalTo(self.baseView);
            make.top.equalTo(self.baseView).offset(8);
        }];
        [self.baseView addSubview:self.mainScrollView];
        self.mainScrollView.dataArr = @[@"banner",@"feedback",@"leadpage1"];
        [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerLabel.mas_bottom).offset(8);
            make.left.right.equalTo(self.baseView);
            make.height.mas_equalTo(180);
            make.bottom.equalTo(self.baseView);
            
        }];
        
    }
    return self;
}
+ (instancetype)homeCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"homeTableViewScrollCellIdentifier";
    
    HomeTableViewScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    cell.backgroundColor = COLOR_RGB(230, 230, 230);
    return cell;
}
#pragma mark - 懒加载控件
- (UIView *)baseView {
    if (_baseView == nil) {
        _baseView = [[UIView alloc] init];
        _baseView.backgroundColor = [UIColor whiteColor];
    }
    return _baseView;
}
- (YQHomeHeaderLabel *)headerLabel {
    if (_headerLabel == nil) {
        _headerLabel = [YQHomeHeaderLabel labelHasLineWithFrame:CGRectMake(0, 8, 300, 21) text:@"已有N位客户使用车较真鉴真服务"];
    }
    return _headerLabel;
}

- (YQHomeHeaderView *)mainScrollView {
    if (_mainScrollView == nil) {
        YQHomeHeaderView *view = [[YQHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCRW, 200)];
        _mainScrollView = view;
    }
    return _mainScrollView;
    
}


@end
