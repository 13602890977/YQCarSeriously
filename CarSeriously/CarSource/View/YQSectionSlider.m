//
//  YQSectionSlider.m
//  CarSeriously
//
//  Created by apple on 2018/1/2.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//

#import "YQSectionSlider.h"

@interface YQSectionSlider()
{
    //保存固定的Y值
    CGFloat _constOffY;
}

@property(nonatomic,strong)UIView *leftSlider;
@property(nonatomic,strong)UIView *currentSlider;
@property(nonatomic,strong)UIView *rightSlider;
@property(nonatomic,strong)UIButton *minButton;
@property(nonatomic,strong)UIButton *maxButton;
@property(nonatomic,assign)NSInteger cellTitleNum;
@end

@implementation YQSectionSlider

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        /***************模仿tableview，暂时没写******************/
        if ([_dataSource respondsToSelector:@selector(sectionSlider:numberOfRows:)]) {
           self.cellTitleNum = [self.dataSource sectionSlider:self numberOfRows:0];
            
        }
        /*********************************/
        self.userInteractionEnabled = true;
        [self addSubview:self.currentSlider];
        [self.currentSlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(5);
        }];
        [self addSubview:self.leftSlider];
        [self.leftSlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.currentSlider.mas_left);
            make.top.equalTo(self.currentSlider.mas_top);
            make.height.equalTo(self.currentSlider.mas_height);
            make.width.mas_equalTo(0);
        }];
        [self addSubview:self.rightSlider];
        [self.rightSlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.currentSlider.mas_right);
            make.top.equalTo(self.currentSlider.mas_top);
            make.height.equalTo(self.currentSlider.mas_height);
            make.width.mas_equalTo(0);
        }];
        [self addSubview:self.minButton];
        [self.minButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.leftSlider.mas_centerY);
            make.width.height.mas_equalTo(40);
            make.centerX.equalTo(self.currentSlider.mas_left).offset(0);
        }];
        [self addSubview:self.maxButton];
        [self.maxButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.currentSlider.mas_centerY);
            make.width.height.mas_equalTo(40);
            make.centerX.equalTo(self.rightSlider.mas_right);
        }];
        
        _constOffY = _leftSlider.centerY;
        
    }
    return self;
}
- (void)setCellTitleNum:(NSInteger)cellTitleNum {
    _cellTitleNum = cellTitleNum;
}
- (void)setSectionTitleArr:(NSArray<NSString *> *)sectionTitleArr {
    _sectionTitleArr = sectionTitleArr;
    
    UILabel *nextLabel = nil;
    for (int i = 0; i < self.sectionTitleArr.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width/self.sectionTitleArr.count, 21)];
        label.textAlignment = NSTextAlignmentCenter;
        
        label.text = self.sectionTitleArr[i];
        
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (nextLabel) {
                make.left.equalTo(nextLabel.mas_right);
            }else {
                make.left.equalTo(self);
            }
            make.height.mas_equalTo(21);
            make.top.equalTo(self.currentSlider.mas_bottom).offset(20);
            make.width.equalTo(self.mas_width).multipliedBy(1.0/self.sectionTitleArr.count);
        }];
        nextLabel = label;
    }
}
- (void)setMaximumTrackTintColor:(UIColor *)maximumTrackTintColor {
    _maximumTrackTintColor = maximumTrackTintColor;
    self.currentSlider.backgroundColor = maximumTrackTintColor;
}

