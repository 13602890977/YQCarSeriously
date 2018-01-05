//
//  YQReportDetailSectionHeaderView.m
//  CarSeriously
//
//  Created by apple on 2018/1/5.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//

#import "YQReportDetailSectionHeaderView.h"
#import "YQHomeHeaderLabel.h"

@interface YQReportDetailSectionHeaderView()

@property(nonatomic,strong)YQHomeHeaderLabel *titleLabel;
@property(nonatomic,strong)UIImageView *rightImageView;
@property(nonatomic,assign)NSInteger sectionIndex;
@property(nonatomic,assign)BOOL transformIs;
@end

@implementation YQReportDetailSectionHeaderView

- (void)setTransformIs:(BOOL)transformIs {
    _transformIs = transformIs;
    __weak typeof(self) weakSelf = self;
    if (_transformIs) {
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.rightImageView.transform = CGAffineTransformMakeRotation(M_PI);//旋转180度
        }];
    }else {
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.rightImageView.transform = CGAffineTransformIdentity;//旋转180度
        }];
    }
}

- (void)setDataDict:(NSMutableDictionary *)dataDict {
    _dataDict = dataDict;
    self.titleLabel.text = [dataDict objectForKey:@"title"];
    self.transformIs = [[dataDict objectForKey:@"isDown"] boolValue];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.yq_safeAreaLayoutGuideLeft);
            make.top.equalTo(self.yq_safeAreaLayoutGuideTop);
            make.bottom.equalTo(self.yq_safeAreaLayoutGuideBottom);
            make.right.equalTo(self.yq_safeAreaLayoutGuideRight);
        }];
        
        [self addSubview:self.rightImageView];
        [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.rightImageView.width);
            make.height.mas_equalTo(self.rightImageView.height);
            make.right.equalTo(self.yq_safeAreaLayoutGuideRight).offset(-10);
            make.centerY.equalTo(self);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewClick:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)headerViewClick:(UITapGestureRecognizer *)tap {
    _transformIs = !_transformIs;
    if (_block) {
        self.block(_sectionIndex, _transformIs);
    }
}

+ (instancetype)headerViewWithFrame:(CGRect)frame section:(NSInteger)section {
    YQReportDetailSectionHeaderView *view = [[self alloc] initWithFrame:frame];
    view.sectionIndex = section;
    view.backgroundColor = [UIColor whiteColor];
    view.userInteractionEnabled = true;
    return view;
}

- (UIImageView *)rightImageView {
    if (_rightImageView == nil) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down-arrow"]];
        _rightImageView = imageView;
    }
    return _rightImageView;
}
- (YQHomeHeaderLabel *)titleLabel {
    if (_titleLabel == nil) {
        
        YQHomeHeaderLabel *label = [YQHomeHeaderLabel labelHasLineWithFrame:CGRectMake(10, 0, self.width, 40) text:@"概要信息"];
        label.backgroundColor = [UIColor whiteColor];
        _titleLabel = label;
    }
    return _titleLabel;
}
@end
