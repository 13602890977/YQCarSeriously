//
//  YQReportDetailSectionHeaderView.h
//  CarSeriously
//
//  Created by apple on 2018/1/5.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^sectionSelectBlodk)(NSInteger section,BOOL isdown);

@interface YQReportDetailSectionHeaderView : UIView

@property(nonatomic,strong)NSMutableDictionary *dataDict;
@property(nonatomic,copy)sectionSelectBlodk block;

+ (instancetype)headerViewWithFrame:(CGRect)frame section:(NSInteger)section;
@end
