//
//  PasswordViewController.m
//  CarSeriously
//
//  Created by apple on 17/7/5.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "PasswordViewController.h"

@interface PasswordViewController ()

/**手机号码输入框*/
@property(nonatomic,strong)UITextField *passwordTextField;

/**验证码输入框*/
@property(nonatomic,strong)UITextField *passwordAgainTextField;

/**完成按钮*/
@property(nonatomic,strong)UIButton *nextButton;

@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"注册";
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 16, 16);
    [backBtn setImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(navLeftBackClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.passwordAgainTextField];
    [self.view addSubview:self.nextButton];
    
    
    // Do any additional setup after loading the view.
}


#pragma mark 导航返回键点击事件
- (void)navLeftBackClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:true];
}
#pragma mark 完成按钮点击事件
- (void)buttonClick:(UIButton *)button {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载强引用的控件
- (UITextField *)passwordTextField{
    if (_passwordTextField == nil) {
        _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 120, SCRW, 40)];
        _passwordTextField.backgroundColor = [UIColor whiteColor];
        _passwordTextField.placeholder = @"请输入密码";
        _passwordTextField.borderStyle = UITextBorderStyleBezel;
        //编辑时出现清楚按钮
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
    }
    return _passwordTextField;
}

- (UITextField *)passwordAgainTextField{
    if (_passwordAgainTextField == nil) {
        _passwordAgainTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, _passwordTextField.maxY, SCRW, 40)];
        _passwordAgainTextField.backgroundColor = [UIColor whiteColor];
        _passwordAgainTextField.placeholder = @"请输入验证码";
        _passwordAgainTextField.borderStyle = UITextBorderStyleBezel;
        //编辑时出现清楚按钮
        _passwordAgainTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
    }
    return _passwordAgainTextField;
}

- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.frame = CGRectMake(20, _passwordAgainTextField.maxY + 40 , SCRW - 40, 40);
        
        [_nextButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _nextButton.backgroundColor = KCarSeriouslyMainColor;
        [_nextButton setTitle:@"完成" forState:UIControlStateNormal];
        _nextButton.layer.cornerRadius = 10;
        
    }
    return _nextButton;
}

@end
