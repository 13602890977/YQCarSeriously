//
//  YQPersonalCell.m
//  CarSeriously
//
//  Created by apple on 2017/12/20.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQPersonalCell.h"
#import "YQPersonalCellArrowItem.h"
#import "YQPersonalHeaderCellItem.h"

@interface YQPersonalCell()

@property(nonatomic,strong)UIImageView *arrowView;
@end

@implementation YQPersonalCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setItem:(YQPersonalCellItem *)item {
    _item = item;
    
    self.textLabel.text = item.title;
    self.imageView.image = item.image;
    self.detailTextLabel.text = item.detailTitle;
   
    
    if ([item isKindOfClass:[YQPersonalCellArrowItem class]]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.accessoryView = nil;
        self.backgroundColor = [UIColor whiteColor];
    }else if ([item isKindOfClass:[YQPersonalHeaderCellItem class]]) {
        self.textLabel.font = [UIFont systemFontOfSize:18];
        self.detailTextLabel.font = [UIFont systemFontOfSize:18];
        self.textLabel.textColor = [UIColor whiteColor];
        self.detailTextLabel.textColor = [UIColor whiteColor];
        self.backgroundColor = KCarSeriouslyMainColor;
        
        self.accessoryView = self.arrowView;
        //取消点击效果
        self.selectionStyle = UITableViewCellEditingStyleNone;
    }else {
        self.backgroundColor = [UIColor whiteColor];
        self.accessoryView = nil;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView cellStyle:(UITableViewCellStyle)cellStyle {
    
    static NSString *cellID = @"cellId";
    
    YQPersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[YQPersonalCell alloc] initWithStyle:cellStyle reuseIdentifier:cellID];
    }
    
    return cell;
}

- (UIImageView *)arrowView {
    if (_arrowView == nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow-icon2"]];
        _arrowView = imageView;
    }
    return _arrowView;
}

@end
