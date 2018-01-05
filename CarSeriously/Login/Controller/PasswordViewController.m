//
//  PasswordViewController.m
//  CarSeriously
//
//  Created by apple on 17/7/5.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "PasswordViewController.h"
#import "YQNewPasswordViewController.h"

@interface PasswordViewController ()

@property(nonatomic,strong)UIButton *codeButton;

@property(nonatomic,assign)NSInteger timeOutNum;
@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timeOutNum = 10;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"忘记密码";
    
    self.accountTextField.placeholder = @"请输入您的手机号码";
    self.accountTextField.rightView = self.codeButton;
    self.accountTextField.rightViewMode = UITextFieldViewModeAlways;
    
    self.passwordTextField.placeholder = @"请输入您的验证码";
    [self.loginButton setTitle:@"下一步" forState:UIControlStateNormal];
    
}
- (void)buttonClick:(UIButton *)button{
    if (KStrIsEmpty(self.accountTextField.text)) {
        NSLog(@"请输入");
    }else if (KStrIsEmpty(self.passwordTextField.text)){
        NSLog(@"请输入验证码");
    }
    YQNewPasswordViewController *PwVC = [[YQNewPasswordViewController alloc] init];
    
    [self.navigationController pushViewController:PwVC animated:true];
}
- (void)codeBtnClick {
    [self.codeButton setTitle:[NSString stringWithFormat:@"%ld秒后重发",self.timeOutNum] forState:UIControlStateNormal];
    self.codeButton.enabled = false;
    __weak typeof(self) weakSelf = self;
    [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:true block:^(NSTimer * _Nonnull timer) {
        
        if (weakSelf.timeOutNum <= 1) {
            weakSelf.timeOutNum = 10;
            [weakSelf.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            weakSelf.codeButton.enabled = true;
            //关闭定时器
            [timer invalidate];
            timer = nil;
        }else {
            weakSelf.timeOutNum--;
            [weakSelf.codeButton setTitle:[NSString stringWithFormat:@"%ld秒后重发",weakSelf.timeOutNum] forState:UIControlStateNormal];
            
        }
    }];
}
- (UIButton *)codeButton{
    if (!_codeButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.frame = CGRectMake(0, 0, 80, 30);
        btn.layer.cornerRadius = 5;
        [btn setBackgroundColor:KCarSeriouslyMainColor];
        [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(codeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _codeButton = btn;
    }
    return _codeButton;
}


@end
