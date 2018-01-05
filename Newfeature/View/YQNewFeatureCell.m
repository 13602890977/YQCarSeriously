//
//  YQNewFeatureCell.m
//  CarSeriously
//
//  Created by apple on 2017/12/19.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQNewFeatureCell.h"
#import "MainTabBarController.h"

@interface YQNewFeatureCell()

@property(nonatomic,weak)UIImageView *imageView;
@property(nonatomic,weak)UIButton *nextBtn;
@end

@implementation YQNewFeatureCell

- (UIButton *)nextBtn {
    if (_nextBtn == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(SCRW * 0.25, SCRH * 0.7, SCRW*0.5, SCRH*0.2);
//        button.backgroundColor = [UIColor redColor];
        [button addTarget:self action:@selector(changeRootViewC:) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:button];
        _nextBtn = button;
    }
    return _nextBtn;
}

- (void)changeRootViewC:(UIButton *)btn {
    //切换视图控制器
    [UIApplication sharedApplication].keyWindow.rootViewController = [[MainTabBarController alloc] init];
    
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _imageView = imageView;
        [self.contentView addSubview:imageView];
    }
    return _imageView;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    
    self.imageView.image = image;
    self.imageView.frame = self.bounds;
    
}

- (void)setBtnWithIndexPath:(NSIndexPath *)indexPath count:(int)count {
    if (indexPath.item == count - 1) {
        self.nextBtn.hidden = false;
        
    }else {
        self.nextBtn.hidden = true;
    }
}

@end
