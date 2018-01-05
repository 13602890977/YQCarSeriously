//
//  YQCarCollectionViewController.m
//  CarSeriously
//
//  Created by apple on 2017/12/25.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQCarCollectionViewController.h"

#import "YQCarCollectionCell.h"

@interface YQCarCollectionViewController ()

@end

@implementation YQCarCollectionViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"车辆收藏";
    
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = false;
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YQCarCollectionCell *cell = [YQCarCollectionCell cellCreatWithTabelView:tableView indexPath:indexPath];
    
    return cell;
}
//是否允许cell滑动编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return true;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    editingStyle = UITableViewCellEditingStyleDelete;
    
}
//自定义编辑按钮样式，数量
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *rowA = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提醒" message:@"是否删除这个收藏" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancal = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [controller addAction:cancal];
        [controller addAction:confirm];
        [self presentViewController:controller animated:true completion:nil];
    }];
    rowA.backgroundColor = [UIColor orangeColor];
    
    return @[rowA];
}

@end
