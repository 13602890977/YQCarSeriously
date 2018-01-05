//
//  YQRegisterAgreementView.m
//  CarSeriously
//
//  Created by apple on 2017/12/22.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQRegisterAgreementView.h"

@interface YQRegisterAgreementView()

@property(nonatomic,strong)agreeBtnSelectBlock block;
@end

@implementation YQRegisterAgreementView

- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"%s",__func__);
        [self creatView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self creatView];
    }
    return self;
}
- (void)creatView {
    
    CGSize btnSize = [@"《车较真服务协议》" stringSizeWithFont:17];
    CGFloat agreementLabelWidth = 40;
    CGFloat checkBtnWidth = 16;
    
    
    UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkBtn.frame = CGRectMake(SCRW / 4, 7, checkBtnWidth, 16);
    [checkBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    checkBtn.selected = true;//默认选中
    [checkBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateDisabled];
    [checkBtn addTarget:self action:@selector(checkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:checkBtn];
    [checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_right).multipliedBy(0.25f);
        make.top.equalTo(self).with.offset(7);
        make.width.height.mas_offset(16);
    }];
    
    UILabel *agreelabel = [[UILabel alloc] initWithFrame:CGRectMake(checkBtn.maxX + 10, 0 , agreementLabelWidth, 30)];
    agreelabel.text = @"同意";
    
    [self addSubview:agreelabel];
    [self usuallyMasonryView:agreelabel formView:checkBtn rect:CGRectMake(10, 0, agreementLabelWidth, 30)];
    
    
    UIButton *agreementBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    agreementBtn.frame = CGRectMake(agreelabel.maxX - 20, agreelabel.y, btnSize.width, 30);
    [agreementBtn setTitle:@"《车较真服务协议》" forState:UIControlStateNormal];
    [agreementBtn setTitleColor:KCarSeriouslyMainColor forState:UIControlStateNormal];
    [agreementBtn addTarget:self action:@selector(agreementBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:agreementBtn];
    
    [self usuallyMasonryView:agreementBtn formView:agreelabel rect:CGRectMake(-20, 0, btnSize.width, 30)];
    
}
- (void)usuallyMasonryView:(UIView *)view formView:(UIView *)formView rect:(CGRect)rect {
    __weak typeof(self) weakSelf = self;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(formView.mas_right).with.offset(rect.origin.x);
        
        if (rect.size.width > 0) {
            make.width.mas_offset(rect.size.width);
        }else {
            make.right.equalTo(weakSelf).with.offset(-rect.origin.x);
        }
         make.top.equalTo(weakSelf).with.offset(rect.origin.y);
        make.height.mas_offset(rect.size.height);
    }];
}
- (void)agreeBtnClick:(agreeBtnSelectBlock)isSelect {
    self.block = isSelect;
}
- (void)checkBtnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (self.block != nil) {
        self.block(btn.selected);
    }
}
- (void)agreementBtnClick:(UIButton *)btn {
    
}
@end
