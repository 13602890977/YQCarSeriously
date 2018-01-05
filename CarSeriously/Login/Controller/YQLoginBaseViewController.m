//
//  YQLoginBaseViewController.m
//  CarSeriously
//
//  Created by apple on 2017/12/21.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQLoginBaseViewController.h"


@interface YQLoginBaseViewController ()<UITextFieldDelegate>


@end

@implementation YQLoginBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.safeAreaView];
   
    //self.safeAreaView添加约束
    [self masonryCreateSafe];
}

- (void)masonryCreateSafe {
    
    __weak typeof(self) weakSelf = self;
    
    [self.safeAreaView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.left.equalTo(weakSelf.view.yq_safeAreaLayoutGuideLeft);
            make.right.equalTo(weakSelf.view.yq_safeAreaLayoutGuideRight);
            make.bottom.equalTo(weakSelf.view.yq_safeAreaLayoutGuideBottom);
            make.top.equalTo(weakSelf.view.yq_safeAreaLayoutGuideTop);
        } else {
            make.left.top.right.bottom.equalTo(weakSelf.view);
        }
    }];
    [_safeAreaView addSubview:self.accountTextField];
    
    [self usuallyMasonryView:self.accountTextField formView:weakSelf.safeAreaView rect:CGRectMake(16, 40, 0, _accountTextField.height)];
    //必须先加到view上才能添加约束
    [_safeAreaView addSubview:self.passwordTextField];
    
    [self usuallyMasonryView:self.passwordTextField formView:weakSelf.accountTextField rect:CGRectMake(16, _accountTextField.height + 10, 0, _passwordTextField.height)];
    
    [_safeAreaView addSubview:self.loginButton];
    [self usuallyMasonryView:self.loginButton formView:weakSelf.passwordTextField rect:CGRectMake(20, _passwordTextField.height + 20, 0, _loginButton.height)];
    
}

- (void)usuallyMasonryView:(UIView *)view formView:(UIView *)formView rect:(CGRect)rect {
    __weak typeof(self) weakSelf = self;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        if (rect.origin.x < 0) {
            make.right.equalTo(weakSelf.safeAreaView).with.offset(rect.origin.x);
        }else{
            make.left.equalTo(weakSelf.safeAreaView).with.offset(rect.origin.x);
        }
        
        if (rect.size.width > 0) {
            make.width.mas_offset(rect.size.width);
        }else {
            make.right.equalTo(weakSelf.safeAreaView).with.offset(-rect.origin.x);
        }
        
        make.top.equalTo(formView).with.offset(rect.origin.y);
        make.height.mas_offset(rect.size.height);
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.accountTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}
- (void)buttonClick:(UIButton *)button{
    NSLog(@"子类自己实现按钮点击的事件");
}

#pragma mark - 懒加载控件
- (UIView *)safeAreaView {
    if (_safeAreaView == nil) {
        
        UIEdgeInsets inset = [self.view viewSafeInset];
        
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(inset.left, inset.top, self.view.width - inset.left - inset.right, self.view.height - inset.top - inset.bottom)];
        
        _safeAreaView = baseView;
    }
    return _safeAreaView;
}

- (YQTextField *)accountTextField{
    if (_accountTextField == nil) {
        _accountTextField = [[YQTextField alloc] initWithFrame:CGRectMake(16, 40, self.safeAreaView.width-32, 40)];
        _accountTextField.delegate = self;
        _accountTextField.placeholder = @"请输入账号";
        _accountTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about-icon"]];
        _accountTextField.returnKeyType = UIReturnKeyNext;
        
    }
    return _accountTextField;
}

- (YQTextField *)passwordTextField{
    if (_passwordTextField == nil) {
        _passwordTextField = [[YQTextField alloc] initWithFrame:CGRectMake(16, _accountTextField.maxY, self.safeAreaView.width - 32, 40)];
        _passwordTextField.delegate = self;
        _passwordTextField.placeholder = @"请输入密码";
        _passwordTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"exponent-icon"]];
        _passwordTextField.returnKeyType = UIReturnKeyDone;
    }
    return _passwordTextField;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.returnKeyType == UIReturnKeyNext) {
        [self.passwordTextField becomeFirstResponder];
    }else if (textField.returnKeyType == UIReturnKeyDone) {
        [self.passwordTextField resignFirstResponder];
    }
    return true;
}
- (UIButton *)loginButton{
    if (!_loginButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20, _passwordTextField.maxY + 40 , self.safeAreaView.width - 40, 45);
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = KCarSeriouslyMainColor;
        [btn setTitle:@"登录" forState:UIControlStateNormal];
        btn.layer.cornerRadius = 10;
        
        _loginButton = btn;
        
    }
    return _loginButton;
}


@end
