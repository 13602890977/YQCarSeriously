//
//  YQSelectReportTypeItem.h
//  CarSeriously
//
//  Created by apple on 2018/1/9.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQSelectReportTypeItem : NSObject

@property(nonatomic,copy)NSString *rightImgStr;
@property(nonatomic,copy)NSString *titleStr;
@property(nonatomic,copy)NSString *priceStr;
@property(nonatomic,copy)NSString *contentStr;

/**
 标记暂无数据的提示
 */
@property(nonatomic,assign)BOOL hasIsData;
/**
 用来标记富文本，颜色为绿色的文字
 */
@property(nonatomic,copy)NSString *attStr;

@property(nonatomic,assign)BOOL isSelect;


+ (instancetype)selectItemWithDict:(NSDictionary *)dict;
@end
