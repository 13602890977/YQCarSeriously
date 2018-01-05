//
//  YQHomeCell.m
//  CarSeriously
//
//  Created by apple on 2017/12/26.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQHomeCell.h"

#import "YQHomeVINView.h"

@interface YQHomeCell()<YQHomeVINViewDelegate>

@property(nonatomic,strong)YQHomeVINView *vinView;

@property(nonatomic,strong)UIView *baseView;

@end
@implementation YQHomeCell


+ (instancetype)homeCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"homeCellIdentifier";
    
    YQHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    cell.backgroundColor = COLOR_RGB(230, 230, 230);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.contentView addSubview:cell.vinView];
    [cell.vinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.contentView.yq_safeAreaLayoutGuideTop);
        make.left.equalTo(cell.contentView.yq_safeAreaLayoutGuideLeft).offset(10);
        make.right.equalTo(cell.contentView.yq_safeAreaLayoutGuideRight).offset(-10);
        make.bottom.equalTo(cell.contentView.yq_safeAreaLayoutGuideBottom).offset(-10);
    }];
    return cell;
}
- (void)queryBtnClick:(YQHomeVINView *)vinView {
    NSLog(@"点击了立即查询");
    if ([_delegate respondsToSelector:@selector(homeQueryVinCellSelector:)]) {
        [self.delegate homeQueryVinCellSelector:self];
    }
}
- (YQHomeVINView *)vinView {
    if (_vinView == nil) {
        YQHomeVINView *vinView = [[YQHomeVINView alloc] initWithFrame:CGRectMake(0, 0, SCRW-32, 200)];
        vinView.userInteractionEnabled = true;
        vinView.delegate = self;
        _vinView = vinView;
    }
    return _vinView;
}

@end
