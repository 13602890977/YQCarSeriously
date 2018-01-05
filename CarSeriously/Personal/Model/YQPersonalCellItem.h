//
//  YQPersonalCellItem.h
//  CarSeriously
//
//  Created by apple on 2017/12/20.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//
//用于将个人中心的cell的数据转为model
#import <Foundation/Foundation.h>

@interface YQPersonalCellItem : NSObject

@property(nonatomic,strong)UIImage *image;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *detailTitle;

@property(nonatomic,strong)Class descC;
/**
 保存每个cell的操作
 */
@property(nonatomic,copy) void(^cellClickBlock)(NSIndexPath *indexPath);

+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title;
@end
