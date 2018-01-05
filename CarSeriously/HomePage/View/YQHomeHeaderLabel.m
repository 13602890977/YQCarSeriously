//
//  YQHomeHeaderLabel.m
//  CarSeriously
//
//  Created by apple on 2017/12/27.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQHomeHeaderLabel.h"

@implementation YQHomeHeaderLabel


- (void)drawTextInRect:(CGRect)rect {
    //重绘文字的显示位置偏移
    [super drawTextInRect:CGRectMake(15, 0, rect.size.width - 10, rect.size.height)];
    //
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(10, (rect.size.height - 21)*0.5)];
    [path addLineToPoint:CGPointMake(10, (rect.size.height - (rect.size.height - 21)*0.5))];
    
    [KCarSeriouslyMainColor set];
    path.lineWidth = 2;
    
    [path stroke];
}

+ (instancetype)labelHasLineWithFrame:(CGRect)frame text:(NSString *)text {
    YQHomeHeaderLabel *label = [[self alloc] initWithFrame:frame];
    label.text = text;
    
    label.textColor = [UIColor blackColor];
    
    return label;
}

@end
