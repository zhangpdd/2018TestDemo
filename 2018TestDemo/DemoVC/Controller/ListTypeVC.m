//
//  ListTypeVC.m
//  2018TestDemo
//
//  Created by zp on 2018/5/17.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "ListTypeVC.h"
#import "NoDataView.h"

#import "HttpRequestTool.h"

@interface ListTypeVC ()<UITableViewDelegate, UITableViewDataSource>

@property (strong , nonatomic) UITableView *PowerStationListTable;

/**
 电站数组
 */
@property (strong, nonatomic) NSMutableArray *powerStationArr;


@end

@implementation ListTypeVC

/**
 电站数组懒加载
 
 @return mallArr
 */
-(NSMutableArray *)powerStationArr
{
    if (_powerStationArr == nil) {
        _powerStationArr = [NSMutableArray array];
    }
    return _powerStationArr;
}

/**
 电站列表懒加载
 
 @return return value description
 */
-(UITableView *)PowerStationListTable
{
    if (_PowerStationListTable == nil) {
        _PowerStationListTable = [[UITableView alloc]init];
        
        _PowerStationListTable.delegate=self;
        _PowerStationListTable.dataSource=self;
        [_PowerStationListTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"powerListCell"];
        _PowerStationListTable.tableFooterView=[[UIView alloc]init];
        _PowerStationListTable.backgroundColor=[UIColor clearColor];
        
        //分割线消失
        _PowerStationListTable.separatorStyle = UITableViewCellEditingStyleNone;
        
        // 默认的下拉刷新和上拉加载
        //设置回调（一旦进入刷新状态，然后调用目标的动作，即调用[self loadNewData]）
        _PowerStationListTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self  refreshingAction:@selector(loadPowerStationData)];
        
        
        
    }
    return _PowerStationListTable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.view.backgroundColor=[UIColor yellowColor];
    
    
   
    
    
//    HttpRequestTool *http=[[HttpRequestTool alloc] init];
//    
//    [http GET:nil parameters:nil progress:^(float progress) {
//        
//    } succeed:^(id data) {
//        
//    } failure:^(NSError *error) {
//        
//    }];
    
    
    
    [self.view addSubview:self.PowerStationListTable];
    [self.PowerStationListTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(ScaleHeight * 30);
        make.bottom.offset(0);
        make.left.offset(0);
        make.right.offset(0);
    }];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem rightItemWithTitle:@"断网" target:self action:@selector(rightAction)];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem leftItemWithTitle:@"快来连网" target:self action:@selector(rightAction)];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"dc_btn_back" highIcon:@"dc_btn_back" target:self action:@selector(rightAction)];
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"dc_btn_back" highIcon:@"dc_btn_back" target:self action:@selector(rightAction)];
    
    
}

- (void)rightAction
{
    __weak __typeof(self) weakself = self;
    
    [self.PowerStationListTable configBlankPage:BlankPageViewTypeNoData hasData:self.powerStationArr.count>0 hasError:YES reloadButtonBlock:^(id sender) {
        
        [weakself.PowerStationListTable.mj_header beginRefreshing];
        
    }];
    
}

- (void)loadPowerStationData
{
    [self.PowerStationListTable.mj_header endRefreshing];
    __weak __typeof(self) weakself = self;
    
    [self.PowerStationListTable configBlankPage:BlankPageViewTypeNoData hasData:self.powerStationArr.count hasError:self.powerStationArr.count > 0 reloadButtonBlock:^(id sender) {
        
        
        
        [weakself.PowerStationListTable.mj_header beginRefreshing];
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.powerStationArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleHeight * 245;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"powerListCell" forIndexPath:indexPath];
    
    cell.backgroundColor=[UIColor redColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    if (self.powerStationArr.count != 0)
    {
        
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
