//
//  YQSelectReportTypeItem.m
//  CarSeriously
//
//  Created by apple on 2018/1/9.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//

#import "YQSelectReportTypeItem.h"

@implementation YQSelectReportTypeItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)selectItemWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}
@end
