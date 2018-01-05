//
//  AboutTableViewController.m
//  CarSeriously
//
//  Created by apple on 17/7/11.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "AboutTableViewController.h"

@interface AboutTableViewController ()
@property(nonatomic,strong)NSArray<NSArray<NSString *> *> *aboutDataArr;

@end

@implementation AboutTableViewController

- (NSArray<NSArray<NSString *> *> *)aboutDataArr {
    if (_aboutDataArr == nil) {
        _aboutDataArr = [NSArray arrayWithObjects:@[@"website-icon",@"WeChat-icon",@"telephone-icon",@"Mail-icon",@"QQgroup-icon"],@[@"官方网站：www.chejiaozhen.com",@"微信账号：chejiaozhen",@"客服电话：020-12345678",@"商务合作邮箱：bd@chejiaozhen.com",@"用户QQ群：12433252235"], nil];
    }
    return _aboutDataArr;
}
- (instancetype)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于车较真";
    
    [self setHeaderView];
//    [self setFooterView];
    //注册监听横竖屏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
}

- (void)setHeaderView {
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCRW, 200)];
     
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake((baseView.width - 100)*0.5, 20, 100, 80)];
    iconView.image = [UIImage imageNamed:@"logo"];
    [iconView sizeToFit];
    [baseView addSubview:iconView];
    
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, iconView.maxY + 20, SCRW, 21)];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    
    versionLabel.text = @"车较真 V1.0";
    [baseView addSubview:versionLabel];
    
    
    NSString *appStr = @"    广州车较真科技有限公司（以下简称：车较真）是一家成立于2014年的互联网二手车验真平台，核心来自百度、华为、腾讯等知名企业的高级管理团队与资深技术团队。";
    
    CGSize appStrSize = [appStr boundingRectWithSize:CGSizeMake(SCRW - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    
    UILabel *appLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, versionLabel.maxY + 10, SCRW - 20, appStrSize.height)];
    appLabel.font = [UIFont systemFontOfSize:16];
    appLabel.numberOfLines = 0;
    appLabel.text = appStr;
    [baseView addSubview:appLabel];
    
    baseView.frame = CGRectMake(0, 0, SCRW, appLabel.maxY + 30);
    
    self.tableView.tableHeaderView = baseView;
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(iconView.width);
        make.height.mas_equalTo(iconView.height);
        make.top.equalTo(baseView).with.offset(20);
        make.centerX.equalTo(baseView);
    }];
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(baseView);
        make.top.equalTo(iconView.mas_bottom).with.offset(20);
        make.centerX.equalTo(baseView);
        make.height.mas_equalTo(21);
    }];
    [appLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [appLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [appLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(baseView).offset(10);
        make.right.equalTo(baseView).offset(-10); make.top.equalTo(versionLabel.mas_bottom).with.offset(10);
        make.centerX.equalTo(baseView);
        make.bottom.equalTo(baseView.mas_bottom).offset(-10);
    }];
    
}

- (void)setFooterView {
    
    CGFloat height = SCRH - (44 * 5 + self.tableView.tableHeaderView.frame.size.height + 64);
    height = fabs(height);
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCRW, height)];
    
    self.tableView.tableFooterView = baseView;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, baseView.height - 30, SCRW, 21)];
    label.text = @"粤ICP备13231-1";
    label.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableFooterView = baseView;
    [baseView addSubview:label];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.aboutDataArr.firstObject.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aboutCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aboutCell"];
        
        cell.textLabel.text = self.aboutDataArr.lastObject[indexPath.section];
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.aboutDataArr.firstObject[indexPath.section]]];
    }
    
    return cell;
}
#pragma mark - 横竖屏变化监听
- (void)deviceOrientationDidChange:(NSNotification *)noti {
    [self.tableView reloadData];
}
#pragma mark - 移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
