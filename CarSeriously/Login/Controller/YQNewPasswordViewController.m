//
//  YQNewPasswordViewController.m
//  CarSeriously
//
//  Created by apple on 2017/12/21.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQNewPasswordViewController.h"

@interface YQNewPasswordViewController ()

@end

@implementation YQNewPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"设置新密码";
    
    self.accountTextField.placeholder = @"请输入您的新密码";
    self.passwordTextField.placeholder = @"请再次输入您的新密码";
    [self.loginButton setTitle:@"完成" forState:UIControlStateNormal];
    
}



@end
