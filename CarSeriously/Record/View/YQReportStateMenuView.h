//
//  YQReportStateMenuView.h
//  CarSeriously
//
//  Created by apple on 2017/12/28.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YQReportMenuItem.h"

@class YQReportStateMenuView;


@protocol YQReportStateMenuViewDelegate<NSObject>
@optional
- (void)menuCellDidSelector:(YQReportStateMenuView *)menuView cellItem:(YQReportMenuItem *)cellItem;
- (void)menuTouchBegin:(YQReportStateMenuView *)menuView;
@end

@interface YQReportStateMenuView : UIView

/**
 接收菜单tableview上显示的数据
 */
@property(nonatomic,strong)NSMutableArray<YQReportMenuItem *> *menuDataArr;

@property(nonatomic,weak)id<YQReportStateMenuViewDelegate> delegate;

+ (instancetype)menuShowWithViewBottom:(UIView *)view toView:(UIView *)toView;
- (void)menuHidden;
@end
