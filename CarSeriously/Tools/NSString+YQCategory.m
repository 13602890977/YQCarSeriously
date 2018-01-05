//
//  NSString+YQCategory.m
//  CarSeriously
//
//  Created by apple on 2017/12/21.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "NSString+YQCategory.h"

@implementation NSString (YQCategory)

- (CGSize)stringSizeWithFont:(CGFloat )font{
    NSDictionary *atts = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    return [self sizeWithAttributes:atts];
}

@end
