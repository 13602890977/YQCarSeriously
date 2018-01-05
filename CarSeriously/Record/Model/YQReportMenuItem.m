//
//  YQReportMenuItem.m
//  CarSeriously
//
//  Created by apple on 2017/12/29.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQReportMenuItem.h"

@implementation YQReportMenuItem

+ (instancetype)menuItemWithDic:(NSDictionary *)dict {
    
    YQReportMenuItem *item = [[self alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    item.isSelector = false;
    return item;
}
@end
