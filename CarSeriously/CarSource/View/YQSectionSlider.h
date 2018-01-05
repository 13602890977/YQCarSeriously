//
//  YQSectionSlider.h
//  CarSeriously
//
//  Created by apple on 2018/1/2.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YQSectionSlider;

@protocol YQSectionSliderDataSource<NSObject>

- (NSInteger)sectionSlider:(YQSectionSlider *_Nonnull)slider numberOfRows:(NSInteger)row;

- (nullable NSArray<NSString *> *)titlesForSlider:(YQSectionSlider *_Nonnull)slider;
@end

@protocol YQSectionSliderDelegate<NSObject>

/**
 左边按钮选择数值之后的回调

 @param minNumStr 返回数值字符，与sectionTitleArr绑定
 */
- (void)didSelectorSectionMinNum:(NSString *_Nonnull)minNumStr;

/**
 右边按钮选择数值之后的回调

 @param maxNumStr 返回区间最大的数值，与sectionTitleArr反向绑定
 */
- (void)didSelectorSectionMaxNum:(NSString *_Nonnull)maxNumStr;

@end

@interface YQSectionSlider : UIView


@property(nonatomic,weak)id<YQSectionSliderDataSource> _Nullable dataSource;
@property(nonatomic,weak)id<YQSectionSliderDelegate> _Nullable delegate;
/**
 接收分段的标题文字数据，不能为空，用来判断个数的
 */
@property(nonatomic,strong,nonnull)NSArray<NSString *> *sectionTitleArr;
/**
 设置滑过的颜色
 */
@property(nonatomic,strong,nullable)UIColor *minimumTrackTintColor;

/**
 设置未滑过的颜色
 */
@property(nonatomic,strong,nullable)UIColor *maximumTrackTintColor;

/**
 滑动条的高度,默认为5
 */
@property(nonatomic,assign)CGFloat sliderHeight;
@end
