//
//  YQLoginBaseViewController.h
//  CarSeriously
//
//  Created by apple on 2017/12/21.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YQTextView.h"
#import "YQTextField.h"

@interface YQLoginBaseViewController : UIViewController

/**
 替代当前视图View,用来适配iPhoneX
 */
@property(nonatomic,strong)UIView *safeAreaView;
/**账号输入框*/
@property(nonatomic,strong)YQTextField *accountTextField;

/**密码输入框*/
@property(nonatomic,strong)YQTextField *passwordTextField;

/**登录按钮*/
@property(nonatomic,strong)UIButton *loginButton;

/**
 登录按钮的点击事件

 @param button 登录按钮
 */
- (void)buttonClick:(UIButton *)button;

- (void)usuallyMasonryView:(UIView *)view formView:(UIView *)formView rect:(CGRect)rect;
@end
