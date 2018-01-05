//
//  YQHomeLoanViewController.m
//  CarSeriously
//
//  Created by apple on 2018/1/3.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//

#import "YQHomeLoanViewController.h"
#import "YQCGImage.h"

@interface YQHomeLoanViewController ()

@end

@implementation YQHomeLoanViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIImage *image = [YQCGImage getImageWithWhiteColor];
    UIView *barBackground = self.navigationController.navigationBar.subviews.firstObject;
    if (@available(iOS 11.0,*)) {
        [barBackground setValue:@0 forKey:@"alpha"];
    }else {
        barBackground.alpha = 0;
    }
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UIView *barBackground = self.navigationController.navigationBar.subviews.firstObject;
    if (@available(iOS 11.0,*)) {
        [barBackground setValue:@1 forKey:@"alpha"];
    }else {
        barBackground.alpha = 1;
    }
    [self.navigationController.navigationBar setBackgroundImage:[YQCGImage getImageWithCarMainColor] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我要贷款";
    
    [self setBaseView];
}
- (void)setBaseView {
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgImageView.image = [UIImage imageNamed:@"loan-bg"];
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view.yq_safeAreaLayoutGuideLeft);
        make.right.equalTo(self.view.yq_safeAreaLayoutGuideRight);
        make.bottom.equalTo(self.view);
    }];
    
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, bgImageView.width - 40, 200)];
    titleImageView.image = [UIImage imageNamed:@"loanHeaderTitle-bg"];
    [bgImageView addSubview:titleImageView];
    [titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageView.mas_left).offset(20);
        make.right.equalTo(bgImageView.mas_right).offset(-20);
        make.top.equalTo(bgImageView.mas_top).offset(84);
        make.height.equalTo(bgImageView.mas_height).multipliedBy(0.28);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"马上贷款" forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.showsTouchWhenHighlighted = true;
    [button addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:KCarSeriouslyMainColor];
    button.frame = CGRectMake(20, bgImageView.height - 140, bgImageView.width - 40,50);
    [bgImageView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageView.mas_left).offset(20);
        make.right.equalTo(bgImageView.mas_right).offset(-20);
        make.bottom.equalTo(bgImageView.mas_bottom).offset(-90);
        make.height.mas_equalTo(50);
    }];
}

- (void)nextButtonClick:(UIButton *)button {
    NSLog(@"敬请期待");
}

@end
