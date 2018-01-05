//
//  YQNavigationController.m
//  CarSeriously
//
//  Created by apple on 2017/12/19.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQNavigationController.h"
#import "YQCGImage.h"

@interface YQNavigationController ()<UINavigationControllerDelegate>

//用于保存手势代理
@property(nonatomic,strong)id popDelegate;

@end

@implementation YQNavigationController

+ (void)load {
    UINavigationBar *navBar = nil;
    if (@available(iOS 9.0,*)) {
        navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    }else {
        navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    }
    
    [navBar setBackgroundImage:[YQCGImage getImageWithCarMainColor] forBarMetrics:UIBarMetricsDefault];
    
    //设置导航栏字体大小
    
    NSMutableDictionary<NSAttributedStringKey,id> *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navBar setTitleTextAttributes:dict];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //为了重写代理方法
    self.delegate = self;
    
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    
    self.interactivePopGestureRecognizer.delegate = nil;
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [super pushViewController:viewController animated:animated];
    
    if (self.childViewControllers.count > 1) {
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"arrow-icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:0 target:self action:@selector(backBarBtnClick:)];
    }
}

- (void)backBarBtnClick:(UIBarButtonItem *)barBtn {
    
    [self popViewControllerAnimated:true];
}

#pragma mark - nav delegate
//当完成显示时调用
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (viewController == self.childViewControllers[0]) {//如果是根控制器
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
        
    }else {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    
}
@end
