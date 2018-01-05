//
//  RecordViewController.m
//  CarSeriously
//
//  Created by apple on 17/7/4.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "RecordViewController.h"

#import "RepairViewController.h"
#import "InsuranceTableViewController.h"
#import "TransferTableViewController.h"


#define RecordTag 555

@interface RecordViewController ()<UIScrollViewDelegate>
{
    NSInteger currentIndex;
}

@property(nonatomic,strong)UIScrollView *titleScrollView;
@property(nonatomic,strong)UIScrollView *currentVCScrollView;
/**用于保存记录类型按钮*/
@property(nonatomic,strong)UIButton *repairBtn;

/**按钮下面的横线view*/
@property(nonatomic,strong)UIImageView *btnBelowView;

/**存储按钮的title*/
@property(nonatomic,strong)NSArray<NSString *> *btnTitleArr;

@property(nonatomic,strong) NSArray<UIViewController *> * vcArr;

@end

@implementation RecordViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    [self.view addSubview:self.titleScrollView];
    [self.titleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.yq_safeAreaLayoutGuideLeft);
        make.right.equalTo(self.view.yq_safeAreaLayoutGuideRight);
        make.top.equalTo(self.view.yq_safeAreaLayoutGuideTop);
        make.height.mas_equalTo(40);
    }];
    [self.view addSubview:self.currentVCScrollView];
    [self.currentVCScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.yq_safeAreaLayoutGuideLeft);
        make.right.equalTo(self.view.yq_safeAreaLayoutGuideRight);
        make.top.equalTo(self.titleScrollView.mas_bottom);
        make.bottom.equalTo(self.view.yq_safeAreaLayoutGuideBottom);
    }];
    [self loadVC];
    [self setTitleBtnAndLine];
   
}
- (void)loadVC {
    /**维修页面VC*/
    RepairViewController *repairVC = [[RepairViewController alloc] initWithStyle:UITableViewStylePlain];
    /**出险页面VC*/
    InsuranceTableViewController *insuranceVC = [[InsuranceTableViewController alloc] initWithStyle:UITableViewStylePlain];
    /**过户页面VC*/
    TransferTableViewController *transferVC = [[TransferTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
//    self.vcArr = @[repairVC,insuranceVC,transferVC];
    
    //先添加子控制器
    [self addChildViewController:repairVC];
    [self addChildViewController:insuranceVC];
    [self addChildViewController:transferVC];
    
    UIView *nextView = nil;
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        vc.view.frame = CGRectMake(i*self.currentVCScrollView.width, 0, self.currentVCScrollView.width, self.currentVCScrollView.height);
        
        [self.currentVCScrollView addSubview:vc.view];
        [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (nextView) {
                make.left.equalTo(nextView.mas_right);
            }else {
                make.left.equalTo(self.currentVCScrollView);
            }
            make.top.bottom.equalTo(self.currentVCScrollView);
            make.width.mas_equalTo(self.currentVCScrollView.mas_width);
            make.height.mas_equalTo(self.currentVCScrollView.mas_height);
        }];
        nextView = vc.view;
    }
    [nextView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.currentVCScrollView);
    }];
}
- (void)setTitleBtnAndLine {
    UIButton *nextBtn = nil;
    //设置类型按钮和下划线
    for (int i = 0; i < self.btnTitleArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame = CGRectMake(SCRW/self.btnTitleArr.count*i, 0, SCRW/self.btnTitleArr.count, 40);
        
        btn.tag = i + RecordTag;
        [btn setTitle:self.btnTitleArr[i] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:KCarSeriouslyMainColor forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(recordTypeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.titleScrollView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (nextBtn) {
                make.left.equalTo(nextBtn.mas_right);
            }else {
                make.left.equalTo(self.titleScrollView);
            }
            make.height.mas_equalTo(40);
            make.top.equalTo(self.titleScrollView);
            make.width.equalTo(self.titleScrollView.mas_width).multipliedBy(1/3.0);
            make.bottom.equalTo(self.titleScrollView);
        }];
        if (i == 0) {
            self.repairBtn = btn;
            self.repairBtn.selected = true;
        }
        nextBtn = btn;
    }
    [nextBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleScrollView);
    }];
    
    [self.titleScrollView addSubview:self.btnBelowView];
    CGFloat leftX = (self.repairBtn.width + self.repairBtn.x)*0.25;
    [self.btnBelowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.repairBtn.mas_width).multipliedBy(0.5);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.repairBtn.mas_bottom).offset(-1);
        make.left.equalTo(self.titleScrollView).mas_equalTo(leftX);
    }];
}
#pragma mark - 不同类型的记录按钮点击事件
- (void)recordTypeBtnClick:(UIButton *)button {
    //按钮的tag
    NSInteger tag = button.tag - RecordTag;
    CGFloat offset = tag * self.currentVCScrollView.width;
    [self.currentVCScrollView setContentOffset:CGPointMake(offset, 0) animated:true];
}

#pragma mark scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger tag = RecordTag + (int)(offsetX/self.currentVCScrollView.width + 0.5);
    UIButton *btn = [self.titleScrollView viewWithTag:tag];
    [self changeBtnSelector:btn];
    
}
- (void)changeBtnSelector:(UIButton *)button {
    //更改按钮状态
    self.repairBtn.selected = false;
    button.selected = true;
    self.repairBtn = button;
    //按钮的tag
    NSInteger tag = button.tag - RecordTag;
    
    __weak typeof(self) weakSelf = self;
    CGFloat x = weakSelf.repairBtn.width * (tag+1) - weakSelf.btnBelowView.width*1.5 ;
   
    [weakSelf.btnBelowView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleScrollView).mas_equalTo(x);
    }];
//        [weakSelf.btnBelowView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.width.equalTo(weakSelf.repairBtn.mas_width).multipliedBy(0.5);
//            make.height.mas_equalTo(1);
//            make.top.equalTo(weakSelf.repairBtn.mas_bottom).offset(-1);
//            make.centerX.equalTo(weakSelf.repairBtn.mas_centerX);
//        }];
    
}
#pragma mark - 懒加载控件

- (UIScrollView *)titleScrollView {
    if (_titleScrollView == nil) {
        UIScrollView *scr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCRW, 40)];
        scr.scrollEnabled = false;
        _titleScrollView = scr;
    }
    return _titleScrollView;
}
- (UIScrollView *)currentVCScrollView {
    if (_currentVCScrollView == nil) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleScrollView.maxY, SCRW, SCRH-self.titleScrollView.maxY)];
        scrollView.delegate = self;
        scrollView.pagingEnabled = true;
        scrollView.showsHorizontalScrollIndicator = false;
        _currentVCScrollView = scrollView;
    }
    return _currentVCScrollView;
}

- (NSArray *)btnTitleArr {
    if (_btnTitleArr == nil) {
        _btnTitleArr = @[@"维修",@"出险",@"过户"];
    }
    return _btnTitleArr;
}

- (UIImageView *)btnBelowView{
    if (!_btnBelowView) {
        _btnBelowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, SCRW/3, 1)];
        _btnBelowView.backgroundColor = KCarSeriouslyMainColor;
    }
    return _btnBelowView;
}


@end
