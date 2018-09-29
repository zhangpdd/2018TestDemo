//
//  DynamicVC.m
//  2018TestDemo
//
//  Created by zp on 2018/5/21.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "DynamicVC.h"
#import "DynamicSectionHeadView.h"
#import "DynamicSectionFootView.h"
#import "DynamicLikeCell.h"
#import "DynamicCommentCell.h"
#import "YYFPSLabel.h"
#import "DynamicModel.h"
#import "CommentModel.h"
#import "DynamicFrameModel.h"

@interface DynamicVC ()<UITableViewDelegate, UITableViewDataSource>

/**
 动态列表
 */
@property (strong, nonatomic) UITableView *DynamicTable;

/**
 动态数组
 */
@property (strong, nonatomic) NSMutableArray *DynamicArr;

/**
 动态缓存数组
 */
@property (strong, nonatomic) NSArray *DynamicCacheArr;

/**
 页码
 */
@property (assign , nonatomic) int DynamicPage;


@end

@implementation DynamicVC

-(NSMutableArray *)DynamicArr
{
    if (_DynamicArr == nil) {
        _DynamicArr = [NSMutableArray array];
    }
    return _DynamicArr;
}
-(NSArray *)DynamicCacheArr
{
    if (_DynamicCacheArr == nil) {
        _DynamicCacheArr = [NSArray array];
    }
    return _DynamicCacheArr;
}
-(UITableView *)DynamicTable
{
    if (_DynamicTable == nil) {
        _DynamicTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _DynamicTable.delegate=self;
        _DynamicTable.dataSource=self;
        [_DynamicTable registerClass:[DynamicCommentCell class] forCellReuseIdentifier:@"commentCell"];
        
        [_DynamicTable registerClass:[DynamicSectionHeadView class] forHeaderFooterViewReuseIdentifier:@"headView"];
        [_DynamicTable registerClass:[DynamicSectionFootView class] forHeaderFooterViewReuseIdentifier:@"footView"];
        
        _DynamicTable.tableFooterView=[[UIView alloc]init];
        _DynamicTable.backgroundColor=[UIColor whiteColor];
        
        _DynamicTable.estimatedRowHeight = 0;
        _DynamicTable.estimatedSectionHeaderHeight = 100;
        _DynamicTable.estimatedSectionFooterHeight = 10;
        //分割线消失
        _DynamicTable.separatorStyle = UITableViewCellEditingStyleNone;
        
        //加载动态列表
        [self.view addSubview:_DynamicTable];
        [_DynamicTable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(5);
            make.left.right.bottom.offset(0);
            make.bottom.offset(0);
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
    
    self.view.backgroundColor = [UIColor cyanColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[YYFPSLabel alloc]initWithFrame:CGRectMake(0, 5, 60, 30)]];
    

    [self loadDynamics];
    
    
}

- (void)loadDynamics
{
    [self.DynamicArr removeAllObjects];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

       
            [self.DynamicArr addObjectsFromArray:[[DynamicFrameModel new] loadDatas]];

        dispatch_async(dispatch_get_main_queue(), ^{

            [self.DynamicTable reloadData];
            [self.DynamicTable.mj_header endRefreshing];
        });
    });
    
}

- (void)loadDynamicsMore
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self.DynamicArr addObjectsFromArray:[[DynamicFrameModel new] loadDatas]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.DynamicTable reloadData];
            [self.DynamicTable.mj_footer endRefreshing];
        });
    });
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.DynamicArr.count;
}

/**
 cell数量
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //DynamicFrameModel *frameModel = self.DynamicArr[section];
    
    return 0;//frameModel.model.commentMessages.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.DynamicArr.count != 0)
    {
        
        DynamicFrameModel *frameModel = self.DynamicArr[section];
        
        if (frameModel.HeadViewHeight != 0)
        {
            return frameModel.HeadViewHeight;
        }else
        {
            DynamicFrameModel *frameModel = self.DynamicArr[section];
            
            return frameModel.HeadViewHeight;
        };
    }else
        return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DynamicSectionHeadView *headview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headView"];
    
    if (self.DynamicArr.count != 0)
    {
        DynamicFrameModel *frameModel =  self.DynamicArr[section];
        
        headview.model = frameModel.model;
    }
    
    __weak __typeof(self) weakself = self;
    headview.tapImageBlock = ^(NSInteger index) {
        
        [weakself.view makeToast:[NSString stringWithFormat:@"点击了图片%ld",index] duration:1.0 position:CSToastPositionCenter];
    };
    
    headview.praiseBlock = ^{
        
        [weakself.view makeToast:[NSString stringWithFormat:@"点赞第%ld行",section] duration:1.0 position:CSToastPositionCenter];
    };
    
    headview.commentBlock = ^{
        
        [weakself.view makeToast:[NSString stringWithFormat:@"评论第%ld行",section] duration:1.0 position:CSToastPositionCenter];
    };
    
    return headview;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    DynamicSectionFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footView"];
    
    return footView;
}

/**
 cell高度
 
 
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DynamicFrameModel *frameModel =  self.DynamicArr[indexPath.section];
    
    return [frameModel.cellHeightArr[indexPath.row] doubleValue];
    
    
}



/**
 cell初始化

 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DynamicCommentCell *cell=[tableView dequeueReusableCellWithIdentifier:@"commentCell" forIndexPath:indexPath];

    DynamicFrameModel *frameModel =  self.DynamicArr[indexPath.section];
    
    
    cell.model = frameModel.model.commentMessages[indexPath.row];

    
    return cell;
}

/**
 点赞或取消
 
 @param praise 将要的操作
 */
-(void)PraiseItem:(NSInteger )row WithState:(BOOL)praise
{
    
}


// 开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
