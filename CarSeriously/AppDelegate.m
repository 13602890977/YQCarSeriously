//
//  AppDelegate.m
//  CarSeriously
//
//  Created by apple on 17/6/26.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "AppDelegate.h"

#import "MainTabBarController.h"
#import "YQNewFeaureController.h"

#define YQAppVersion @"YQCarSeriouslyAppVersion"

@interface AppDelegate ()
@property(nonatomic,assign)BOOL allowRotation;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //在进入需要全屏的界面里面发送允许横屏的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startFullScreen) name:@"startFullScreen" object:nil];//允许横屏
    
    //在退出允许横屏的界面里面发送退出横屏的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endFullScreen) name:@"endFullScreen" object:nil];//退出横屏
    self.allowRotation = true;
    //获取当前版本号
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = infoDict[@"CFBundleShortVersionString"];
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    NSUserDefaults *userDf = [NSUserDefaults standardUserDefaults];
    //获取上一次的版本号
    NSString *oldVersion = [userDf objectForKey:YQAppVersion];
    if (![currentVersion isEqualToString:oldVersion]) {//如果当前和上一次保存的版本号不一样，就进入新界面特性
        YQNewFeaureController *newFeature = [[YQNewFeaureController alloc] init];
        
        self.window.rootViewController = newFeature;
        
        //将当前版本保存
        [userDf setObject:currentVersion forKey:YQAppVersion];
        
    }else{
        MainTabBarController *tabBarC = [[MainTabBarController alloc] init];
        
        _window.rootViewController = tabBarC;
    }
    
    [_window makeKeyAndVisible];
 
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark 允许横屏
-(void)startFullScreen
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = true;
}

#pragma mark    退出横屏
-(void)endFullScreen
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = false;
    
    //强制归正：
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val =UIInterfaceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}
//调整是否允许横竖屏(必须勾选了横竖屏才有效)
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (self.allowRotation) {
        return UIInterfaceOrientationMaskAll;
    }
    return UIInterfaceOrientationMaskPortrait;
}

@end
