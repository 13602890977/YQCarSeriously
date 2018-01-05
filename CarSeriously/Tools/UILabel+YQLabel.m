//
//  UILabel+YQLabel.m
//  CarSeriously
//
//  Created by apple on 2017/12/21.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "UILabel+YQLabel.h"

@implementation UILabel (YQLabel)

- (instancetype)init {
    if (self = [super init]) {
        if (@available(iOS 10.0,*)) {
            
            self.adjustsFontForContentSizeCategory = true;
        }
    }
    return self;
}


@end
