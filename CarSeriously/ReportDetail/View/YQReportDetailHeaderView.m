//
//  YQReportDetailHeaderView.m
//  CarSeriously
//
//  Created by apple on 2018/1/4.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//

#import "YQReportDetailHeaderView.h"
#import "YQHomeHeaderLabel.h"
#import "YQRightImgButton.h"
#import "YQLeftLineLabel.h"
@interface YQReportDetailHeaderView()


@property(nonatomic,strong)YQHomeHeaderLabel *titleLabel;
@property(nonatomic,strong)UIImageView *carIconImageView;
@property(nonatomic,strong)YQLeftLineLabel *carNameLabel;
@property(nonatomic,strong)UILabel *carBrandLabel;
@property(nonatomic,strong)YQLeftLineLabel *vinNumLabel;
@property(nonatomic,strong)UILabel *standardEmissionLabel;
@property(nonatomic,strong)YQLeftLineLabel *guidePriceLabel;
@property(nonatomic,strong)YQRightImgButton *moreBtn;


@end

@implementation YQReportDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addAllSubview];
    }
    return self;
}
- (void)addAllSubview {
    self.userInteractionEnabled = true;
    self.backgroundColor = COLOR_RGB(230, 230, 230);
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height-10)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self addSubview:baseView];
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
    }];
    
    [self addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.equalTo(self.yq_safeAreaLayoutGuideLeft);
        make.right.equalTo(self.yq_safeAreaLayoutGuideRight);
        make.height.mas_equalTo(60);
    }];
    
    UIImageView *titleBottomLine = [self addLineImageViewToViewBottom:self.titleLabel];
    
    [self addSubview:self.carIconImageView];
    [self.carIconImageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_carIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleBottomLine.mas_bottom).offset(10);
        make.left.equalTo(self.yq_safeAreaLayoutGuideLeft).offset(20);
        make.width.lessThanOrEqualTo(self.mas_width).multipliedBy(0.3);
        make.height.mas_equalTo(40);
    }];
    [self addSubview:self.carNameLabel];
    
    [_carNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleBottomLine.mas_bottom);
        make.left.equalTo(self.carIconImageView.mas_right).offset(20);
        make.right.greaterThanOrEqualTo(self.yq_safeAreaLayoutGuideRight);
        make.height.mas_equalTo(60);
    }];
    
    UIImageView *iconBottomLine = [self addLineImageViewToViewBottom:titleBottomLine];
    
    [self addSubview:self.carBrandLabel];
    [self addConstraintsWithView:self.carBrandLabel toView:iconBottomLine rightView:nil];
    
    [self addSubview:self.vinNumLabel];
    [self addConstraintsWithView:_vinNumLabel toView:iconBottomLine rightView:_carBrandLabel];
    UIImageView *vinBottomLine = [self addLineImageViewToViewBottom:iconBottomLine];
    
    [self addSubview:self.standardEmissionLabel];
    [self addConstraintsWithView:_standardEmissionLabel toView:vinBottomLine rightView:nil];
    
    [self addSubview:self.guidePriceLabel];
    [self addConstraintsWithView:_guidePriceLabel toView:vinBottomLine rightView:_standardEmissionLabel];
    UIImageView *priceBottomLine = [self addLineImageViewToViewBottom:vinBottomLine];
    [self addSubview:self.moreBtn];
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceBottomLine.mas_bottom);
        make.height.mas_equalTo(40);
//        make.bottom.equalTo(self.yq_safeAreaLayoutGuideBottom);
        make.left.equalTo(self.yq_safeAreaLayoutGuideLeft);
        make.right.equalTo(self.yq_safeAreaLayoutGuideRight);
    }];
    
}
- (UIImageView *)addLineImageViewToViewBottom:(UIView *)toView {
    
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 1)];
    lineImageView.backgroundColor = [UIColor grayColor];
    [self addSubview:lineImageView];
    [lineImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        if ([toView isKindOfClass:[UIImageView class]]) {
            make.top.equalTo(toView.mas_bottom).offset(61);
        }else {
            make.top.equalTo(toView.mas_bottom).offset(1);
        }
        make.left.equalTo(self.yq_safeAreaLayoutGuideLeft).offset(10);
        make.right.equalTo(self.yq_safeAreaLayoutGuideRight).offset(-10);
        make.height.mas_equalTo(1);
    }];
    return lineImageView;
}

