//
//  YQQACellCell.m
//  CarSeriously
//
//  Created by apple on 2017/12/27.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQQACellCell.h"

#import "YQHomeQAModel.h"

@interface YQQACellCell()

@property(nonatomic,strong) UIImageView *problemImageView;
@property(nonatomic,strong) UILabel *problemLabel;

@property(nonatomic,strong) UIImageView *answerImageView;
@property(nonatomic,strong) UILabel *answerLabel;

@end

@implementation YQQACellCell

+ (instancetype)qaCellCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"qaCellCellIdentifier";
    
    YQQACellCell *cell = (YQQACellCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.problemImageView];
        [self.contentView addSubview:self.problemLabel];
        [self.contentView addSubview:self.answerImageView];
        [self.contentView addSubview:self.answerLabel];
        
    }
    return self;
}
- (void)setItem:(YQQACellItem *)item {
    _item = item;
    NSLog(@"%f",item.problemHeight);
    self.problemLabel.text = item.qu;
    
    self.answerLabel.text = item.ass;
    
    //设置约束
    [self.problemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(KHomeALabelTop15);
        make.width.height.mas_equalTo(KHomeQAIconHeight32);
    }];
    
    [self.problemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(KHomeALabelTop15);
        make.left.equalTo(self.problemImageView.mas_right).offset(KHomeALabelBottom10);
        make.right.equalTo(self.contentView).offset(-KHomeALabelBottom10);
        make.height.mas_equalTo(item.problemHeight);
    }];
    [self.answerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (item.problemHeight > KHomeQAIconHeight32) {
            make.top.equalTo(self.problemLabel.mas_bottom).offset(KHomeALabelBottom10);
        }else {
            make.top.equalTo(self.problemImageView.mas_bottom).offset(KHomeQLabelTop20);
        }
        make.height.width.mas_equalTo(KHomeQAIconHeight32);
        make.left.equalTo(self.contentView).offset(KHomeALabelTop15);
    }];
    [self.answerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (item.answerHeight > KHomeQAIconHeight32) {
            make.top.equalTo(self.problemLabel.mas_bottom).offset(KHomeALabelTop15);
        }else {
            make.top.equalTo(self.problemImageView.mas_bottom).offset(KHomeCellFloat25);
        }
        make.left.equalTo(self.problemImageView.mas_right).offset(KHomeALabelBottom10);
        make.right.equalTo(self.contentView).offset(-KHomeALabelBottom10);
        make.height.mas_equalTo(item.answerHeight);//初始为32更新
    }];
}
#pragma mark - lazy load
- (UIImageView *)problemImageView {
    if (!_problemImageView) {
        _problemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, KHomeQAIconHeight32, KHomeQAIconHeight32)];
        _problemImageView.image = [UIImage imageNamed:@"problem"];
    }
    return _problemImageView;
}
- (UILabel *)problemLabel {
    if (!_problemLabel) {
        _problemLabel = [[UILabel alloc] initWithFrame:CGRectMake(_problemImageView.maxX + 10, _problemImageView.y + 1, SCRW - _problemImageView.maxX - 20, 21)];
        _problemLabel.numberOfLines = 0;
        self.problemLabel.font = [UIFont systemFontOfSize:16];
    }
    return _problemLabel;
}

- (UIImageView *)answerImageView {
    if (!_answerImageView) {
        _answerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, _problemLabel.maxY + 10, KHomeQAIconHeight32, KHomeQAIconHeight32)];
        _answerImageView.image = [UIImage imageNamed:@"answer"];
    }
    return _answerImageView;
}
- (UILabel *)answerLabel {
    if (!_answerLabel) {
        
        _answerLabel = [[UILabel alloc] initWithFrame:CGRectMake(_answerImageView.maxX + 10, _problemLabel.maxY , SCRW - _answerImageView.maxX - 20, 21)];
         self.answerLabel.font = [UIFont systemFontOfSize:16];
        _answerLabel.numberOfLines = 0;
    }
    return _answerLabel;
}


@end
