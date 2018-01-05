//
//  UIView+YQSafe.h
//  CarSeriously
//
//  Created by apple on 2017/12/21.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "View+MASAdditions.h"
#import <objc/runtime.h>

@interface UIView (YQSafe)

- (UIEdgeInsets)viewSafeInset;

- (MASViewAttribute *)yq_safeAreaLayoutGuideTop;
- (MASViewAttribute *)yq_safeAreaLayoutGuideBottom;
- (MASViewAttribute *)yq_safeAreaLayoutGuideLeft;
- (MASViewAttribute *)yq_safeAreaLayoutGuideRight;

@end
