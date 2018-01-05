//
//  YQCarSourceReportStateMenuView.h
//  CarSeriously
//
//  Created by apple on 2017/12/29.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQReportStateMenuView.h"


@interface YQCarSourceReportStateMenuView : YQReportStateMenuView
{
    NSMutableArray *_menuDataArr;//不想直接调用父类的self.menuDataArr，需要这样声明
}

@end
