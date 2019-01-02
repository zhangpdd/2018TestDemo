//
//  ProfileVC.m
//  2018TestDemo
//
//  Created by zp on 2018/9/13.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "ProfileVC.h"
#import "UITabBar+RedDot.h"
@interface ProfileVC ()<UITableViewDelegate, UITableViewDataSource>

@property (strong , nonatomic) UITableView *profileList;

@property (strong , nonatomic) NSArray *profileArr;

@end
NSString *str=@"123";
@implementation ProfileVC

-(NSArray *)profileArr{
    if (!_profileArr) {
        _profileArr = [NSArray array];
    }
    return _profileArr;
}

-(UITableView *)profileList{
    if (!_profileList) {
        _profileList = [[UITableView alloc] init];
        _profileList.delegate = self;
        _profileList.dataSource = self;
        [_profileList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"profileCell"];
        _profileList.tableFooterView=[[UIView alloc]init];
        _profileList.backgroundColor=[UIColor clearColor];
        
        _profileList.estimatedRowHeight = 50;
        //分割线消失
        //_securityTable.separatorStyle = UITableViewCellEditingStyleNone;
        //设置分割线的颜色
        _profileList.separatorColor = [UIColor cyanColor];
        
        [self.view addSubview:_profileList];
        [_profileList mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(NavTopHeight);
            make.left.right.offset(0);
            make.bottom.offset(0);
        }];
    }
    return _profileList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    //显示
    //[self.tabBarController.tabBar showBadgeOnItemIndex:4];
    //隐藏
    [self.tabBarController.tabBar hideBadgeOnItemIndex:4];
    
    
    self.profileArr = @[@[@"个人信息",@"账户安全"], @[@"联系客服", @"帮助中心"], @[@"关于", @"清理缓存",@"设置"], @[@"退出当前账号"]];
    
    [self.profileList reloadData];
    
    
    static NSString *str=@"123";
    
    __block int a = 10;
    NSLog(@"1---%p",&a);
    NSLog(@"1---%d",a);
    [UIView animateWithDuration:1 animations:^{
        NSLog(@"2--->:%p",&a);
        NSLog(@"2--->:%d",a);
        
    }];
    NSLog(@"3--->%p",&a);
    NSLog(@"3--->%d",a);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.profileArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *rowArr = self.profileArr[section];
    return rowArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileCell" forIndexPath:indexPath];
    
    NSArray *rowArr = self.profileArr[indexPath.section];
    cell.textLabel.text=[NSString stringWithFormat:@"%@",rowArr[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
