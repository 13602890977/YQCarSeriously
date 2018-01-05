//
//  UIView+YQSafe.m
//  CarSeriously
//
//  Created by apple on 2017/12/21.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "UIView+YQSafe.h"

#import <Availability.h>

@implementation UIView (YQSafe) 

- (UIEdgeInsets)viewSafeInset {
    if (@available(iOS 11.0, *)) {
        return self.safeAreaInsets;
    }
    return UIEdgeInsetsZero;
}

- (MASViewAttribute *)yq_safeAreaLayoutGuideTop {
    if (@available(iOS 11.0,*)) {
        
        return [[MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeTop];
    }else {
        return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTop];
    }
}
- (MASViewAttribute *)yq_safeAreaLayoutGuideBottom {
    if (@available(iOS 11.0,*)) {
        
        return [[MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
    }else {
        return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottom];
    }
}
- (MASViewAttribute *)yq_safeAreaLayoutGuideLeft {
    if (@available(iOS 11.0,*)) {
        
        return [[MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeLeft];
    }else {
        return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeft];
    }
}
- (MASViewAttribute *)yq_safeAreaLayoutGuideRight {
    if (@available(iOS 11.0,*)) {
        
        return [[MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeRight];
    }else {
        return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRight];
    }
}

@end
