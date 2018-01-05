//
//  YQCGImage.m
//  CarSeriously
//
//  Created by apple on 2018/1/3.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//

#import "YQCGImage.h"

@implementation YQCGImage

+ (UIImage *)getImageWithCarMainColor {
    
    CGRect rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ref, KCarSeriouslyMainColor.CGColor);
    //设置透明度
//    CGContextSetAlpha(ref, 0);
    CGContextFillRect(ref, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}
+ (UIImage *)getImageWithWhiteColor {
    
    CGRect rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ref, [UIColor whiteColor].CGColor);
    CGContextSetAlpha(ref, 0);
    CGContextFillRect(ref, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}
@end
