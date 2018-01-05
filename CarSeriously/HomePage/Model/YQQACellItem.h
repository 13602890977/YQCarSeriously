//
//  YQQACellItem.h
//  CarSeriously
//
//  Created by apple on 2017/12/27.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YQQACellItem : NSObject

@property(nonatomic,copy)NSString *qu;
@property(nonatomic,copy)NSString *ass;
@property(nonatomic,assign)CGFloat problemHeight;
@property(nonatomic,assign)CGFloat answerHeight;

+ (instancetype)itemWithDict:(NSDictionary *)dict;
@end
