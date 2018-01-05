//
//  YQCGImage.h
//  CarSeriously
//
//  Created by apple on 2018/1/3.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQCGImage : UIImage


/**
 创建车较真主色调的image

 @return KCarSeriouslyMainColor的image
 */
+ (UIImage *)getImageWithCarMainColor;
/**
 创建白色透明的image

 @return 白色透明的image
 */
+ (UIImage *)getImageWithWhiteColor;
@end
