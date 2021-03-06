//
//  RefreshVC.m
//  2018TestDemo
//
//  Created by zp on 2018/7/3.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "RefreshVC.h"
#import "KeyBoardVC.h"

#define headHeight 200
#define headSectionHeight 40

@interface RefreshVC ()<UITableViewDelegate, UITableViewDataSource>
{
    UIView *headView;
    UIView *headSectionView;
}
@property (strong , nonatomic) UITableView *PowerStationListTable;


@end

@implementation RefreshVC
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
        //_PowerStationListTable.separatorStyle = UITableViewCellEditingStyleNone;
        
        _PowerStationListTable.contentInset = UIEdgeInsetsMake(headHeight+headSectionHeight, 0, 0, 0);
        _PowerStationListTable.contentOffset = CGPointMake(0, -headHeight-headSectionHeight);
        
        // 默认的下拉刷新和上拉加载
        //设置回调（一旦进入刷新状态，然后调用目标的动作，即调用[self loadNewData]）
        _PowerStationListTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self  refreshingAction:@selector(loadPowerStationData)];
        
    }
    return _PowerStationListTable;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    //[self.navigationController.navigationBar lt_reset];
    //self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x1f93ff);
    //[self.navigationController.navigationBar lt_setBackgroundColor:[UIColor redColor]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setNavBarBgColor:[UIColor blueColor]];//颜色
    //[self.navigationController.navigationBar navBarAlpha:1.0];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor yellowColor];
    
    
    [self.view addSubview:self.PowerStationListTable];
    [self.PowerStationListTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(NavTopHeight);
        make.bottom.offset(0);
        make.left.offset(0);
        make.right.offset(0);
    }];
    
    
    
    headView=[[UIView alloc] init];
    headView.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(NavTopHeight);
        make.left.right.offset(0);
        make.height.mas_equalTo(headHeight);
    }];
    
    
    headSectionView=[[UIView alloc] init];
    headSectionView.backgroundColor=[UIColor redColor];
    [self.view addSubview:headSectionView];
    [headSectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->headView.mas_bottom).offset(0);
        make.left.right.offset(0);
        make.height.mas_equalTo(headSectionHeight);
    }];
    
//    UIView *redImage=[[UIView alloc] initWithFrame:CGRectMake(0, -200, FrameW, 200)];
//    redImage.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
//    [self.PowerStationListTable addSubview:redImage];
//     self.PowerStationListTable.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    offsetY += headHeight+headSectionHeight;//减去内边距
    
    if (offsetY >= headHeight)
    {
        //偏移量
        self.PowerStationListTable.contentInset = UIEdgeInsetsMake(headSectionHeight, 0, 0, 0);
        [headView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.offset(NavTopHeight-headHeight);
        }];
    }else if (offsetY > 0 && offsetY <headHeight)
    {
        //偏移量
        self.PowerStationListTable.contentInset = UIEdgeInsetsMake(headHeight+headSectionHeight, 0, 0, 0);
        [headView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.offset(NavTopHeight-offsetY);
        }];

    }else
    {
        [headView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.offset(NavTopHeight);
        }];
    }
    
    NSLog(@"%f",offsetY);
}



- (void)loadPowerStationData
{
    [self.PowerStationListTable.mj_header endRefreshing];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"powerListCell" forIndexPath:indexPath];
    
    cell.backgroundColor=[UIColor lightGrayColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.definesPresentationContext=YES;
    
    KeyBoardVC *vc=[[KeyBoardVC alloc] init];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    //vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    //  添加动作
    [self presentViewController:vc animated:NO completion:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
