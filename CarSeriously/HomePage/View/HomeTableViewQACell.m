//
//  HomeTableViewQACell.m
//  CarSeriously
//
//  Created by apple on 17/7/10.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

//首页问答cell
#import "HomeTableViewQACell.h"

#import "YQHomeHeaderLabel.h"
#import "YQQACellCell.h"
#import "YQQACellItem.h"

#import "YQHomeQAModel.h"

@interface HomeTableViewQACell ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIView *baseView;
@property(nonatomic,strong)UITableView *secondTableView;
@property(nonatomic,strong)YQHomeHeaderLabel *headerLabel;

@property(nonatomic,strong)NSMutableArray<YQQACellItem *> *dataArr;
@end

@implementation HomeTableViewQACell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
        
        [self.contentView addSubview:self.baseView];
        [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsMake(0, 10, 10, 10));
        }];
        [self.baseView addSubview:self.headerLabel];
        [self.headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.baseView);
            make.height.mas_offset(30);
        }];
        [self.baseView addSubview:self.secondTableView];
        [self.secondTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.baseView);
            make.top.equalTo(self.headerLabel.mas_bottom);
            make.height.mas_offset(400);
        }];
        [self getQAData];
    }
    return self;
}
- (void)deviceChange:(NSNotification *)noti {
    [self.dataArr removeAllObjects];
    [self getQAData];
}
//即将消失的时候移除通知
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)getQAData {
    CGFloat height = 0;
    NSArray *arr = @[@{@"qu":@"车较真是一家提供车辆验真服务的平台车较真是一家提供车辆验真服务的平台",@"ass":@"车较真是一家提供车辆验真服务的平台，基于大数据全方位分析二手车辆综合情况，"},@{@"qu":@"发完货返利网华为后期维护然后我去or还欠我胸",@"ass":@"车较真是一家提供车辆验真服务的平台，基于大数据全方位分析二手车辆综合情况，杜绝事故车，泡水车，调表车等，并提供一份真实具有权威性的检测报告。"}];
    for (NSDictionary *dicr in arr) {
        YQQACellItem *item = [YQQACellItem itemWithDict:dicr];
        [self.dataArr addObject:item];
        height += (KHomeQLabelTop20 + KHomeALabelTop15 + KHomeALabelBottom10);
        height += (item.problemHeight > KHomeQAIconHeight32 ? item.problemHeight : KHomeQAIconHeight32);
        height += (item.answerHeight > KHomeQAIconHeight32 ? item.answerHeight : KHomeQAIconHeight32);
    }
    [self.secondTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    [self.secondTableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = KHomeQLabelTop20 + KHomeALabelTop15 + KHomeALabelBottom10;
    if (self.dataArr[indexPath.row].problemHeight < KHomeQAIconHeight32) {
        height += KHomeQAIconHeight32;
    }else {
        height += self.dataArr[indexPath.row].problemHeight;
    }
    if (self.dataArr[indexPath.row].answerHeight < KHomeQAIconHeight32) {
        height += KHomeQAIconHeight32;
    }else {
        height += self.dataArr[indexPath.row].answerHeight;
    }
    return height;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    YQQACellCell *cell = [YQQACellCell qaCellCellWithTableView:tableView indexPath:indexPath];
    cell.item = self.dataArr[indexPath.row];
    return cell;
}

+ (instancetype)homeCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"homeTableViewQACellIdentifier";
    
    HomeTableViewQACell *cell = (HomeTableViewQACell *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = COLOR_RGB(230, 230, 230);
    return cell;
}

#pragma mark - 懒加载控件
- (UIView *)baseView {
    if (_baseView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        _baseView = view;
    }
    return _baseView;
}
- (YQHomeHeaderLabel *)headerLabel {
    if (_headerLabel == nil) {
        _headerLabel = [YQHomeHeaderLabel labelHasLineWithFrame:CGRectMake(0, 0, SCRW, 30) text:@"车较真问答"];
    }
    return _headerLabel;
}
- (UITableView *)secondTableView {
    if (_secondTableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCRW, 400) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        tableView.scrollEnabled = false;//不能滚动
        _secondTableView = tableView;
    }
    return _secondTableView;
}

- (NSMutableArray<YQQACellItem *> *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
