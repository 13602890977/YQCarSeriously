//
//  YQGroupItem.h
//  CarSeriously
//
//  Created by apple on 2017/12/20.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//
//用于保存每一组cell的数据的模型

#import <Foundation/Foundation.h>


@interface YQGroupItem : NSObject

@property(nonatomic,strong)NSString *headerTitle;
@property(nonatomic,strong)NSString *footerTitle;

@property(nonatomic,strong)NSArray *itemArr;

@end
