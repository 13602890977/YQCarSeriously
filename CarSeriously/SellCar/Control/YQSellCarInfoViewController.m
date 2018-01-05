//
//  YQSellCarInfoViewController.m
//  CarSeriously
//
//  Created by apple on 2018/1/3.
//  Copyright © 2018年 yuanqiao. All rights reserved.
//

#import "YQSellCarInfoViewController.h"
#import "YQSellCarInfoCell.h"
#import "YQSellCarInfoModel.h"
@interface YQSellCarInfoViewController ()

@property(nonatomic,strong)NSMutableArray<YQSellCarInfoModel *> *dataArr;
@end

@implementation YQSellCarInfoViewController

- (instancetype)init {
    return [self initWithStyle:UITableViewStylePlain];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"预留信息";
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 40)];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.contentSize.width, 200)];
    footerView.userInteractionEnabled = true;
    self.tableView.tableFooterView = footerView;
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.backgroundColor = KCarSeriouslyMainColor;
    [submitBtn setTitle:@"确定提交" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.left.equalTo(footerView.yq_safeAreaLayoutGuideLeft).offset(20);
        make.right.equalTo(footerView.yq_safeAreaLayoutGuideRight).offset(-20);
        make.top.mas_equalTo(50);
    }];
}
- (void)submitBtnClick:(UIButton *)button {
    NSLog(@"提交用户信息");
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YQSellCarInfoCell *cell = [YQSellCarInfoCell sellCarCellWithTableView:tableView];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (NSMutableArray<YQSellCarInfoModel *> *)dataArr {
    if (_dataArr == nil) {
        YQSellCarInfoModel *nameModel = [[YQSellCarInfoModel alloc] init];
        nameModel.titleStr = @"姓名:";
        nameModel.placeholderStr = @"请输入您的姓名";
        nameModel.keyBoardType = UIKeyboardTypeDefault;
        
        YQSellCarInfoModel *carModel = [[YQSellCarInfoModel alloc] init];
        carModel.titleStr = @"车型:";
        carModel.placeholderStr = @"请选择您的车型";
        
        YQSellCarInfoModel *carNumModel = [[YQSellCarInfoModel alloc] init];
        carNumModel.titleStr = @"车牌号:";
        carNumModel.placeholderStr = @"请输入车牌号";
        
        
        YQSellCarInfoModel *priceModel = [[YQSellCarInfoModel alloc] init];
        priceModel.titleStr = @"理想价格:";
        priceModel.placeholderStr = @"请输入您的理想价格(单位万)";
        priceModel.keyBoardType = UIKeyboardTypeNumberPad;
        
        YQSellCarInfoModel *phoneModel = [[YQSellCarInfoModel alloc] init];
        phoneModel.titleStr = @"联系电话:";
        phoneModel.placeholderStr = @"请输入您的联系电话";
        phoneModel.keyBoardType = UIKeyboardTypePhonePad;
        _dataArr = [NSMutableArray arrayWithObjects:nameModel,carModel,carNumModel,priceModel,phoneModel, nil];
    }
    return _dataArr;
}
@end
