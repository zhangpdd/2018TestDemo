//
//  FriendListVC.m
//  2018TestDemo
//
//  Created by zp on 2018/5/22.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "FriendListVC.h"
#import "FriendListModel.h"
@interface FriendListVC ()<UITableViewDelegate, UITableViewDataSource>

@property (strong , nonatomic) UITableView *PowerStationListTable;

@property (strong, nonatomic) NSMutableArray *powerStationArr;

@property (strong, nonatomic) NSMutableArray *headArr;

@property (strong, nonatomic) NSMutableArray *Arr;

@property (strong , nonatomic) NSString *art;

@property (strong, nonatomic) UIView *viewBG;
@end

@implementation FriendListVC
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
        
      
        
    }
    return _PowerStationListTable;
}

-(NSMutableArray *)powerStationArr
{
    if (_powerStationArr == nil) {
        _powerStationArr = [NSMutableArray array];
    }
    return _powerStationArr;
}

-(NSMutableArray *)headArr
{
    if (_headArr == nil) {
        _headArr = [NSMutableArray array];
    }
    return _headArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *head=[NSArray arrayWithObjects:@{@"Name":@"我的好友"}, @{@"Name":@"小学同学"}, @{@"Name":@"中学同学"}, @{@"Name":@"大学同学"}, @{@"Name":@"舍友"}, nil];
    
    for (int i=0; i<head.count; i++)
    {
        FriendListModel *model=[FriendListModel mj_objectWithKeyValues:head[i]];
        model.isSelected =NO;
        
        [self.headArr addObject:model];
    }
    
    [self.powerStationArr addObjectsFromArray:@[@[@"昵称", @"性别"], @[@"固定电话", @"绑定手机", @"用户类型"], @[@"电子邮箱", @"密保问题"], @[@"猜你喜欢"], @[@"收货地址"]]];

    
    [self.view addSubview:self.PowerStationListTable];
    [self.PowerStationListTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(ScaleHeight * 30);
        make.bottom.offset(0);
        make.left.offset(0);
        make.right.offset(0);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.headArr.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    FriendListModel *model=self.headArr[section];
    [btn setTitle:model.Name forState:UIControlStateNormal];

    btn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    btn.tag=1000+section;
    [btn addTarget:self action:@selector(TOSelect:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor=[UIColor cyanColor];
    
    return btn;
}

-(void)TOSelect: (UIButton *)sender
{
    
    FriendListModel *model=self.headArr[sender.tag-1000];
    model.isSelected = !model.isSelected;
    [self.headArr replaceObjectAtIndex:sender.tag-1000 withObject:model];
    [self.PowerStationListTable reloadSections:[NSIndexSet indexSetWithIndex:sender.tag-1000] withRowAnimation:UITableViewRowAnimationFade];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    FriendListModel *model=self.headArr[section];
    
    NSInteger count = model.isSelected ? [self.powerStationArr[section] count] : 0;
    
    return count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"powerListCell" forIndexPath:indexPath];
    
    cell.backgroundColor=[UIColor redColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    if (self.powerStationArr.count != 0)
    {
        cell.textLabel.text = self.powerStationArr[indexPath.section][indexPath.row];
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
