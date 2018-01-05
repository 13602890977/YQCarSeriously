//
//  YQHomeHeaderView.m
//  CarSeriously
//
//  Created by apple on 2017/12/26.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQHomeHeaderView.h"



@interface YQHomeHeaderView()<UIScrollViewDelegate>


@property(nonatomic,strong)UIScrollView *adsScrollView;
@property(nonatomic,strong)UIPageControl *adsPage;

@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,strong)UIImageView *currentImageView;
@property(nonatomic,strong)UIImageView *rightImageView;
@property(nonatomic,strong)UIImageView *leftImageView;

@property(nonatomic,assign)int currentImageIndex;
@end

@implementation YQHomeHeaderView

- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;

    [self repeatsScrollView:dataArr];
 
    
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 repeats:true block:^(NSTimer * _Nonnull timer) {
        
        [weakSelf.adsScrollView setContentOffset:CGPointMake(weakSelf.adsScrollView.width*2, 0) animated:true];

    }];
}
- (void)repeatsScrollView:(NSArray *)dataArr {
    _adsPage.numberOfPages = dataArr.count;//总的数量
    
    [self.adsPage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.adsPage.numberOfPages*20);
    }];
    //scrollview里放个View
    UIView *container = [[UIView alloc] init];
    [self.adsScrollView addSubview:container];
    container.userInteractionEnabled = true;
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.adsScrollView);
        make.height.mas_equalTo(self.adsScrollView.height);
    }];
    
    [container addSubview:self.leftImageView];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(container);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(container);
        
        make.left.mas_equalTo(container.mas_left);
        
    }];
    
    [container addSubview:self.currentImageView];
    
    [self.currentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(container);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(container);
        
        make.left.mas_equalTo(self.leftImageView.mas_right);
        
    }];
    [container addSubview:self.rightImageView];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(container);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(container);
        make.left.mas_equalTo(self.currentImageView.mas_right);
        
    }];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightImageView.mas_right);
    }];
    
    //将视图放于中间
    [self.adsScrollView setContentOffset:CGPointMake(self.adsScrollView.width, 0) animated:false];
    
    [self setDefaultImage];
    
}
- (void)setDefaultImage {
    //加载默认图片
    _leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.dataArr[self.dataArr.count - 1]]];
    _currentImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.dataArr[0]]];
    _rightImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.dataArr[1]]];
    
    _currentImageIndex = 0;
    self.adsPage.currentPage = _currentImageIndex;
    
}

- (void)containerScrollView:(NSArray *)dataArr {
    _adsPage.numberOfPages = dataArr.count;//总的数量
    
    [self.adsPage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.adsPage.numberOfPages*20);
    }];
    //scrollview里放个View
    UIView *container = [[UIView alloc] init];
    [self.adsScrollView addSubview:container];
    container.userInteractionEnabled = true;
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.adsScrollView);
        make.height.equalTo(self.adsScrollView);
    }];
    
    
    UIView *lastView = nil;
    for (int i = 0; i<dataArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width * i, 0, self.width, self.height)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        //        UIImage *image = [self imageCompressWithSimple:[UIImage imageNamed:dataArr[i]] scaledToSize:CGSizeMake(SCRW, 200)];
        imageView.image = [UIImage imageNamed:dataArr[i]];
        imageView.backgroundColor = COLOR_RGB(230,230,230);
        
        [container addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(container);
            make.width.mas_equalTo(self.mas_width);
            make.height.mas_equalTo(container);
            if (lastView) {
                make.left.mas_equalTo(lastView.mas_right);
                
            }else {
                make.left.mas_equalTo(container.mas_left);
            }
        }];
        
        lastView = imageView;
    }
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastView.mas_right);
    }];
    
    //将视图放于中间
    [self.adsScrollView setContentOffset:CGPointMake(self.adsScrollView.width, 0) animated:false];
}

//缩放到指定大小
- (UIImage*)imageCompressWithSimple:(UIImage*)image scaledToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.adsScrollView];
        [self.adsScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];

        [self addSubview:self.adsPage];
        [self.adsPage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.width.mas_equalTo(self.adsPage.numberOfPages * 20);
            make.height.mas_equalTo(20);
            make.centerX.equalTo(self);
        }];
    }
    return self;
}

#pragma mark - scrollview delegate
//开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //暂停计时器操作，从这个时间开始，到某个时刻[NSDate distantFuture]
    [self.timer setFireDate:[NSDate distantFuture]];
}
//拖动结束
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //开始计时器操作，从1.5秒后开始
    [self.timer setFireDate:[NSDate dateWithTimeInterval:1.5 sinceDate:[NSDate date]]];
    
}
//动画结束，注意手动时需要动画就会就调用这个方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    [self reloadImage];
    [self.adsScrollView setContentOffset:CGPointMake(self.adsScrollView.width, 0) animated:false];
    _adsPage.currentPage = _currentImageIndex;
    
}
//滚动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    //重新载入图片
    [self reloadImage];
    [self.adsScrollView setContentOffset:CGPointMake(self.adsScrollView.width, 0) animated:false];
    _adsPage.currentPage = _currentImageIndex;
}
- (void)reloadImage {
    
    int leftImageIndex,rightImageIndex;
    int imageCount = (int)self.dataArr.count;
    CGPoint offset = [self.adsScrollView contentOffset];
    if (offset.x > self.adsScrollView.width) { //向右滑动
        _currentImageIndex = (_currentImageIndex + 1) % imageCount;
    }else if(offset.x < self.adsScrollView.width){ //向左滑动
        _currentImageIndex = (_currentImageIndex + imageCount - 1) % imageCount;
    }
    _currentImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.dataArr[_currentImageIndex]]];
    
    //重新设置左右图片
    leftImageIndex = (_currentImageIndex + imageCount - 1) % imageCount;
    rightImageIndex = (_currentImageIndex + 1) % imageCount;
    _leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.dataArr[leftImageIndex]]];
    _rightImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.dataArr[rightImageIndex]]];
}
#pragma mark - lazy load
- (UIScrollView *)adsScrollView{
    if (!_adsScrollView) {
        _adsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCRW, 200)];
        _adsScrollView.backgroundColor = COLOR_RGB(230, 230, 230);
        _adsScrollView.delegate = self;
        _adsScrollView.pagingEnabled = true;
        
        _adsScrollView.showsHorizontalScrollIndicator = false;
    }
    return _adsScrollView;
}

- (UIPageControl *)adsPage{
    if (!_adsPage) {
        _adsPage = [[UIPageControl alloc] initWithFrame:CGRectMake((self.width - 60)*0.5, _adsScrollView.maxY - 30, 60, 20)];
        
        _adsPage.currentPage = 0;//当前位置
        _adsPage.enabled = false;
//        [_adsPage addTarget:self action:@selector(pageChangeCount:) forControlEvents:UIControlEventValueChanged];
        [_adsPage setCurrentPageIndicatorTintColor:KCarSeriouslyMainColor];
        _adsPage.pageIndicatorTintColor = [UIColor grayColor];
        
    }
    return _adsPage;
}
- (UIImageView *)leftImageView {
    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _leftImageView;
}
- (UIImageView *)currentImageView {
    if (_currentImageView == nil) {
        _currentImageView = [[UIImageView alloc] init];
        _currentImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _currentImageView;
}
- (UIImageView *)rightImageView {
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _rightImageView;
}
//view 消失时会调用这个方法 在这里处理NSTimer
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    [self.timer invalidate];
    self.timer = nil;
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
