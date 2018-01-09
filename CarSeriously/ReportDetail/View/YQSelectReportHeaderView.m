//
//  YQSelectReportHeaderView.m
//  CarSeriously
//
//  Created by apple on 2018/1/5.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//

#import "YQSelectReportHeaderView.h"

#define animTime 1.0
@interface YQSelectReportHeaderView()

@property(nonatomic,strong)UIView *baseView;
@property(nonatomic,strong)UIView *baseRoundView;
@property(nonatomic,strong)UILabel *fractionLabel;
@property(nonatomic,strong)UILabel *assessmentLabel;

@property(nonatomic,strong)CAShapeLayer *cornlayer;

@property(nonatomic,strong)CADisplayLink *timer;

/**
 保存最后更新的时间戳
 */
@property(nonatomic,assign)NSTimeInterval lastUpdateTime;

/**
 保存进度时间戳
 */
@property(nonatomic,assign)NSTimeInterval progressTime;

@end
@implementation YQSelectReportHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setAllView];
    }
    return self;
}

- (void)setFraction:(NSInteger)fraction {
    _fraction = fraction;
    
    self.lastUpdateTime = [NSDate timeIntervalSinceReferenceDate];
    
    //停止定时器，保证不会重复创建定时器
    [self.timer invalidate];
    self.timer = nil;
    //创建核心定时器
    CADisplayLink *timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateFraction:)];
    if (@available(iOS 10.0,*)) {
        timer.preferredFramesPerSecond = 2;
    }else {
        timer.frameInterval = 2;
    }
    //添加到主运行循环，模式是默认，默认会在滚动时停止
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    //添加到主运行循环，模式滚动，
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:UITrackingRunLoopMode];
    
    self.timer = timer;
    
    [self setNeedsDisplay];
}

- (void)updateFraction:(CADisplayLink *)timer {
    NSTimeInterval nowTime = [NSDate timeIntervalSinceReferenceDate];
    //每执行一次就设置保存一次进度时间
    self.progressTime += nowTime - self.lastUpdateTime;
    self.lastUpdateTime = nowTime;
    if (self.progressTime >= animTime) {//判断进度时间是否超过或等于动画时长
        [self.timer invalidate];
        self.timer = nil;
        self.progressTime = animTime;//防止超过
    }
    
    self.fractionLabel.text = [NSString stringWithFormat:@"%ld分",[self currentFraction]];
    
}

- (NSInteger)currentFraction {
    if (self.progressTime >= animTime) {
        return self.fraction;
    }
    CGFloat percent = self.progressTime/animTime;
    return 300.0 + (percent*(self.fraction - 300.0));
}

- (void)drawRect:(CGRect)rect {
    if (_cornlayer) {//防止误触发view的重绘，删除图层，重新绘制
        [_cornlayer removeFromSuperlayer];
        _cornlayer = nil;
    }
    [self.layer addSublayer:self.cornlayer];
    
    
}

