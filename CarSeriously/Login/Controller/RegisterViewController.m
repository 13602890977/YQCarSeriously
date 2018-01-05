//
//  RegisterViewController.m
//  CarSeriously
//
//  Created by apple on 17/7/5.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "RegisterViewController.h"

#import "PasswordViewController.h"
#import "YQRegisterAgreementView.h"

@interface RegisterViewController ()

@property(nonatomic,assign)NSInteger timeOutNum;
/**获取验证码按钮*/
@property(nonatomic,strong)UIButton *codeButton;

@property(nonatomic,assign)BOOL agreeBtnIsSelect;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"注册";
    
    [self setAgreeLabelAndBtn];
    
    self.timeOutNum = 10;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"忘记密码";
    
    self.accountTextField.placeholder = @"请输入您的手机号码";
    self.accountTextField.rightView = self.codeButton;
    self.accountTextField.rightViewMode = UITextFieldViewModeAlways;
    
    self.passwordTextField.placeholder = @"请输入您的验证码";
    [self.loginButton setTitle:@"下一步" forState:UIControlStateNormal];
    
    
    
    // Do any additional setup after loading the view.
}
#pragma mark - 设置同意协议的button和label
- (void)setAgreeLabelAndBtn {
    
    YQRegisterAgreementView *agreementView = [[YQRegisterAgreementView alloc] initWithFrame:CGRectMake(0, self.loginButton.maxY + 20, self.safeAreaView.width, 30)];
    __weak typeof(self) weakSelf = self;
    [agreementView agreeBtnClick:^(BOOL isSelect) {
        weakSelf.agreeBtnIsSelect = isSelect;
        NSLog(@"%d",isSelect);
    }];
    [self.safeAreaView addSubview:agreementView];
    [self usuallyMasonryView:agreementView formView:self.loginButton rect:CGRectMake(0, self.loginButton.height + 20, 0, 30)];
    
}

- (CGSize)labelSizeWithStr:(NSString *)labelStr{
    NSDictionary *atts = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
    return [labelStr sizeWithAttributes:atts];
}


- (void)checkBtnClick:(UIButton *)button {
    
}

- (void)agreementBtnClick:(UIButton *)button {
    
}
#pragma mark 下一步按钮点击事件
- (void)buttonClick:(UIButton *)button{
    
    PasswordViewController *passwordVC = [[PasswordViewController alloc] init];
    
    [self.navigationController pushViewController:passwordVC animated:true];
    
    
}
#pragma mark - 获取验证码按钮点击事件
- (void)codeBtnClick {
    [self.codeButton setTitle:[NSString stringWithFormat:@"%ld秒后重发",self.timeOutNum] forState:UIControlStateNormal];
    self.codeButton.enabled = false;
    __weak typeof(self) weakSelf = self;
    [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:true block:^(NSTimer * _Nonnull timer) {
        
        if (weakSelf.timeOutNum <= 1) {
            weakSelf.timeOutNum = 10;
            [weakSelf.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            weakSelf.codeButton.enabled = true;
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
