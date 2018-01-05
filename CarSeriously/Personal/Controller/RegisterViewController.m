//
//  RegisterViewController.m
//  CarSeriously
//
//  Created by apple on 17/7/5.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "RegisterViewController.h"

#import "PasswordViewController.h"

@interface RegisterViewController ()

/**手机号码输入框*/
@property(nonatomic,strong)UITextField *phoneTextField;

/**验证码输入框*/
@property(nonatomic,strong)UITextField *codeTextField;

/**获取验证码按钮*/
@property(nonatomic,strong)UIButton *codeButton;

/**下一步按钮*/
@property(nonatomic,strong)UIButton *nextButton;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"注册";
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 16, 16);
    [backBtn setImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(navLeftBackClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.codeTextField];
    [self.view addSubview:self.codeButton];
    
    [self.view addSubview:self.nextButton];
    
    [self setAgreeLabelAndBtn];
    
    
    
    // Do any additional setup after loading the view.
}
#pragma mark - 设置同意协议的button和label
- (void)setAgreeLabelAndBtn {
    
    UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkBtn.frame = CGRectMake(SCRW / 4, _nextButton.maxY + 27, 16, 16);
    [checkBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    [checkBtn addTarget:self action:@selector(checkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkBtn];
    
    UILabel *agreelabel = [[UILabel alloc] initWithFrame:CGRectMake(checkBtn.maxX + 10, _nextButton.maxY + 20 , 40, 30)];
    agreelabel.text = @"同意";
    
    [self.view addSubview:agreelabel];
    
    CGSize btnSize = [self labelSizeWithStr:@"《车较真服务协议》"];
    UIButton *agreementBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    agreementBtn.frame = CGRectMake(agreelabel.maxX - 20, agreelabel.y, btnSize.width, 30);
    [agreementBtn setTitle:@"《车较真服务协议》" forState:UIControlStateNormal];
    [agreementBtn setTitleColor:KCarSeriouslyMainColor forState:UIControlStateNormal];
    [agreementBtn addTarget:self action:@selector(agreementBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:agreementBtn];
    
}

- (CGSize)labelSizeWithStr:(NSString *)labelStr{
    NSDictionary *atts = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
    return [labelStr sizeWithAttributes:atts];
}


- (void)checkBtnClick:(UIButton *)button {
    
}

- (void)agreementBtnClick:(UIButton *)button {
    
}

#pragma mark - 获取验证码按钮点击事件
- (void)codeBtnClick{
    
}

#pragma mark 下一步按钮点击事件
- (void)buttonClick:(UIButton *)button{
    if (button == _nextButton) {
        PasswordViewController *passwordVC = [[PasswordViewController alloc] init];
        
        [self.navigationController pushViewController:passwordVC animated:true];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 导航返回键点击事件
- (void)navLeftBackClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark - 懒加载强引用的控件
- (UITextField *)phoneTextField{
    if (_phoneTextField == nil) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 120, SCRW, 40)];
        _phoneTextField.backgroundColor = [UIColor whiteColor];
        _phoneTextField.placeholder = @"请输入手机号码";
        _phoneTextField.borderStyle = UITextBorderStyleBezel;
        //编辑时出现清楚按钮
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
    }
    return _phoneTextField;
}

- (UITextField *)codeTextField{
    if (_codeTextField == nil) {
        _codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, _phoneTextField.maxY, SCRW, 40)];
        _codeTextField.backgroundColor = [UIColor whiteColor];
        _codeTextField.placeholder = @"请输入验证码";
        _codeTextField.borderStyle = UITextBorderStyleBezel;
        //编辑时出现清楚按钮
        _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
    }
    return _codeTextField;
}

- (UIButton *)codeButton{
    if (!_codeButton) {
        _codeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _codeButton.frame = CGRectMake(SCRW - 80, _phoneTextField.y, 80, 40);
        
        [_codeButton setBackgroundColor:KCarSeriouslyMainColor];
        [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_codeButton addTarget:self action:@selector(codeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _codeButton;
}

- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.frame = CGRectMake(20, _codeTextField.maxY + 40 , SCRW - 40, 40);
        
        [_nextButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _nextButton.backgroundColor = KCarSeriouslyMainColor;
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        _nextButton.layer.cornerRadius = 10;
        
    }
    return _nextButton;
}

@end
