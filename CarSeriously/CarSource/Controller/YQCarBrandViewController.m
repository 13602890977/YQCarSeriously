//
//  YQCarBrandViewController.m
//  CarSeriously
//
//  Created by apple on 2017/12/29.
//  Copyright © 2017年 yuanqiao. All rights reserved.
//

#import "YQCarBrandViewController.h"

@interface YQCarBrandViewController ()

@property(nonatomic,strong)NSArray<NSDictionary *> *dataArr;
@end

@implementation YQCarBrandViewController

- (instancetype)init {
    return [super initWithStyle:UITableViewStylePlain];
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    [[YQSessionTool shareTool] getDataWithUrl:@"http://59.41.39.55:9090/plugins/changhui/port/getBrand?requestCode=001004" resultBlock:^(NSDictionary * _Nullable dictData, NSString * _Nullable message) {
        
        NSArray *dataArr = [dictData objectForKey:@"responseData"];
        
        dispatch_apply(dataArr.count, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
            
        });
    }];
     
}

- (NSArray<NSDictionary *> *)dataArr {
    if (_dataArr == nil) {
        //解析汽车品牌plist
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cars.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        if (arr != nil) {
            _dataArr = arr;
        }else{
            _dataArr = [NSArray array];
        }
        
    }
    return _dataArr;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.dataArr[section] objectForKey:@"title"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)[self.dataArr[section] objectForKey:@"cars"]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"carBrandCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = ((NSArray *)[self.dataArr[indexPath.section] objectForKey:@"cars"])[indexPath.row][@"name"];
    return cell;
}
@end
