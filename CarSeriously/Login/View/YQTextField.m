//
//  YQTextField.m
//  CarSeriously
//
//  Created by apple on 2017/12/20.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQTextField.h"

@implementation YQTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.borderStyle = UITextBorderStyleNone;
        //编辑时出现清楚按钮
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //在底部画一条线，作为边框
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, self.height - 1)];
    [path addLineToPoint:CGPointMake(self.width, self.height - 1)];
    [[UIColor lightGrayColor] set];
    [path stroke];
}
//重写这个方法，可以设置左边图片的位置
- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect rect = [super leftViewRectForBounds:bounds];
    rect.origin.x = 4;
    
    return rect;
    
}
//改变文字距离
- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect rect = [super textRectForBounds:bounds];
    rect.origin.x = 30;
    
    return rect;
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect rect = [super editingRectForBounds:bounds];
    rect.origin.x = 30;
    
    return rect;
}

@end
