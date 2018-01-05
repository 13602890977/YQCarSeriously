//
//  YQSessionTool.h
//  CarSeriously
//
//  Created by apple on 2017/12/22.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^blockResult)(NSDictionary *_Nullable  dataDic,NSString  * _Nullable msg);


@interface YQSessionTool : NSObject<NSCopying,NSMutableCopying>

+ (instancetype _Nonnull)shareTool;

- (void)getDataWithUrl:(NSString *_Nonnull)urlStr resultBlock:(void (^ _Nullable)(NSDictionary *_Nullable dictData,NSString * _Nullable message))result;

- (void)postLoginWithUrl:(NSString *_Nonnull)urlStr parameters:(NSDictionary * _Nullable)para resultBlock:(void(^ _Nullable)(NSDictionary * _Nullable dictData,NSString * _Nullable msg))result;
@end
