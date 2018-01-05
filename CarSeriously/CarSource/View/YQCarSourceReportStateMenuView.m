//
//  YQCarSourceReportStateMenuView.m
//  CarSeriously
//
//  Created by apple on 2017/12/29.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQCarSourceReportStateMenuView.h"
#import "YQIntervalValueCell.h"

@interface YQCarSourceReportStateMenuView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *carTableView;
@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic,strong)UIView *footerView;

@end

@implementation YQCarSourceReportStateMenuView

@synthesize menuDataArr = _menuDataArr;

//重写数据源setter 来重新设置界面
- (void)setMenuDataArr:(NSMutableArray<YQReportMenuItem *> *)menuDataArr {
    _menuDataArr = menuDataArr;
    [self addSubview:self.carTableView];
    [self.carTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        //120是cell的高度，根据数据数量，设置不同的高度，60是tableview底部按钮的高度
        make.height.mas_equalTo(120 * menuDataArr.count + 60);
    }];
    self.carTableView.tableFooterView = self.footerView;
}
#pragma mark 确定按钮点击事件
- (void)confirmBtnClick:(UIButton *)button {
    
}
#pragma mark - table delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //重写cell的点击事件，覆盖父类的操作
}
#pragma mark - table dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YQIntervalValueCell *cell = [YQIntervalValueCell cellCreatWithTabelView:tableView];
    cell.menuItem = self.menuDataArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
#pragma mark - lazy load
- (UITableView *)carTableView {
    if (_carTableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, 44) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollEnabled = false;
        _carTableView = tableView;
    }
    return _carTableView;
}
- (UIView *)footerView {
    if (_footerView == nil) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.carTableView.width, 60)];
        view.backgroundColor = [UIColor whiteColor];
        view.userInteractionEnabled = true;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20, 10, view.width - 40, 40);
        button.backgroundColor = KCarSeriouslyMainColor;
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchDown];
        [view addSubview:button];
        _footerView = view;
    }
    return _footerView;
}
@end
