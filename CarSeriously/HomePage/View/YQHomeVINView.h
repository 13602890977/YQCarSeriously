//
//  YQHomeVINView.h
//  CarSeriously
//
//  Created by apple on 2017/12/25.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YQHomeVINView;

@protocol YQHomeVINViewDelegate<NSObject>

@optional
- (void)queryBtnClick:(YQHomeVINView *)vinView;

@end

@interface YQHomeVINView : UIView

@property(nonatomic,weak)id<YQHomeVINViewDelegate> delegate;
@end