#pragma mark - 左边的图片拖动事件
- (void)minPanChange:(UIPanGestureRecognizer *)gesture {
    //取出手势从点击开始到拖动结束  相对于view的距离变化
    CGPoint point = [gesture translationInView:self];
    static CGPoint center;//用来保存当前button的位置
//    UIButton *minButton = (UIButton *)gesture.view;
    if (gesture.state == UIGestureRecognizerStateBegan) {
        center = self.minButton.center;
    }
    __weak typeof(self) weakSelf = self;
    __block CGFloat leftX = 0;
    [self.minButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        /*
         0.82 等于10
         0.66 等于8
         (self.sectionTitleArr.count - 1)
        */
        //根据当前button位置和移动的距离，重新设置button的中心点位置
        leftX = center.x + point.x;
        
        NSUInteger count = weakSelf.sectionTitleArr.count - 1;
        //计算按钮中点位置相对于currentslider的宽度比例
        CGFloat xScale = leftX/weakSelf.currentSlider.width;
        
        for (int i = 0; i < count; i++) {
            CGFloat scale = (CGFloat)i/count;//取出每一段的比例长度(7个title只有6段)
            if (xScale > scale && xScale < scale + 0.5) {//判断按钮的位置比例是否不超过一段的距离，如果是就指定按钮的位置在这一段的末尾上
                leftX = weakSelf.currentSlider.width*scale;
            }
        }
        //判断是否超过右边的按钮，20是按钮的半径
//        NSLog(@"%lf右边按钮的中点%lf",leftX,weakSelf.maxButton.centerX);
        if (leftX+20 >= weakSelf.maxButton.centerX) {
            
            leftX = weakSelf.maxButton.centerX - 20;
        }
        else if (leftX > weakSelf.currentSlider.width*(count - 1)/count) {//不能超过滑动条的
            leftX = weakSelf.currentSlider.width*(count - 1)/count;
        }else if (leftX < 0) {//button不能脱离currentslider
            leftX = 0;
        }
        make.centerX.equalTo(weakSelf.currentSlider.mas_left).offset(leftX);
        make.centerY.equalTo(weakSelf.currentSlider.mas_centerY);
        make.width.height.mas_equalTo(40);
    }];
    //调整左边view的宽度，覆盖底部的view，达到滑动效果
    [_leftSlider mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(gesture.view.centerX - 20);
    }];
    //取值
    [self valueChangeformView:self.minButton number:leftX];
}
#pragma mark - 右边的图片按钮拖动事件
- (void)maxPanChange:(UIPanGestureRecognizer *)gesture {
    //取出手势从点击开始到拖动结束  相对于view的距离变化
    CGPoint point = [gesture translationInView:self];
    static CGPoint center;//保存当前按钮的中点
    if (gesture.state == UIGestureRecognizerStateBegan) {
        center = self.maxButton.center;
    }
    __weak typeof(self) weakSelf = self;
    //向左移为负 (point.x)
    __block CGFloat rightX = 0;
    [self.maxButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        rightX = self.currentSlider.width - center.x + point.x;
        NSInteger count = self.sectionTitleArr.count - 1;
        CGFloat xScale = -rightX/self.currentSlider.width;
        
        for (NSInteger i = 0; i < count; i++) {
            CGFloat scale = (CGFloat)i/count;
            if (xScale > scale && xScale < scale + 0.5) {
                rightX = -self.currentSlider.width*scale;//按比例，分段显示
            }
        }
        //判断不能移动超过最后一个，只能到倒数第二个数字上
        if (rightX <= -weakSelf.currentSlider.width*(count - 1)/count) {
            rightX = -weakSelf.currentSlider.width*(count - 1)/count;
        }else if (rightX <= -(weakSelf.currentSlider.width - weakSelf.minButton.centerX)) {
            rightX = -(weakSelf.currentSlider.width - weakSelf.minButton.centerX + 20);
        }else if (rightX > 0) {
            rightX = 0;
        }
        
        make.centerX.equalTo(weakSelf.currentSlider.mas_right).offset(rightX);
        make.centerY.equalTo(weakSelf.currentSlider.mas_centerY);
        make.width.height.mas_equalTo(40);
        
    }];
    
    [_rightSlider mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.currentSlider.width - (gesture.view.centerX-20));
    }];
    
    [self valueChangeformView:self.maxButton number:rightX];
}

- (void)valueChangeformView:(UIButton *)button number:(CGFloat)distance {
    NSInteger index = fabs(distance/self.currentSlider.width * self.sectionTitleArr.count);
    if (button == self.minButton) {//左边按钮
        NSString *minStr = self.sectionTitleArr[index];
        if ([_delegate respondsToSelector:@selector(didSelectorSectionMinNum:)]) {
            [self.delegate didSelectorSectionMinNum:minStr];
        }
    }else {//右边按钮
        //数组反转
        NSArray *arr = [[self.sectionTitleArr reverseObjectEnumerator] allObjects];
        NSString *maxStr = arr[index];
        if ([_delegate respondsToSelector:@selector(didSelectorSectionMaxNum:)]) {
            [self.delegate didSelectorSectionMaxNum:maxStr];
        }
    }
}
#pragma mark - lazy load
- (UIView *)leftSlider {
    if (_leftSlider == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = KCarSeriouslyMainColor;
        _leftSlider = view;
    }
    return _leftSlider;
}
- (UIView *)currentSlider {
    if (_currentSlider == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor grayColor];
        _currentSlider = view;
    }
    return _currentSlider;
}

- (UIView *)rightSlider {
    if (_rightSlider == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = KCarSeriouslyMainColor;
        _rightSlider = view;
    }
    return _rightSlider;
}
- (UIButton *)minButton {
    if (_minButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 28, 28);
        [button setImage:[UIImage imageNamed:@"slidingBlock"] forState:UIControlStateNormal];
        //点击时显示高亮
        button.showsTouchWhenHighlighted = true;
        //添加拖动手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(minPanChange:)];
        [button addGestureRecognizer:pan];
        _minButton = button;
    }
    return _minButton;
}

- (UIButton *)maxButton {
    if (_maxButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 28, 28);
        [button setImage:[UIImage imageNamed:@"slidingBlock"] forState:UIControlStateNormal];
        //点击时显示高亮
        button.showsTouchWhenHighlighted = true;
        //添加拖动手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(maxPanChange:)];
        [button addGestureRecognizer:pan];
        _maxButton = button;
    }
    return _maxButton;
}

@end
