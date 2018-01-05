//
//  MainTabBarItem.m
//  CarSeriously
//
//  Created by apple on 17/7/4.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "MainTabBarItem.h"

@implementation MainTabBarItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        //保持图片原来的颜色
        self.image = [self.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.selectedImage = [self.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [self setTitleTextAttributes:@{NSForegroundColorAttributeName:[self mostColorWithImage:self.image]} forState:UIControlStateNormal];
        
        [self setTitleTextAttributes:@{NSForegroundColorAttributeName:KCarSeriouslyMainColor} forState:UIControlStateSelected];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        //保持图片原来的颜色
        self.image = [self.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.selectedImage = [self.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [self setTitleTextAttributes:@{NSForegroundColorAttributeName:[self mostColorWithImage:self.image]} forState:UIControlStateNormal];
        
        [self setTitleTextAttributes:@{NSForegroundColorAttributeName:KCarSeriouslyMainColor} forState:UIControlStateSelected];
    }
    return self;
}


- (UIColor *)mostColorWithImage:(UIImage *)image {
    
    #if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    #else
    int bitmapInfo = kCGImageAlphaPremultipliedLast
    #endif
    
    //第一步，先把图片缩小 加快计算速度，但越小误差越大
    CGSize size = CGSizeMake(50, 50);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8,/*bits per component*/size.width * 4, colorSpace, bitmapInfo);
    
    
    CGRect drawRect = CGRectMake(0, 0, size.width, size.height);
    
    CGContextDrawImage(context, drawRect, image.CGImage);
    
    CGColorSpaceRelease(colorSpace);
    
    
    //第二步 取每个点的像素值
    unsigned char *data = CGBitmapContextGetData(context);
    if (data == NULL)  {
        return nil;
    }
    NSCountedSet *cls = [NSCountedSet setWithCapacity:size.width * size.height];
    
    for (int x = 0 ; x < size.width; x++) {
        for (int y = 0 ; y < size.height; y++) {
            int offset = 4*(x*y);
            
            int red = data[offset];
            int green = data[offset + 1];
            int blue = data[offset + 2];
            int alpha = data[offset + 3];
            
            if (alpha != 255) {
                continue;
            }
            NSArray *colorArr = @[@(red),@(green),@(blue),@(alpha)];
            [cls addObject:colorArr];
        }
    }
    
    CGContextRelease(context);
    
    
    //第三步 找出出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    
    NSArray *MaxColor = nil;
    NSUInteger MaxCount = 0;
    
    while ((curColor = [enumerator nextObject]) != nil) {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if (tmpCount < MaxCount) {
            continue;
        }
        MaxCount = tmpCount;
        MaxColor = curColor;
    }
    
    NSLog(@"---%d,--%d,--%d",[MaxColor[0] intValue],[MaxColor[1] intValue],[MaxColor[2] intValue]);
    
    return [UIColor colorWithRed:[MaxColor[0] intValue]/255.0f green:[MaxColor[1] intValue]/255.0f blue:[MaxColor[2] intValue] / 255.0f alpha:1.0];
}

@end
