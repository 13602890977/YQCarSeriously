//
//  YQReportStateMenuView.m
//  CarSeriously
//
//  Created by apple on 2017/12/28.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQReportStateMenuView.h"

@interface YQReportStateMenuView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *menuTableView;

@end

@implementation YQReportStateMenuView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
- (void)setMenuDataArr:(NSMutableArray<YQReportMenuItem *> *)menuDataArr {
    _menuDataArr = menuDataArr;
    [self addSubview:self.menuTableView];
    [self.menuTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(44*menuDataArr.count);
    }];
    
    
}
+ (instancetype)menuShowWithViewBottom:(UIView *)view toView:(UIView *)toView {
    
    for (UIView *currentView in toView.subviews) {
        if ([currentView isKindOfClass:[self class]] || [currentView isKindOfClass:[YQReportStateMenuView class]]) {
            [currentView removeFromSuperview];
        }
    }
    YQReportStateMenuView *menuView = [[self alloc] initWithFrame:CGRectMake(0, view.maxY, SCRW, toView.height)];
    //这样设置透明度才不会影响他上面的其他控件
    menuView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    menuView.userInteractionEnabled = true;
    [toView addSubview:menuView];
    [menuView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.top.mas_equalTo(view.mas_bottom);
        make.left.equalTo(toView);
        make.width.mas_equalTo(toView.mas_width);
        make.height.mas_equalTo(toView.mas_height);
    }];
    
    
    return menuView;
}
- (void)menuHidden {
    //发送通知到APPdelegate中，告诉管理者，可以开始横屏了
    [[NSNotificationCenter defaultCenter] postNotificationName:@"startFullScreen" object:nil];
    
    [self removeFromSuperview];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([_delegate respondsToSelector:@selector(menuTouchBegin:)]) {
        [self.delegate menuTouchBegin:self];
    }
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegate respondsToSelector:@selector(menuCellDidSelector:cellItem:)]) {
        YQReportMenuItem *item = self.menuDataArr[indexPath.row];
        [self.delegate menuCellDidSelector:self cellItem:item];
    }
}
#pragma mark - tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"reportMenuCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.menuDataArr[indexPath.row].name;
    if (self.menuDataArr[indexPath.row].isSelector) {
        cell.textLabel.textColor = KCarSeriouslyMainColor;
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menuTick-icon"]];
    }else {
        cell.textLabel.textColor = [UIColor blackColor];
        cell.accessoryView = nil;
    }
    return cell;
}
#pragma mark - lazy load
- (UITableView *)menuTableView {
    if (_menuTableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, 200) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        _menuTableView = tableView;
    }
    return _menuTableView;
}


@end
