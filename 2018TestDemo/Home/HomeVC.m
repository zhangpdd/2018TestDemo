//
//  HomeVC.m
//  2018TestDemo
//
//  Created by zp on 2018/9/13.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "HomeVC.h"

#import "PushItemModel.h"
#import "BackAnimateVC.h"
#import "AlertAnimateVC.h"
#import "ListTypeVC.h"
#import "ShopDetailsVC.h"
#import "SeerchNavVC.h"
#import "DynamicVC.h"
#import "UserInfoVC.h"
#import "OC-JSVC.h"
#import "FriendListVC.h"
#import "FullScreenVC.h"
#import "RefreshVC.h"
#import "KeyBoardVC.h"
#import "ChooseVC.h"
#import "DoubleTableVC.h"
#import "FMDBDemoVC.h"
#import "WkHeightVC.h"
#import "RootVC.h"


#import "FullScreenVC.h"
#import "UIView+Toast.h"

#import "dyTestVC.h"
#import "UIImage+Gif.h"
#import "ZPNavigationTool.h"
#import "UITableViewCell+CellAnimation.h"

#import "demoRequest.h"
#import "HttpRequestManager.h"
#import <WebKit/WebKit.h>
#import "UIButton+HQCustomIcon.h"

@interface HomeVC ()<UITableViewDelegate, UITableViewDataSource>

@property (strong , nonatomic) UITableView *demoList;

@property (strong , nonatomic) NSMutableArray *demoArr;

// 需要把组模型添加到数据中
@property (nonatomic, strong) NSMutableArray <PushItemModel *> *sections;

@property (nonatomic, strong) NSMutableArray  *VCArr;

@property(nonatomic,strong)UIButton * button;


@property(nonatomic, strong) UIImageView *imageURL;

@end

@implementation HomeVC

-(NSMutableArray *)sections{
    if (!_sections) {
        _sections = [NSMutableArray array];
    }
    return _sections;
}

-(NSMutableArray *)VCArr{
    if (!_VCArr) {
        _VCArr = [NSMutableArray array];
    }
    return _VCArr;
}

-(NSMutableArray *)demoArr{
    if (!_demoArr) {
        _demoArr = [NSMutableArray array];
    }
    return _demoArr;
}

-(UITableView *)demoList{
    if (!_demoList) {
        _demoList = [[UITableView alloc] init];
        _demoList.delegate = self;
        _demoList.dataSource = self;
        [_demoList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"demoCell"];
        _demoList.tableFooterView=[[UIView alloc]init];
        _demoList.backgroundColor=[UIColor clearColor];
        
        _demoList.estimatedRowHeight = 50;
        //分割线消失
        //_securityTable.separatorStyle = UITableViewCellEditingStyleNone;
        //设置分割线的颜色
        _demoList.separatorColor = [UIColor cyanColor];
        
        [self.view addSubview:_demoList];
        [_demoList mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.left.right.offset(0);
            make.bottom.offset(0);
        }];
    }
    return _demoList;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
    [self.navigationController.navigationBar setNavBarBgColor:[UIColor greenColor]];
    [self.navigationController.navigationBar setNavBarAlpha:0.0];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar navBarReset];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = randomColor;
    
    [self test];
    
    //[AlertTool ShowAlertTitle:@"提示" msg:@"是否确定操作？" InVC:self];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem rightItemWithTitle:@"点我" target:self action:@selector(rightAction)];
    
    
    [self.tabBarItem setBadgeValue:@"1"];
    
    
    [self loadUIWithData];
    
    
    UIImageView *headview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, FrameW, 200)];
    headview.image =[UIImage imageNamed:@"bg.jpg"];
    self.demoList.tableHeaderView=headview;
    
    //    self.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(0, -20);
    
    
    if (@available(iOS 11.0, *)) {
        //X
        NSLog(@"%f",SafeBottomHeight);
    } else {
        // Fallback on earlier versions
    }
    
    //    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(KeyboardClose)];
    //    [self.view addGestureRecognizer:tapGr];
    
    //    NSString *url=[@"https://test.ejoy365hk.com/index.php/wap/activity.html?ac=25Paqdsirx3nQGD3#ctl=dashboard&act=index" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    WKWebView *web=[[WKWebView alloc] initWithFrame:CGRectMake(100, 100, 200, 300)];
    //    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    //    [self.view addSubview:web];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(100, 100, 100, 100);
    btn.backgroundColor=[UIColor redColor];
    [btn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self closeVC];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(100, 100, 90, 30);
    self.button.backgroundColor = [UIColor blueColor];
    [self.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.button.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.button setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.view addSubview:self.button];
    
    
    //    UIButton *_centerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 300, 80, 50)];
    //    _centerBtn.backgroundColor = [UIColor yellowColor];
    //    [_centerBtn setImage:[UIImage imageNamed:@"发布"] forState:UIControlStateNormal];
    //    [_centerBtn setTitle:@"发布" forState:UIControlStateNormal];
    //    [_centerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //    _centerBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    //    [_centerBtn setIconInTopWithSpacing:2.0];
    //    [self.view addSubview:_centerBtn];
}

