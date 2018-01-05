//
//  MainTabBarController.m
//  CarSeriously
//
//  Created by apple on 17/7/4.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainTabBarItem.h"

#import "HomeViewController.h"
#import "RecordViewController.h"
#import "PersonalViewController.h"
#import "YQCarSourceViewController.h"

#import "YQNavigationController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //首页VC
    HomeViewController *homeVc = [[HomeViewController alloc] init];
   [self setTabBarChildVCWithVC:homeVc titleName:@"主页" baseImageName:@"home_normal" selectedImageName:@"home_highlight"];
    //车源VC
    YQCarSourceViewController *carSourceVC = [[YQCarSourceViewController alloc] init];
    [self setTabBarChildVCWithVC:carSourceVC titleName:@"车源" baseImageName:@"car_source_normal" selectedImageName:@"car_source_highlight"];
    
    //记录VC
    RecordViewController *recordVC = [[RecordViewController alloc] init];
    [self setTabBarChildVCWithVC:recordVC titleName:@"报告" baseImageName:@"record_normal" selectedImageName:@"record_highlight"];
    
    
    //我的VC
    PersonalViewController *personalVC = [[PersonalViewController alloc] init];
    
    [self setTabBarChildVCWithVC:personalVC titleName:@"我的" baseImageName:@"my_normal" selectedImageName:@"my_highlight"];
    
    //设置tabbar元素的颜色
    self.tabBar.tintColor = KCarSeriouslyMainColor;
    
    //取消tabbar的透明效果
//        [UITabBar appearance].translucent = NO;
}

- (void)setTabBarChildVCWithVC:(UIViewController *)viewC titleName:(NSString *)title baseImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImage{
    
//    viewC.view.backgroundColor = [UIColor whiteColor];
    viewC.title = title;
    viewC.tabBarItem.image = [UIImage imageNamed:imageName];
    
    viewC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    YQNavigationController *nav = [[YQNavigationController alloc] initWithRootViewController:viewC];
    
    [self addChildViewController:nav];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
