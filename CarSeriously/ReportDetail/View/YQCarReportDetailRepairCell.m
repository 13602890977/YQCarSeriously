//
//  YQCarReportDetailRepairCell.m
//  CarSeriously
//
//  Created by apple on 2018/1/5.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//

#import "YQCarReportDetailRepairCell.h"

@interface YQCarReportDetailRepairCell()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *mileageLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *stuffLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;


@end

@implementation YQCarReportDetailRepairCell


- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setLabelStrArr:(NSArray *)labelStrArr {
    _labelStrArr = labelStrArr;
    self.timeLabel.text = labelStrArr[0];
    self.mileageLabel.text = labelStrArr[1];
    self.titleLabel.text = labelStrArr[2];
    self.detailTitleLabel.text = labelStrArr[3];
    self.stuffLabel.text = labelStrArr[4];
    self.noteLabel.text = labelStrArr[5];
}
+ (instancetype)repairCellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"carReportDetailRepairCellIdentifier";
    YQCarReportDetailRepairCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = (YQCarReportDetailRepairCell *)[[[NSBundle mainBundle] loadNibNamed:@"YQCarReportDetailRepairCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

@end
