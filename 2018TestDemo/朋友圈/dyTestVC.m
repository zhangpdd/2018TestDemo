//
//  dyTestVC.m
//  2018TestDemo
//
//  Created by zp on 2018/6/8.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "dyTestVC.h"
#import "dySectionView.h"
#import "testHeadView.h"
#import "dyTableViewCell.h"
#import "YYFPSLabel.h"
#import "dyModel.h"

#import "dyFrameModel.h"
@interface dyTestVC ()<UITableViewDelegate, UITableViewDataSource>

/**
 动态列表
 */
@property (strong, nonatomic) UITableView *DynamicTable;

/**
 动态数组
 */
@property (strong, nonatomic) NSMutableArray *DynamicArr;

@property (assign , nonatomic) int numberpage;

@end

@implementation dyTestVC
-(NSMutableArray *)DynamicArr
{
    if (_DynamicArr == nil) {
        _DynamicArr = [NSMutableArray array];
    }
    return _DynamicArr;
}

-(UITableView *)DynamicTable
{
    if (_DynamicTable == nil) {
        _DynamicTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _DynamicTable.delegate=self;
        _DynamicTable.dataSource=self;
        
        
        [_DynamicTable registerClass:[testHeadView class] forHeaderFooterViewReuseIdentifier:@"headView"];
       
        [_DynamicTable registerClass:[dyTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        _DynamicTable.tableFooterView=[[UIView alloc]init];
        _DynamicTable.backgroundColor=[UIColor whiteColor];
        
        
        _DynamicTable.estimatedSectionHeaderHeight = 0;
        _DynamicTable.estimatedSectionFooterHeight = 0;
        //分割线消失
        _DynamicTable.separatorStyle = UITableViewCellEditingStyleNone;
        
        //加载动态列表
        [self.view addSubview:_DynamicTable];
        [_DynamicTable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(NavTopHeight+5);
            make.left.right.bottom.offset(0);
            make.bottom.offset(-5);
        }];
        // 默认的下拉刷新和上拉加载
        //设置回调（一旦进入刷新状态，然后调用目标的动作，即调用[self loadNewData]）
        _DynamicTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self  refreshingAction:@selector(loadDynamics)];
        
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
        _DynamicTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadDynamicsMore)];
    }
    return _DynamicTable;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[YYFPSLabel alloc]initWithFrame:CGRectMake(0, 5, 60, 30)]];
    
    
    self.DynamicTable.rowHeight = UITableViewAutomaticDimension;
    self.DynamicTable.estimatedRowHeight = 80;
    
    [self loadDynamics];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor= [UIColor redColor];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor= UIColorFromRGB(0x1f93ff);
}

- (void)loadDynamics
{
//    [self.DynamicArr removeAllObjects];
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//
//        [self.DynamicArr addObjectsFromArray:[[dyFrameModel new] loadDatas]];
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            [self.DynamicTable reloadData];
//            [self.DynamicTable.mj_header endRefreshing];
//        });
//    });
    
    self.numberpage=10;
    
    [self.DynamicTable reloadData];
    [self.DynamicTable.mj_header endRefreshing];
}

- (void)loadDynamicsMore
{
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//        [self.DynamicArr addObjectsFromArray:[[dyFrameModel new] loadDatas]];
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            [self.DynamicTable reloadData];
//            [self.DynamicTable.mj_footer endRefreshing];
//        });
//    });

    self.numberpage=self.numberpage+10;
    
    [self.DynamicTable reloadData];
    [self.DynamicTable.mj_footer endRefreshing];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.numberpage;//self.DynamicArr.count;
}

/**
 cell数量
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //DynamicFrameModel *frameModel = self.DynamicArr[section];
    
    return 3;//self.numberpage;//frameModel.model.commentMessages.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (self.DynamicArr.count != 0)
//    {
//
////        dyFrameModel *frameModel = self.DynamicArr[section];
////
////        if (frameModel.HeadViewHeight != 0)
////        {
////            return frameModel.HeadViewHeight;
////        }else
////        {
////            dyFrameModel *frameModel = self.DynamicArr[section];
////
////            return frameModel.HeadViewHeight;
////        };
//
//        return 80;
//
//    }else
//        return 80;
    
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //testHeadView *headview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headView"];
    
    //headview.backgroundColor=[UIColor redColor];
//    if (self.DynamicArr.count != 0)
//    {
//        dyFrameModel *frameModel =  self.DynamicArr[section];
//
//        headview.model = frameModel.model;
//    }
    
//    __weak __typeof(self) weakself = self;
//    headview.tapImageBlock = ^(NSInteger index) {
//
//        [weakself.view makeToast:[NSString stringWithFormat:@"点击了图片%ld",index] duration:1.0 position:CSToastPositionCenter];
//    };
//
    
    
    //return headview;
    return nil;
}



/**
 cell高度
 */
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    
//    return 80;
//    
//}



/**
 cell初始化
 
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    dyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    cell.contentView.backgroundColor=[UIColor cyanColor];
    
    [cell setUP];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
