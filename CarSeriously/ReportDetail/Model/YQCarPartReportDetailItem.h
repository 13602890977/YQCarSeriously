//
//  YQCarPartReportDetailItem.h
//  CarSeriously
//
//  Created by apple on 2018/1/4.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQCarPartReportDetailItem : NSObject

@property(nonatomic,copy)NSString *partImgStr;
@property(nonatomic,copy)NSString *partName;
@property(nonatomic,copy)NSString *partReportStr;
@property(nonatomic,copy)NSString *accessoryImgStr;

@property(nonatomic,strong)UIImage *partImg;
@property(nonatomic,strong)UIImage *accessoryImg;


+ (instancetype)itemWithDict:(NSDictionary *)dict;
@end
