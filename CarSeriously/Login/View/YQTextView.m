//
//  YQTextView.m
//  CarSeriously
//
//  Created by apple on 2017/12/20.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQTextView.h"

@interface YQTextView()

@property(nonatomic,strong)UIImageView *leftImageView;

@property(nonatomic,strong)UIImageView *bottomLine;

@end

@implementation YQTextView

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, self.height - 1)];
    [path addLineToPoint:CGPointMake(self.width, self.height - 1)];
    [[UIColor lightGrayColor] set];
    
    [path stroke];
}

- (void)setLeftImage:(UIImage *)leftImage {
    _leftImage = leftImage;
    
    self.leftImageView.image = leftImage;
}
+ (instancetype)textViewWithRect:(CGRect )rect{
    
    YQTextView *view = [[self alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor whiteColor];
    
    [view setNeedsDisplay];
    return view;
}

- (UIImageView *)leftImageView {
    if (_leftImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, self.height)];
        imageView.contentMode = UIViewContentModeLeft;
        imageView.clipsToBounds = true;
        _leftImageView = imageView;
        
        [self addSubview:imageView];
    }
    return _leftImageView;
}

- (UITextField *)mainTextField {
    if (_mainTextField == nil) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(24, 0, self.width - 44, self.height)];
        
        textField.borderStyle = UITextBorderStyleNone;
        [self addSubview:textField];
        _mainTextField = textField;
    }
    return _mainTextField;
}
@end
