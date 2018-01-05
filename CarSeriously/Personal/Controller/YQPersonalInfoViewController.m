//
//  YQPersonalInfoViewController.m
//  CarSeriously
//
//  Created by apple on 2017/12/25.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//
//账户信息

#import "YQPersonalInfoViewController.h"

#import "YQGroupItem.h"
#import "YQPersonalInfoItem.h"
#import "YQPersonalInfoHeaderItem.h"
@interface YQPersonalInfoViewController ()

@property(nonatomic,strong)NSMutableArray<YQGroupItem *> *groupItemArr;
@end

@implementation YQPersonalInfoViewController

- (instancetype)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navigationItem.title = @"账户信息";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatGroup01];
    [self creatGroup02];
    [self creatGroup03];
}
- (void)creatGroup01 {
    YQGroupItem *item = [[YQGroupItem alloc] init];
    
    YQPersonalInfoHeaderItem *iconItem = [YQPersonalInfoHeaderItem itemWithImage:[UIImage imageNamed:@"arrow-icon-gray"] title:nil];
    iconItem.iconImage = [UIImage imageNamed:@"HeadPortrait"];
    iconItem.detailTitle = @"更换头像";
    
    item.itemArr = @[iconItem];
    [self.groupItemArr addObject:item];
}
- (void)creatGroup02 {
    YQGroupItem *item = [[YQGroupItem alloc] init];
    
    YQPersonalInfoItem *accountItem = [YQPersonalInfoItem itemWithImage:nil title:@"账户"];
    accountItem.detailTitle = @"18954235484";
    YQPersonalInfoItem *nameItem = [YQPersonalInfoItem itemWithImage:[UIImage imageNamed:@"feedback-icon"] title:@"姓名"];
    nameItem.detailTitle = @"娘纷纷";
    YQPersonalInfoItem *nickItem = [YQPersonalInfoItem itemWithImage:[UIImage imageNamed:@"arrow-icon-gray"] title:@"昵称"];
    nickItem.detailTitle = @"保密";
    
    item.itemArr = @[accountItem,nameItem,nickItem];
    [self.groupItemArr addObject:item];
}
- (void)creatGroup03 {
    YQGroupItem *item = [[YQGroupItem alloc] init];
    
    YQPersonalInfoItem *passItem = [YQPersonalInfoItem itemWithImage:[UIImage imageNamed:@"arrow-icon-gray"] title:@"修改密码"];
    
    YQPersonalInfoItem *accountItem = [YQPersonalInfoItem itemWithImage:[UIImage imageNamed:@"arrow-icon-gray"] title:@"更改绑定"];
    accountItem.detailTitle = @"18954235484";
    item.itemArr = @[passItem,accountItem];
    [self.groupItemArr addObject:item];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groupItemArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupItemArr[section].itemArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"personalInfoCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    YQPersonalCellItem *item = self.groupItemArr[indexPath.section].itemArr[indexPath.row];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.detailTitle;
    
    cell.accessoryView = [[UIImageView alloc] initWithImage:item.image];
    if ([item isKindOfClass:[YQPersonalInfoHeaderItem class]]) {
        cell.imageView.image = ((YQPersonalInfoHeaderItem *)item).iconImage;
        tableView.rowHeight = 64;
    }else {
        cell.imageView.image = nil;
        tableView.rowHeight = 44;
    }
    return cell;
}

- (NSMutableArray<YQGroupItem *> *)groupItemArr {
    if (_groupItemArr == nil) {
        _groupItemArr = [NSMutableArray array];
    }
    return _groupItemArr;
}
@end
