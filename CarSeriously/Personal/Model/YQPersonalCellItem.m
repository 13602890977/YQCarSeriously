//
//  YQPersonalCellItem.m
//  CarSeriously
//
//  Created by apple on 2017/12/20.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQPersonalCellItem.h"


@implementation YQPersonalCellItem


+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title {
    //这里需要使用self来初始化，self的意思是调用该方法的类名,当子类调用父类这个方法的时候才能显示子类的特性
    YQPersonalCellItem *item = [[self alloc] init];
    item.image = image;
    item.title = title;
    
    return item;
}

@end
