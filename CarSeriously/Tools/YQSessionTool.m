//
//  YQSessionTool.m
//  CarSeriously
//
//  Created by apple on 2017/12/22.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//
#import "YQSessionTool.h"




@interface YQSessionTool()

@property(nonatomic,copy)blockResult block;

@end

@implementation YQSessionTool


static YQSessionTool *_sessionTool;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sessionTool = [super allocWithZone:zone];
    });
    return _sessionTool;
}
+ (instancetype)shareTool {
    
    return [[self alloc] init];
    
}
//保证深拷贝和浅拷贝都是同一份内存
- (id)copyWithZone:(NSZone *)zone {
    return _sessionTool;
}
- (id)mutableCopyWithZone:(NSZone *)zone {
    return _sessionTool;
}

/**注册*/
- (void)getRegisterWithUrl:(NSString *)urlStr resultBlock:(void (^ _Nullable)(NSDictionary*_Nullable dictData,NSString *_Nullable message))result {
    NSString *str = [KCarSeriouslyHttpTest stringByAppendingPathComponent:urlStr];
    AFHTTPSessionManager *menager = [AFHTTPSessionManager manager];
    [menager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
/**登录*/
- (void)postLoginWithUrl:(NSString *)urlStr parameters:(NSDictionary *)para resultBlock:(void(^)(NSDictionary *dictData,NSString *msg))result {
    NSString *str = [KCarSeriouslyHttpTest stringByAppendingPathComponent:urlStr];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:str parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
/**
 测试

 @param urlStr <#urlStr description#>
 @param result <#result description#>
 */
- (void)getDataWithUrl:(NSString *)urlStr resultBlock:(void (^ _Nullable)(NSDictionary *_Nullable dictData,NSString * _Nullable message))result {
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSDictionary *dict = responseObject;
        if (error == nil) {
            result(dict,nil);
        }else {
            NSLog(@"数据解析出错--%@",error);
            
            result(dict,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"登录失败--error");
        result(nil,@"失败");
    }];
}

@end
