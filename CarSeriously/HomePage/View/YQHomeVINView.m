//
//  YQHomeVINView.m
//  CarSeriously
//
//  Created by apple on 2017/12/25.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQHomeVINView.h"

@interface YQHomeVINView()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *vinTextField;

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIButton *queryButton;

@end

@implementation YQHomeVINView


- (IBAction)whereIsVINBtnClick:(UIButton *)sender {
    NSLog(@"%s",__func__);
}
- (IBAction)nowQueryBtnClick:(UIButton *)sender {
    
    [self.vinTextField resignFirstResponder];
    
    if ([_delegate respondsToSelector:@selector(queryBtnClick:)]) {
        [self.delegate queryBtnClick:self];
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.vinTextField resignFirstResponder];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"YQHomeVINView" owner:self options:nil] firstObject];
        self.frame = frame;
        
        [self setView];
    }
    return self;
}
- (void)setView {
    self.queryButton.layer.cornerRadius = 5;
    self.queryButton.backgroundColor = KCarSeriouslyMainColor;
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraBtn.frame = CGRectMake(0, 0, 20, 17);
    [cameraBtn setImage:[UIImage imageNamed:@"camera-icon"] forState:UIControlStateNormal];
    [cameraBtn addTarget:self action:@selector(cameraBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.vinTextField.rightView = cameraBtn;
    self.vinTextField.rightViewMode = UITextFieldViewModeAlways;
    self.vinTextField.delegate = self;
    
}
- (void)cameraBtnClick {
    
}
#pragma mark - textfield delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
//    NSLog(@"%lu--%ld--%@",(unsigned long)range.length,range.location,string);
    if (range.length == 1 && string.length == 0) {
        self.tipLabel.text = [NSString stringWithFormat:@"已经输入%ld位，还差%lu位",range.location,17-range.location];
        return true;
    }
    self.tipLabel.text = [NSString stringWithFormat:@"已经输入%ld位，还差%lu位",range.location+1,16-range.location];
    return range.location < 17-1;
}
@end
