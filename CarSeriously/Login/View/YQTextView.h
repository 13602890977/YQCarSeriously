//
//  YQTextView.h
//  CarSeriously
//
//  Created by apple on 2017/12/20.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQTextView : UIView

/**
 左边的图片
 */
@property(nonatomic,strong)UIImage *leftImage;

/**
 主要的textfield
 */
@property(nonatomic,strong)UITextField *mainTextField;

+ (instancetype)textViewWithRect:(CGRect )rect;
@end
