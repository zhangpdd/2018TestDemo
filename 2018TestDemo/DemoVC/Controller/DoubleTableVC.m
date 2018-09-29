//
//  DoubleTableVC.m
//  2018TestDemo
//
//  Created by zp on 2018/9/5.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "DoubleTableVC.h"

@interface DoubleTableVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UITableView *leftTableView, *rightTableView;

@property (nonatomic,strong) UIScrollView *buttomScrollView;

@property (nonatomic,strong) NSArray *rightTitles;

@property (nonatomic,strong) NSArray *leftTitles;

@end

@implementation DoubleTableVC

-(NSArray *)rightTitles{
    if (!_rightTitles) {
        _rightTitles = @[@"最新", @"涨幅%", @"涨跌", @"昨收", @"成交量", @"成交额", @"最高", @"最低"];
    }
    return _rightTitles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadLeftTableView];
    [self loadRightTableView];
}

//设置分割线顶格
- (void)viewDidLayoutSubviews{
    [self.leftTableView setLayoutMargins:UIEdgeInsetsZero];
    [self.rightTableView setLayoutMargins:UIEdgeInsetsZero];
}

//设置cell分割线顶格
- (void)resetSeparatorInsetForCell:(UITableViewCell *)cell {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (void)loadLeftTableView{
    //    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LeftTableViewWidth, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.leftTableView = [[UITableView alloc] init];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.leftTableView];
    
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.equalTo(self.view);
        make.width.mas_equalTo(100);
    }];
}

- (void)loadRightTableView{
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.rightTitles.count * 80 + 20, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    self.rightTableView.showsVerticalScrollIndicator = NO;
    
    //self.buttomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(LeftTableViewWidth, 0, [UIScreen mainScreen].bounds.size.width - LeftTableViewWidth, [UIScreen mainScreen].bounds.size.height)];
    self.buttomScrollView = [[UIScrollView alloc] init];
    
    self.buttomScrollView.contentSize = CGSizeMake(self.rightTableView.bounds.size.width, 0);
    self.buttomScrollView.backgroundColor = [UIColor redColor];
    self.buttomScrollView.bounces = YES;
    self.buttomScrollView.showsHorizontalScrollIndicator = NO;
    
    [self.buttomScrollView addSubview:self.rightTableView];
    [self.view addSubview:self.buttomScrollView];
    
    [self.buttomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.top.and.bottom.equalTo(self.view);
        make.left.equalTo(self.leftTableView.mas_right);
    }];
    
}

#pragma mark - table view dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        static NSString *reuseIdentifer = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifer];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifer];
            [self resetSeparatorInsetForCell:cell];
            cell.contentView.backgroundColor = [UIColor yellowColor];
        }
        
        cell.textLabel.text = [NSString stringWithFormat:@"%ld==%ld",indexPath.section,indexPath.row];
        return cell;
    }else{
        static NSString *reuseIdentifer = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifer];
        
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifer];
            [self resetSeparatorInsetForCell:cell];
        }
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"==============%ld=====================================================================",indexPath.row];
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}


#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.rightTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self.leftTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - 两个tableView联动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.leftTableView) {
        [self tableView:self.rightTableView scrollFollowTheOther:self.leftTableView];
    }else{
        [self tableView:self.leftTableView scrollFollowTheOther:self.rightTableView];
    }
}

- (void)tableView:(UITableView *)tableView scrollFollowTheOther:(UITableView *)other{
    CGFloat offsetY= other.contentOffset.y;
    CGPoint offset=tableView.contentOffset;
    offset.y=offsetY;
    tableView.contentOffset=offset;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
