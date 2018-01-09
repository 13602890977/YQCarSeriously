//
//  YQRecordCarNumView.m
//  CarSeriously
//
//  Created by apple on 2018/1/9.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//

#import "YQRecordCarNumView.h"

@interface YQRecordCarNumView()<UITextFieldDelegate>

@property(nonatomic,strong)UIButton *numIconBtn;

@property(nonatomic,strong)UITextField *numTextField;

@end

@implementation YQRecordCarNumView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    //1.先绘制路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.width,0)];
    [path addQuadCurveToPoint:CGPointMake(self.width, 10) controlPoint:CGPointMake(self.width - 10, 5)];
    [path addLineToPoint:CGPointMake(self.width, self.height)];
    [path addLineToPoint:CGPointMake(0, self.height)];
    [path addLineToPoint:CGPointMake(0, 10)];
    [path addQuadCurveToPoint:CGPointMake(0, 0) controlPoint:CGPointMake(10, 5)];
    
//    [path stroke];
    //2.然后添加图层
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    //3.更换图层
    self.layer.mask = layer;
    //4.再添加一条虚线
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(20, 5)];
    [linePath addLineToPoint:CGPointMake(self.width - 20, 5)];
    CGFloat dashPa[] = {3,1};//3实1白,c中数组的名称就是数组的地址
    [linePath setLineDash:dashPa count:1 phase:1];
    [COLOR_RGB(230, 230, 230) set];
    [linePath stroke];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.numTextField resignFirstResponder];
    return true;
}

- (UIButton *)numIconBtn {
    if (_numIconBtn == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20, 20, 120, 40);
        [button setImage:[UIImage imageNamed:@"number-icon"] forState:UIControlStateNormal];
        [button setTitle:@"车牌号" forState:UIControlStateNormal];
        [button sizeToFit];
        _numIconBtn = button;
    }
    return _numIconBtn;
}

- (UITextField *)numTextField {
    if (_numTextField == nil) {
        UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(self.numIconBtn.maxX + 10, self.numIconBtn.y, self.width - self.numIconBtn.maxX - 20, 40)];
        textfield.placeholder = @"请输入车牌号码（必填）";
        textfield.borderStyle = UITextBorderStyleNone;
        textfield.returnKeyType = UIReturnKeyGo;
        textfield.delegate = self;
        _numTextField = textfield;
    }
    return _numTextField;
}
@end