- (void)test
{
    
    int arrName[4] = {10,20,30,40};
    
    int *p = (int *)(&arrName + 1);
    
    NSLog(@"%d",*(p-1));
    
    NSMutableArray *arr=[NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8", nil];
    
    NSMutableArray *arr1=[NSMutableArray arrayWithObjects:@"3",@"4",@"5",@"6",@"7",@"8", nil];
    
    for (int j=0; j<arr1.count; j++)
    {
        for (int i =0 ; i<arr.count; i++)
        {
            if ([arr[i] isEqualToString:arr1[j]])
            {
                [arr removeObject:arr[i]];
                NSLog(@"==%d==%d",i,j);
            }
        }
    }
    
    for (NSString *str in arr)
    {
        NSLog(@"====%@222",str);
    }
    NSLog(@"==%@",arr);
}

- (void)buttonAction:(UIButton *)button
{
    button.time = 10;
    button.format = @"%ld秒后重试";
    [button startTimer];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.button endTimer];
}


-(void)closeVC
{
    NSLog(@"就是子控制器");
}

- (void)rightAction
{
    //NSLog(@"uuid---%@",[NSString uuid]);
    [demoRequest getStatusListPageNum:@"1" PageSize:@"10" SucceededBlock:^(id responseObject) {
        
        NSLog(@"success");
    } failedBlock:^(NSError *error) {
        NSLog(@"fail");
    }];
}


-(void)loadUIWithData
{
    self.demoArr = [NSMutableArray arrayWithObjects:@"背景动画", @"弹出框动画", @"table异常状态", @"搜索框动画", @"商品详情", @"朋友圈",@"个人信息的存储和删除",@"OC-js交互",@"好友列表", @"下拉刷新在中间",@"键盘高度",@"筛选",@"列表联动",@"数据库",@"网页高度",@"抽屉效果",@"全屏", nil];
    
    PushItemModel *model=[[PushItemModel alloc] init];
    model.destVc = [BackAnimateVC class];
    
    PushItemModel *model1=[[PushItemModel alloc] init];
    model1.destVc = [AlertAnimateVC class];
    
    PushItemModel *model2=[[PushItemModel alloc] init];
    model2.destVc = [ListTypeVC class];
    
    PushItemModel *model3=[[PushItemModel alloc] init];
    model3.destVc = [SeerchNavVC class];
    
    
    PushItemModel *model4=[[PushItemModel alloc] init];
    model4.destVc = [ShopDetailsVC class];
    
    PushItemModel *model5=[[PushItemModel alloc] init];
    model5.destVc = [DynamicVC class];
    
    PushItemModel *model6=[[PushItemModel alloc] init];
    model6.destVc = [UserInfoVC class];
    
    PushItemModel *model7=[[PushItemModel alloc] init];
    model7.destVc = [OC_JSVC class];
    
    PushItemModel *model8=[[PushItemModel alloc] init];
    model8.destVc = [FriendListVC class];
    
    PushItemModel *model9=[[PushItemModel alloc] init];
    model9.destVc = [RefreshVC class];
    
    PushItemModel *model10=[[PushItemModel alloc] init];
    model10.destVc = [KeyBoardVC class];
    
    PushItemModel *model11=[[PushItemModel alloc] init];
    model11.destVc = [ChooseVC class];
    
    PushItemModel *model12=[[PushItemModel alloc] init];
    model12.destVc = [DoubleTableVC class];
    
    PushItemModel *model13=[[PushItemModel alloc] init];
    model13.destVc = [FMDBDemoVC class];
    
    PushItemModel *model14=[[PushItemModel alloc] init];
    model14.destVc = [WkHeightVC class];
    
    PushItemModel *model15=[[PushItemModel alloc] init];
    model15.destVc = [RootVC class];
    
    [self.sections addObjectsFromArray:[NSArray arrayWithObjects:model,model1,model2, model3,model4,model5,model6,model7,model8,model9,model10,model11,model12,model13,model14,model15,nil]];
    
    
    [self.VCArr addObjectsFromArray:[NSArray arrayWithObjects:@[[BackAnimateVC class],[AlertAnimateVC class],[ListTypeVC class],[SeerchNavVC class],[ShopDetailsVC class],[DynamicVC class],[UserInfoVC class],[OC_JSVC class],[FriendListVC class],[RefreshVC class],[KeyBoardVC class],[ChooseVC class],[DoubleTableVC class],[FMDBDemoVC class],[WkHeightVC class],[RootVC class],[FullScreenVC class]], nil]];
    
    [self.demoList reloadData];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY >= 100)
    {
        CGFloat alpha = MIN(1, 1 - ((100 + 64 - offsetY) / 64));
        [self.navigationController.navigationBar setNavBarAlpha:alpha];
        //偏移量
        self.demoList.contentInset = UIEdgeInsetsMake(NavTopHeight, 0, 0, 0);
        
    }else
    {
        [self.navigationController.navigationBar setNavBarAlpha:0.0];
        //偏移量
        self.demoList.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _demoArr.count;//[self.VCArr[0] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;//_demoArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"demoCell" forIndexPath:indexPath];
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@",_demoArr[indexPath.section]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == _demoArr.count-1)
    {
        FullScreenVC *vc=[[FullScreenVC alloc] init];
        
        //[self.navigationController pushViewController:vc animated:YES];
        [self presentViewController:vc animated:NO completion:nil];
        
    }else
    {
        PushItemModel *pushItem = (PushItemModel *)self.sections[indexPath.section];
        if(pushItem.destVc)
        {
            UIViewController *vc = [[pushItem.destVc alloc] init];
            if ([vc isKindOfClass:[UIViewController class]]) {
                vc.title= _demoArr[indexPath.section];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        
        //        NSArray *arr=self.VCArr[0];
        //        UIViewController *vc=[[arr[indexPath.section] alloc] init];
        //        vc.title= _demoArr[indexPath.section];
        //        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
