//
//  HomeRepairViewController.m
//  CarSeriously
//
//  Created by apple on 17/7/12.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "HomeRepairViewController.h"

#import "PaymentViewController.h"

@interface HomeRepairViewController ()<UITextFieldDelegate>

/**维修保养视图的顶部视图*/
@property(nonatomic,strong)UIImageView *headerView;

/**vin码输入框*/
@property(nonatomic,strong)UITextField *VinTextField;

/**照相机按钮*/
@property(nonatomic,strong)UIButton *cameraButton;

/**vin字数提醒label*/
@property(nonatomic,strong)UILabel *vinNumLabel;

/**vin位置提示button*/
@property(nonatomic,strong)UIButton *whereButton;

/**维修查询button*/
@property(nonatomic,strong)UIButton *checkButton;


@end

@implementation HomeRepairViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = false;
    
    self.navigationController.navigationBar.barTintColor = COLOR_RGB(239, 239, 244);
    
    //在视图即将出现的时候，隐藏tabbar
    self.tabBarController.tabBar.hidden = true;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_RGB(239, 239, 244);
    
    
    
    //设置首页导航栏标题文字
    UILabel *navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 64)];
    navTitleLabel.text = @"维修保养查询";
    navTitleLabel.font = [UIFont boldSystemFontOfSize:24];
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    navTitleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = navTitleLabel;
    //返回键设置
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 16, 16);
    [backBtn setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(navLeftBackClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    [self.view addSubview:self.headerView];
    
    
    
    [self.view addSubview:self.VinTextField];
    
    UILabel *vinLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.VinTextField.y, 80, 30)];
    vinLabel.text = @"车架号";
    [self.view addSubview:vinLabel];
    
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _VinTextField.maxY, SCRW, 1)];
    lineImageView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineImageView];
    
    [self.view addSubview:self.vinNumLabel];
    [self.view addSubview:self.whereButton];
    [self.view addSubview:self.checkButton];
    
    [self setFootLabelView];
    
    // Do any additional setup after loading the view.
}
- (void)setFootLabelView {
    UILabel *thirdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCRH - 30, SCRW, 21)];
    thirdLabel.text = @"第三方数据支持";
    thirdLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:thirdLabel];
    NSArray<NSString *> *obtainArr = @[@"在4S店的维修记录",@"是否泡水车",@"是否调表车",@"是否事故车",@"车辆结构性损失情况"];
    
    CGFloat labelWidth = 0;
    for (int i = 0;i < obtainArr.count;i++) {//计算出文字长度最长的为label的统一长度
        CGSize size = [[NSString stringWithFormat:@"%d、%@",i+1,obtainArr[i]] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        if (labelWidth < size.width) {
            labelWidth = size.width;
        }
    }
    UILabel *tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, thirdLabel.y - 30*obtainArr.count - 30, SCRW - 20, 21)];
    tipsLabel.text = @"查询此报告你可以得到：";
    [self.view addSubview:tipsLabel];
    
    for (int i = 0;i < obtainArr.count;i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, thirdLabel.y - 30*(obtainArr.count - i), labelWidth, 21)];
        label.font = [UIFont systemFontOfSize:16];
        label.text = [NSString stringWithFormat:@"%d、%@",i+1,obtainArr[i]];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(label.maxX + 20, thirdLabel.y - 29*(obtainArr.count - i), 16, 16)];
        imageView.image = [UIImage imageNamed:@"success"];
        
        [self.view addSubview:label];
        [self.view addSubview:imageView];
        
        
    }
    
}