- (void)setAllView {
    [self addSubview:self.baseView];
    [_baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.yq_safeAreaLayoutGuideTop);
        make.left.equalTo(self.yq_safeAreaLayoutGuideLeft).offset(10);
        make.right.equalTo(self.yq_safeAreaLayoutGuideRight).offset(-10);
        make.bottom.equalTo(self.yq_safeAreaLayoutGuideBottom);
    }];
    [self addSubview:self.baseRoundView];
    [self.baseRoundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(150);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self).offset(40);
    }];
    
    [_baseRoundView addSubview:self.fractionLabel];
    [_fractionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(_baseRoundView);
        make.left.right.equalTo(_baseRoundView);
    }];
    UILabel *assessmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _baseRoundView.width, 21)];
    assessmentLabel.textColor = [UIColor whiteColor];
    assessmentLabel.text = @"new assessment";
    assessmentLabel.textAlignment = NSTextAlignmentCenter;
    [_baseRoundView addSubview:assessmentLabel];
    [assessmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_baseRoundView);
        make.top.equalTo(_fractionLabel.mas_bottom).offset(5);
        make.left.right.equalTo(_baseRoundView);
    }];
    //添加较真指数四个字的文字label
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"较真指数";
    titleLabel.font = [UIFont systemFontOfSize:21];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseRoundView.mas_bottom).offset(30);
        make.left.equalTo(self.yq_safeAreaLayoutGuideLeft);
        make.right.equalTo(self.yq_safeAreaLayoutGuideRight);
        make.height.mas_equalTo(30);
    }];
    //添加提醒的文字
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width - 40, 50)];
    tipLabel.numberOfLines = 0;
    tipLabel.lineBreakMode = NSLineBreakByWordWrapping;
    NSAttributedString * attribute = [[NSAttributedString alloc] initWithString:@"300" attributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]}];
    NSAttributedString * attribute2 = [[NSAttributedString alloc] initWithString:@"900" attributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]}];
    NSMutableAttributedString *mutableAtt = [[NSMutableAttributedString alloc] initWithString:@"对一辆车状况进行综合评估的分值，评分范围从"];
    [mutableAtt appendAttributedString:attribute];
    [mutableAtt appendAttributedString:[[NSAttributedString alloc] initWithString:@"到"]];
    [mutableAtt appendAttributedString:attribute2];
    [mutableAtt appendAttributedString:[[NSAttributedString alloc] initWithString:@"，分值越高代表车辆越好。"]];
    tipLabel.attributedText = mutableAtt;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.yq_safeAreaLayoutGuideLeft).offset(60);
        make.right.equalTo(self.yq_safeAreaLayoutGuideRight).offset(-60);
        make.height.mas_greaterThanOrEqualTo(21);
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
    }];
    int count = 4;
    UIImageView *nextImage = nil;
    for (int i = 0 ; i < count; i++) {
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stars"]];
        image.frame = CGRectMake((SCRW - (image.width*count+8*(count - 1)))*0.5 + (image.width+8)*i, self.height - 40, image.width, image.height);
        [self addSubview:image];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            if (nextImage) {
                make.left.equalTo(nextImage.mas_right).offset(8);
            }else {
                make.centerX.equalTo(self.mas_centerX).with.offset(-((21*count+8*(count - 1)) - 21)*0.5);
            }
            make.width.mas_equalTo(21);
            make.height.mas_equalTo(21);
            make.top.equalTo(tipLabel.mas_bottom).offset(20);
        }];
        nextImage = image;
    }
    [nextImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.yq_safeAreaLayoutGuideBottom).offset(-30);
    }];
}
- (UIView *)baseView {
    if (_baseView == nil) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.width - 20, self.height - 10)];
        view.backgroundColor = [UIColor whiteColor];
        view.userInteractionEnabled = true;
        _baseView = view;
    }
    return _baseView;
}
- (UIView *)baseRoundView {
    if (_baseRoundView == nil) {
        UIView *baseRoundView = [[UIView alloc] initWithFrame:CGRectMake((self.baseView.width-150)*0.5, (self.baseView.height - 150*1.5)*0.5, 150, 150)];
        baseRoundView.backgroundColor = KCarSeriouslyMainColor;
        baseRoundView.layer.cornerRadius = baseRoundView.width*0.5;
        _baseRoundView = baseRoundView;
    }
    return _baseRoundView;
}
- (UILabel *)fractionLabel {
    if (_fractionLabel == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 75, 75)];
        label.text = @"800分";
        label.font = [UIFont systemFontOfSize:32];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.adjustsFontSizeToFitWidth = true;//自动变化数字font适应label宽度,全部显示text为止
        _fractionLabel = label;
    }
    return _fractionLabel;
}

- (CAShapeLayer *)cornlayer {
    if (_cornlayer == nil) {
        //圆环的图层
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.lineWidth = 25;
        //渐变色图层
        //线的边缘是圆的
        //    layer.lineCap = kCALineCapRound;
        layer.strokeColor = COLOR_RGB(54, 234, 100).CGColor;
        layer.fillColor = [UIColor clearColor].CGColor;
        CGFloat radius = self.baseRoundView.width*0.5 + 25*0.5;
        //按顺时针
        BOOL clockwise = true;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.baseRoundView.centerX, self.baseRoundView.centerY) radius:radius startAngle:(1.5*M_PI) endAngle:self.fraction/900.0*3.5*M_PI clockwise:clockwise];
        
        layer.path = [path CGPath];
        
        //给图层添加基础动画
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        //持续时间
        animation.duration = animTime;
        animation.fromValue = @(0);
        animation.toValue = @(1);
        //保存动画结束时的状态，默认为false
        animation.removedOnCompletion = false;
        animation.fillMode = kCAFillModeForwards;
        
        [layer addAnimation:animation forKey:@"test"];
        
        
        _cornlayer = layer;
        
    }
    return _cornlayer;
}

@end
