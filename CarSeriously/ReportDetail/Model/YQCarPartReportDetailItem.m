//
//  YQCarPartReportDetailItem.m
//  CarSeriously
//
//  Created by apple on 2018/1/4.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//

#import "YQCarPartReportDetailItem.h"

@implementation YQCarPartReportDetailItem

- (void)setPartImgStr:(NSString *)partImgStr {
    _partImgStr = partImgStr;
    
    self.partImg = [UIImage imageNamed:partImgStr];
}
- (void)setAccessoryImgStr:(NSString *)accessoryImgStr {
    _accessoryImgStr = accessoryImgStr;
    self.accessoryImg = [UIImage imageNamed:accessoryImgStr];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)itemWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

@end