- (void)addConstraintsWithView:(UIView *)formView toView:(UIView *)toView rightView:(UIView *)rightView {
    [formView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (rightView == nil) {
            make.left.equalTo(self.yq_safeAreaLayoutGuideLeft);
        }else {
            make.right.equalTo(self.yq_safeAreaLayoutGuideRight);
            make.left.equalTo(rightView.mas_right);
            make.width.equalTo(rightView);
        }
        make.height.mas_equalTo(60);
        make.top.equalTo(toView.mas_bottom);
    }];
    
}
- (void)moreBtnClick:(YQRightImgButton *)button {
    
}
#pragma mark - lazy load
- (YQHomeHeaderLabel *)titleLabel {
    if (_titleLabel == nil) {
        
        YQHomeHeaderLabel *label = [YQHomeHeaderLabel labelHasLineWithFrame:CGRectMake(0, 0, self.width, 50) text:@"车辆信息"];
        _titleLabel = label;
        
    }
    return _titleLabel;
}

- (UIImageView *)carIconImageView {
    if (_carIconImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.titleLabel.maxY, self.width*0.3, 60)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        imageView.image = [UIImage imageNamed:@"audi"];
        _carIconImageView = imageView;
    }
    return _carIconImageView;
}
- (YQLeftLineLabel *)carNameLabel {
    if (_carNameLabel == nil) {
        YQLeftLineLabel *label = [[YQLeftLineLabel alloc] initWithFrame:CGRectMake(self.carIconImageView.maxX, self.carIconImageView.y, self.width*0.6, 60)];
        label.font = [UIFont systemFontOfSize:18];
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.text = @"奥迪A4L 2.0T自动";
        label.numberOfLines = 0;
        _carNameLabel = label;
    }
    return _carNameLabel;
}

- (UILabel *)carBrandLabel {
    if (_carBrandLabel == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.carIconImageView.x, self.carIconImageView.maxY, self.width*0.5, 60)];
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.text = @"品牌：奥迪";
        label.numberOfLines = 0;
        _carBrandLabel = label;
    }
    return _carBrandLabel;
}

- (YQLeftLineLabel *)vinNumLabel {
    if (_vinNumLabel == nil) {
        YQLeftLineLabel *label = [[YQLeftLineLabel alloc] initWithFrame:CGRectMake(self.carBrandLabel.maxX, self.carBrandLabel.y, self.width*0.5, 60)];
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.text = @"车辆识别码（VIN）:\nLBV5S3105****0392";
        label.numberOfLines = 0;
        _vinNumLabel = label;
    }
    return _vinNumLabel;
}

- (UILabel *)standardEmissionLabel {
    if (_standardEmissionLabel == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.carBrandLabel.x, self.carBrandLabel.maxY, self.width*0.5, 60)];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.text = @"排放标准:\n国5";
        _standardEmissionLabel = label;
    }
    return _standardEmissionLabel;
}
- (YQLeftLineLabel *)guidePriceLabel {
    if (_guidePriceLabel == nil) {
        YQLeftLineLabel *label = [[YQLeftLineLabel alloc] initWithFrame:CGRectMake(self.standardEmissionLabel.maxX, self.standardEmissionLabel.y, self.width*0.5, 60)];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.text = @"厂商指导价：\n33.29万";
        _guidePriceLabel = label;
    }
    return _guidePriceLabel;
}
- (YQRightImgButton *)moreBtn {
    if (_moreBtn == nil) {
        
        YQRightImgButton *button = [YQRightImgButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, self.guidePriceLabel.maxY, self.width, 60);
        [button setTitle:@"更多" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"about-icon"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _moreBtn = button;
    }
    return _moreBtn;
}

@end
