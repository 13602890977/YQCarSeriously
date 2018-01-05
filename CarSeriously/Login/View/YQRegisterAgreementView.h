//
//  YQRegisterAgreementView.h
//  CarSeriously
//
//  Created by apple on 2017/12/22.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^agreeBtnSelectBlock)(BOOL isSelect);


@interface YQRegisterAgreementView : UIView

- (void)agreeBtnClick:(agreeBtnSelectBlock)isSelect;

@end
