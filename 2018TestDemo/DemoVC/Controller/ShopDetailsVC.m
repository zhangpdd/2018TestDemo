//
//  ShopDetailsVC.m
//  2018TestDemo
//
//  Created by zp on 2018/5/15.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "ShopDetailsVC.h"
#import "ShopDetailsNav.h"
#import <WebKit/WebKit.h>
@interface ShopDetailsVC()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
{
    UITableView *OneTable;
    UITableView *TwoTable;
    UIScrollView *mainScrollView;
    UIScrollView *OneScrollView ;
    UICollectionView *TwoCollectionView;
    WKWebView *webViewTwo;
}

@property (strong ,nonatomic) ShopDetailsNav *navTitleView;//导航栏

@end

@implementation ShopDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    __weak __typeof(self) weakself = self;
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.navTitleView = [[ShopDetailsNav alloc] initWithFrame:CGRectMake(0, 0, 150, 44*2)];
    
    self.navTitleView.segMentClick = ^(NSInteger index) {
        
        [weakself.navTitleView updateFrame:index];
        [OneScrollView setContentOffset:CGPointMake(FrameW*index, 0) animated:YES];
    };
    self.navigationItem.titleView = self.navTitleView;
    
    [self loadUI];
}

-(void)loadUI
{
    /** 底层view*/
    mainScrollView = [[UIScrollView alloc] init];
    mainScrollView.scrollEnabled = NO;
    mainScrollView.frame = CGRectMake(0, NavTopHeight, FrameW, FrameH - NavTopHeight);
    mainScrollView.contentSize = CGSizeMake(FrameW, FrameH*2 - NavTopHeight);
    mainScrollView.backgroundColor = [UIColor yellowColor];
    mainScrollView.pagingEnabled = YES;
    mainScrollView.bounces = YES;
    mainScrollView.delegate = self;
    [self.view addSubview:mainScrollView];
    
    /** 第一页面 scrollView*/
    
    OneScrollView = [[UIScrollView alloc] init];
    OneScrollView.frame = CGRectMake(0, 0, FrameW, FrameH-NavTopHeight);
    OneScrollView.contentSize = CGSizeMake(FrameW * 3, FrameH-NavTopHeight);
    OneScrollView.backgroundColor = [UIColor cyanColor];
    OneScrollView.pagingEnabled = YES;
    OneScrollView.bounces = NO;
    OneScrollView.delegate = self;
    
    [mainScrollView addSubview:OneScrollView];
    
    /** 第一页面 table*/
    TwoTable = [[UITableView alloc] init];
    TwoTable.frame = CGRectMake(FrameW*2, 0, FrameW, FrameH - NavTopHeight);
    TwoTable.separatorColor = [UIColor redColor];
    TwoTable.delegate = self;
    TwoTable.dataSource = self;
    [OneScrollView addSubview:TwoTable];
    
    /** 第一页面 UICollectionView*/
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    TwoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, FrameW, FrameH - NavTopHeight) collectionViewLayout:flow];
    TwoCollectionView.backgroundColor = [UIColor lightTextColor];
    TwoCollectionView.delegate = self;
    TwoCollectionView.dataSource = self;
    [OneScrollView addSubview:TwoCollectionView];
    
    [TwoCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Coll"];
    
    /** 第一页面wk*/
    WKWebView *webViewOne = [[WKWebView alloc] initWithFrame:CGRectMake(FrameW, 0, FrameW, FrameH - NavTopHeight)];
    
    [webViewOne loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    
    [OneScrollView addSubview:webViewOne];
    
    /** 第二页面wk*/
    webViewTwo = [[WKWebView alloc] initWithFrame:CGRectMake(0, FrameH, FrameW, FrameH - NavTopHeight)];
    
    [webViewTwo loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    
    [mainScrollView addSubview:webViewTwo];
    
    
    //设置UITableView 上拉加载
    MJRefreshAutoNormalFooter *fooer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(onFooter)];
    //[fooer setTitle:@"释放返回简介" forState:MJRefreshStatePulling];
    [fooer setTitle:@"上拉加载详情" forState:MJRefreshStateIdle];
    [fooer setTitle:@"加载中" forState:MJRefreshStateRefreshing];
    
    TwoCollectionView.mj_footer = fooer;
    
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(onHeader)];
    [header setTitle:@"释放返回简介" forState:MJRefreshStatePulling];
    [header setTitle:@"下拉返回简介" forState:MJRefreshStateIdle];
    [header setTitle:@"返回中" forState:MJRefreshStateRefreshing];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    webViewTwo.scrollView.mj_header = header;
    
    
    

}

- (void)onHeader
{
    [UIView animateWithDuration:1 animations:^{
        
        [mainScrollView setContentOffset:CGPointMake(0, 0)];
        
        [self.navTitleView updateFrame:4];
        
    }];
    //结束加载
    [webViewTwo.scrollView.mj_header endRefreshing];

}

- (void)onFooter
{
    //上拉，执行对应的操作---改变底层滚动视图的滚动到对应位置
    //设置动画效果
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        [mainScrollView setContentOffset:CGPointMake(0, FrameH)];
        [self.navTitleView updateFrame:3];
        
    } completion:^(BOOL finished) {
        
        
        //结束加载
        [TwoCollectionView.mj_footer endRefreshing];
    }];
}



//滚动试图停止的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    /*配对使用，滑动结束的时候，允许响应*/
    if (scrollView == OneScrollView)
    {
        int page = scrollView.contentOffset.x/FrameW;
        NSLog(@"%d",page);
        [self.navTitleView updateFrame:page];
        
    }
}



#pragma mark---------tableDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if([tableView isEqual:OneTable])
    {
        height = 80;
    }else
    {
        return 120;
    }
    return height;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cell = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"%ld--askl",indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"6"];
    return  cell;
    
}

#pragma mark---------CollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 100);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Coll = @"Coll";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Coll forIndexPath:indexPath];
    cell.backgroundColor  =[UIColor lightGrayColor];
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
