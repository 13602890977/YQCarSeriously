//
//  YQQACellItem.m
//  CarSeriously
//
//  Created by apple on 2017/12/27.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQQACellItem.h"



@implementation YQQACellItem

- (void)setQu:(NSString *)qu {
    _qu = qu;
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:17]};
    CGSize size = [qu boundingRectWithSize:CGSizeMake(SCRW - 15 - 20 - 32 - 20 - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    self.problemHeight = size.height;
}
- (void)setAss:(NSString *)ass {
    _ass = ass;
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:17]};
    CGSize size = [ass boundingRectWithSize:CGSizeMake(SCRW - 15 - 20 - 32 - 20 - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    self.answerHeight = size.height;
}
- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+ (instancetype)itemWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDictionary:dict];
}

@end
