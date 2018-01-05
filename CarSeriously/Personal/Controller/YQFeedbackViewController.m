//
//  YQFeedbackViewController.m
//  CarSeriously
//
//  Created by apple on 2017/12/25.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQFeedbackViewController.h"

@interface YQFeedbackViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UILabel *placeholderLabel;
@property (nonatomic, strong)UITextView *contentTextView;
@property (nonatomic, strong)UIButton *submitBtn;
@end

@implementation YQFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"意见反馈";
    
    self.view.backgroundColor = COLOR_RGB(230, 230, 230);
    
    [self.view addSubview:self.contentTextView];
    [self.view addSubview:self.placeholderLabel];
    [self.view addSubview:self.submitBtn];
    
    [self makeConstraint];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.contentTextView resignFirstResponder];
}
- (void)submitBtnClick:(UIButton *)button {
    
    [self.contentTextView resignFirstResponder];
}
#pragma mark - textView delegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.placeholderLabel.hidden = true;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (KStrIsEmpty(textView.text)) {
        self.placeholderLabel.hidden = false;
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]){
        [self.contentTextView resignFirstResponder];
        
        return false;
    }
    return true;
}
#pragma mark - lazy load
- (UITextView *)contentTextView {
    if (_contentTextView == nil) {
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, SCRW - 20, 200)];
        textView.returnKeyType = UIReturnKeyDone;
        textView.delegate = self;
        textView.backgroundColor = [UIColor whiteColor];
        _contentTextView = textView;
    }
    return _contentTextView;
}
- (UILabel *)placeholderLabel {
    if (_placeholderLabel == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, SCRW - 30, 20)];
        label.text = @"请填写您的意见...";
        label.textColor = [UIColor lightGrayColor];
        _placeholderLabel = label;
    }
    return _placeholderLabel;
}
- (UIButton *)submitBtn {
    if (_submitBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10, self.contentTextView.maxY + 20, SCRW - 20, 45);
        [btn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = KCarSeriouslyMainColor;
        [btn setTitle:@"提交反馈" forState:UIControlStateNormal];
        btn.layer.cornerRadius = 10;
        _submitBtn = btn;
    }
    return _submitBtn;
}

#pragma mark - 添加控件的约束
- (void)makeConstraint {
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.yq_safeAreaLayoutGuideTop).offset(10);
        make.left.equalTo(self.view.yq_safeAreaLayoutGuideLeft).offset(10);
        make.right.equalTo(self.view.yq_safeAreaLayoutGuideRight).offset(-10);
        make.height.mas_equalTo(self.contentTextView.height);
    }];
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentTextView.mas_left).offset(5);
        make.right.equalTo(self.contentTextView.mas_right).offset(-5);
        make.top.equalTo(self.contentTextView.mas_top).offset(5);
        make.height.mas_equalTo(self.placeholderLabel.height);
        
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentTextView);
        make.right.equalTo(self.contentTextView);
        make.top.equalTo(self.contentTextView.mas_bottom).offset(20);
        make.height.mas_equalTo(self.submitBtn.height);
    }];
}
@end
