//
//  YQReportMenuItem.h
//  CarSeriously
//
//  Created by apple on 2017/12/29.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQReportMenuItem : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)NSNumber *itemId;

@property(nonatomic,copy)NSString *unit;
/**
 车源菜单的分段标签
 */
@property(nonatomic,strong)NSArray<NSString *> *titleArr;
/**
 用来判断当前数据是否是被选择的
 */
@property(nonatomic,assign)BOOL isSelector;
+ (instancetype)menuItemWithDic:(NSDictionary *)dict;
@end
