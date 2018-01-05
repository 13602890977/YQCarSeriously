//
//  YQRightImgButton.m
//  CarSeriously
//
//  Created by apple on 2017/12/28.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQRightImgButton.h"

@implementation YQRightImgButton

//重新控件布局方法
- (void)layoutSubviews {
    //先调用父类方法，完成原始布局
    [super layoutSubviews];
    //修改title和image的位置
    if (self.titleLabel.x > self.imageView.x) {
        self.titleLabel.x = self.imageView.x;
        self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 10;
    }
}


//- (void)setImage:(nullable UIImage *)image forState:(UIControlState)state
//{
//    [super setImage:image forState:state];
//    //修改完图片后，重新计算尺寸
//    [self sizeToFit];
//
//}

@end
