//
//  YQCoverView.m
//  CarSeriously
//
//  Created by apple on 2017/12/28.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQCoverView.h"

@implementation YQCoverView

+ (instancetype)coverShow {
    //如果存在就先删掉
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([view isKindOfClass:[self class]]) {
            [view removeFromSuperview];
        }
    }
    YQCoverView *view = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.3;
    
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
    return view;
}

+ (void)coverHide {
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([view isKindOfClass:[self class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self removeFromSuperview];   
}


@end
