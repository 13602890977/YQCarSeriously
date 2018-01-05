//
//  LoginViewController.m
//  CarSeriously
//
//  Created by apple on 17/7/4.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "LoginViewController.h"

#import "RegisterViewController.h"
#import "PasswordViewController.h"

@interface LoginViewController ()

/**立即注册按钮*/
@property(nonatomic,strong)UIButton *registerButton;

/**忘记密码按钮*/
@property(nonatomic,strong)UIButton *forgetButton;


@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"登录";
    
    [self setAgreementLabel];
    
    [self.safeAreaView addSubview:self.registerButton];
    /*(15, _loginButton.maxY + 60, 80, 40)*/
    [self usuallyMasonryView:self.registerButton formView:self.loginButton rect:CGRectMake(15, self.loginButton.height + 60, _registerButton.width, _registerButton.height)];
    [self.safeAreaView addSubview:self.forgetButton];
    [self usuallyMasonryView:self.forgetButton formView:self.loginButton rect:CGRectMake(-15, self.loginButton.height + 60, _forgetButton.width, _forgetButton.height)];
    
}
- (void)setAgreementLabel {
    CGSize labelSize = [self labelSizeWithStr:@"点击登录，即表示你同意"];
    
    UILabel *agreementLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.loginButton.x, self.loginButton.maxY + 10, labelSize.width + 5, 30)];
    agreementLabel.text = @"点击登录，即表示你同意";
    [self.safeAreaView addSubview:agreementLabel];
    [self usuallyMasonryView:agreementLabel formView:self.loginButton rect:CGRectMake(self.loginButton.x, self.loginButton.height + 10, agreementLabel.width, agreementLabel.height)];
    
    //设置服务协议Button
    CGSize btnSize = [@"《车较真服务协议》" stringSizeWithFont:17];
    UIButton *agreementBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    agreementBtn.frame = CGRectMake(agreementLabel.maxX, agreementLabel.y, btnSize.width, agreementBtn.height);
    [agreementBtn setTitle:@"《车较真服务协议》" forState:UIControlStateNormal];
    [agreementBtn setTitleColor:KCarSeriouslyMainColor forState:UIControlStateNormal];
    [agreementBtn addTarget:self action:@selector(agreementBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.safeAreaView addSubview:agreementBtn];
    [self usuallyMasonryView:agreementBtn formView:self.loginButton rect:CGRectMake(agreementLabel.maxX, self.loginButton.height + 10, agreementBtn.width, 30)];
}


- (CGSize)labelSizeWithStr:(NSString *)labelStr{
    NSDictionary *atts = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
    return [labelStr sizeWithAttributes:atts];
}

- (void)agreementBtnClick:(UIButton *)button {
    
    
}

- (void)buttonClick:(UIButton *)button{
    
    if ([self.accountTextField.text isEqualToString:@""] || self.accountTextField.text == nil) {
        NSLog(@"请输入账号");
    }else if ([self.passwordTextField.text isEqualToString:@""] || self.passwordTextField.text == nil) {
        NSLog(@"请输入密码");
    }else{
        [button setTitle:@"登录中..." forState:UIControlStateNormal];
        [self.loginButton setImage:[UIImage imageNamed:@"loading"] forState:UIControlStateNormal];
        [self timeChange];
        
        __weak typeof(self) weakSelf = self;
        NSDictionary *dict = @{};
        [[YQSessionTool shareTool] postLoginWithUrl:@"api/v1/login" parameters:dict resultBlock:^(NSDictionary *dictData, NSString *msg) {
            
        }];
        
        [self.navigationController popViewControllerAnimated:true];
    }
}
- (void)changeLoginBtn {
    self.loginButton.enabled = !self.loginButton.enabled;
    [self.loginButton setImage:nil forState:UIControlStateNormal];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton.imageView.layer removeAllAnimations];
}
- (void)timeChange {

    self.loginButton.enabled = !self.loginButton.enabled;
    CABasicAnimation *basisA = [CABasicAnimation animation];
    basisA.keyPath = @"transform.rotation";
    basisA.toValue = @(M_PI*2);
    basisA.duration = 1.5;
    basisA.repeatCount = MAXFLOAT;
    
    [self.loginButton.imageView.layer addAnimation:basisA forKey:nil];
    
    
}
- (void)registerBtnClick {
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:true];
}
- (void)forgetBtnClick {
    
    PasswordViewController *passVC = [[PasswordViewController alloc] init];
    
    [self.navigationController pushViewController:passVC animated:true];
}

#pragma mark - 懒加载控件
- (UIButton *)registerButton{
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _registerButton.frame = CGRectMake(15, self.loginButton.maxY + 60, 80, 40);
        [_registerButton setTitle:@"立即注册" forState:UIControlStateNormal];
        
        [_registerButton setTitleColor:KCarSeriouslyMainColor forState:UIControlStateNormal];
        
        [_registerButton addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}


- (UIButton *)forgetButton{
    if (!_forgetButton) {
        _forgetButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _forgetButton.frame = CGRectMake(self.safeAreaView.width - 15 - 80, self.loginButton.maxY + 60, 80, 40);
        [_forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [_forgetButton setTitleColor:KCarSeriouslyMainColor forState:UIControlStateHighlighted];
        
        [_forgetButton addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetButton;
}
#pragma mark - 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