- (void)navLeftBackClick:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark - 不知道vin在哪按钮点击
- (void)whereBtnClick {
    [_VinTextField resignFirstResponder];
}
#pragma mark - 查询按钮点击 
- (void)checkBtnClick {
    [_VinTextField resignFirstResponder];
    
    PaymentViewController *paymentVC = [[PaymentViewController alloc] init];
    
    [self.navigationController pushViewController:paymentVC animated:true];
}
#pragma mark - 相机点击 
- (void)cameraBtnClick {
    [_VinTextField resignFirstResponder];
}
#pragma mark - textfield delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"] invertedSet];//invertedSet 方法是去反字符,把所有的除了字母数字的字符都找出来
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];//把输入框输入的字符string 根据cs中字符一个一个去除cs字符并分割成单字符并转化为 NSArray, 然后componentsJoinedByString 是把NSArray 的字符通过 ""无间隔连接成一个NSString字符 赋给filtered.就是只剩字母和数字
    if ([string isEqualToString:@"\n"]) {//查询点击键可以
        return true;
    }
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest) {
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请输入字母或数字" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        return false;
    }
    
    NSString *textfieldText = [textField.text stringByReplacingCharactersInRange:range withString:string];//得到输入框的内容
    
    if (textfieldText.length > 17) {
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"只能输入17位" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        return false;
    }
    
    self.vinNumLabel.text = [NSString stringWithFormat:@"已输入%lu位,还差%lu位",textfieldText.length,17 - textfieldText.length];
    return true;
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField.text uppercaseString];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_VinTextField resignFirstResponder];
}

#pragma mark - 懒加载

- (UIImageView *)headerView {
    if (!_headerView) {
        _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCRW, 200)];
        _headerView.backgroundColor = [UIColor blueColor];
        
    }
    return _headerView;
}

- (UITextField *)VinTextField {
    if (!_VinTextField) {
        
        _VinTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, _headerView.maxY + 10, SCRW - 90, 30)];
        _VinTextField.keyboardType = UIKeyboardTypeDefault;
        _VinTextField.placeholder = @"请输入车架号";
        _VinTextField.textAlignment = NSTextAlignmentRight;
        _VinTextField.delegate = self;
//        //没有任何输入时return不可点击
//        _VinTextField.enablesReturnKeyAutomatically = true;
        
        _VinTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//        //退出编辑再次进入编辑清空上次的编辑内容
//        _VinTextField.clearsOnBeginEditing = true;
        //textfield的文本超过屏幕宽度时，自动缩小字体大小来适应一行显示所有内容
        _VinTextField.adjustsFontSizeToFitWidth = true;
        //缩小的最小字体大小
        _VinTextField.minimumFontSize = 14;
        
        _VinTextField.returnKeyType = UIReturnKeySearch;
        
        _VinTextField.rightView = self.cameraButton;
        [_VinTextField setRightViewMode:UITextFieldViewModeAlways];
        
    }
    return _VinTextField;
}

- (UIButton *)cameraButton {
    if (!_cameraButton) {
        _cameraButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _cameraButton.frame = CGRectMake(SCRW - 32, 0, 32, 32);
        [_cameraButton setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
        [_cameraButton addTarget:self action:@selector(cameraBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraButton;
}

- (UILabel *)vinNumLabel {
    if (!_vinNumLabel) {
        _vinNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, _VinTextField.maxY + 5, SCRW/2, 21)];
        _vinNumLabel.text = @"已输入0位,还差17位";
        
    }
    return _vinNumLabel;
}

- (UIButton *)whereButton {
    if (!_whereButton) {
        _whereButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _whereButton.frame = CGRectMake(SCRW/2, _VinTextField.maxY + 5, SCRW/2, 21);
        [_whereButton setTitle:@"不知道VIN在哪？" forState:UIControlStateNormal];
        [_whereButton addTarget:self action:@selector(whereBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _whereButton;
}

- (UIButton *)checkButton {
    if (!_checkButton) {
        _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkButton.frame = CGRectMake(10, _vinNumLabel.maxY + 20, SCRW - 20, 40);
        [_checkButton setTitle:@"8.88元立即查询" forState:UIControlStateNormal];
        _checkButton.titleLabel.font = [UIFont systemFontOfSize:20];
        _checkButton.backgroundColor = KCarSeriouslyMainColor;
        _checkButton.layer.cornerRadius = 10;
        
        [_checkButton addTarget:self action:@selector(checkBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkButton;
}
#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
