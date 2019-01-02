//
//  SeerchNavVC.m
//  2018TestDemo
//
//  Created by zp on 2018/5/18.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "SeerchNavVC.h"
#import "PeopleItem.h"
#import "PeopleTableViewCell.h"
#import "ContactViewModel.h"
#import "SKYContactManager.h"
#import "SearchTableViewController.h"


#define   SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define   SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height
#define   SCREEN_MIN_LENGTH   (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
static NSString *const kCellID = @"PeopleCellID";

@interface SeerchNavVC ()<
UISearchControllerDelegate,UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *peopleMuArray; // 数据源数组
@property (nonatomic, strong) NSArray *topArray;
@property (nonatomic, strong) NSMutableArray *indexTitlesArr;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) SearchTableViewController *searchVC;
//searchController


@property (nonatomic, strong) UITableView *demoList;

@end

@implementation SeerchNavVC
-(UITableView *)demoList{
    if (!_demoList) {
        _demoList = [[UITableView alloc] init];
        _demoList.delegate = self;
        _demoList.dataSource = self;
        [_demoList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"demoCell"];
        _demoList.tableFooterView=[[UIView alloc]init];
        _demoList.backgroundColor=UIColorFromRGB(0Xeeeeee);//[UIColor clearColor];
        
        _demoList.estimatedRowHeight = 50;
        //分割线消失
        //_securityTable.separatorStyle = UITableViewCellEditingStyleNone;
        //设置分割线的颜色
        _demoList.separatorColor = [UIColor cyanColor];
        
        [self.view addSubview:_demoList];
        [_demoList mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _demoList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.edgesForExtendedLayout=UIRectEdgeAll;
    
    
    self.peopleMuArray = [NSMutableArray new];
    self.indexTitlesArr = [NSMutableArray new];
    self.topArray = @[@{@"title": @"新朋友", @"image": @"新朋友"}, @{@"title": @"群聊", @"image": @"新朋友"}, @{@"title": @"标签", @"image": @"新朋友"}, @{@"title": @"公众号", @"image": @"新朋友"}];
    [self.demoList registerNib:[UINib nibWithNibName:NSStringFromClass([PeopleTableViewCell class]) bundle:nil] forCellReuseIdentifier:kCellID];
    //索引条背景的颜色（清空颜色就不会感觉索引条将tableview往左边挤）
    [self.demoList setSectionIndexBackgroundColor:[UIColor clearColor]];
    //索引条文字的颜色
    [self.demoList setSectionIndexColor:[UIColor darkGrayColor]];
    [self setSearchView];
    NSLog(@"开始获取通讯录");
    [self loadData];
    
    // 添加 searchbar 到 headerview
    self.demoList.tableHeaderView = self.searchController.searchBar;
    
    

}

- (void)loadData {
    if ([[SKYContactManager sharedInstance] getAllPeoples] == nil) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadData];
        });
    } else {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self.peopleMuArray = [[ContactViewModel new] handleLettersArray:[[SKYContactManager sharedInstance] getAllPeoples]];
            for (NSDictionary *dic in self.peopleMuArray) {
                [self.indexTitlesArr addObject:dic.allKeys[0]];
            }
            NSLog(@"获取通讯录结束");
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.demoList reloadData];
            });
        });
    }
}

- (void)setSearchView {
    // 创建UISearchController, 这里使用当前控制器来展示结果
    //UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //self.searchVC = [main instantiateViewControllerWithIdentifier:@"SearchResultVC"];
    self.searchVC = [[SearchTableViewController alloc] init];
    UISearchController *search = [[UISearchController alloc] initWithSearchResultsController:_searchVC];
    // 设置结果更新代理
    [search setSearchResultsUpdater:_searchVC];//_searchVC
    [search setDelegate:_searchVC];//_searchVC
    // 因为在当前控制器展示结果, 所以不需要这个透明视图
    search.dimsBackgroundDuringPresentation = NO;
    //点击搜索的时候,是否隐藏导航栏
    search.hidesNavigationBarDuringPresentation = YES;
    search.searchBar.placeholder = @"搜索";
    [search.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
    [search.searchBar sizeToFit];
    //取消按钮字体和光标的颜色
    search.searchBar.tintColor = [UIColor greenColor];
    //改变searchController背景颜色
    search.searchBar.backgroundImage = [UIImage imageWithColor:[UIColor colorWithHexString:@"#eeeeee"]];
    //设置搜索框图标的偏移
    [search.searchBar setPositionAdjustment:UIOffsetMake(SCREEN_MIN_LENGTH/2-43, 0) forSearchBarIcon:UISearchBarIconSearch];
    
    self.searchController = search;
    //searchBar加到tableView的headerView上，然后为tableView添加sectionIndex，问题就出来了，因为sectionIndex会占用位置，tableView整体左移，searchBar也不例外。解决方法是把searchBar加在一个UIView上，然后把UIView加在tableHeaderView上，同时sectionIndex背景色要清除(clearColor)
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_MIN_LENGTH, _searchController.searchBar.bounds.size.height)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [headerView addSubview:self.searchController.searchBar];
    self.demoList.tableHeaderView = headerView;
    
    if (@available(iOS 11.0, *)) {
        self.demoList.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.definesPresentationContext = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)willPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"123");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.peopleMuArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dic = self.peopleMuArray[section];
    return [dic.allValues[0] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PeopleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    NSDictionary *dic = self.peopleMuArray[indexPath.section];
    [cell setPeopleContent:dic.allValues[0][indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_MIN_LENGTH, 20)];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, SCREEN_MIN_LENGTH - 8, 20)];
    [bgView addSubview:label];
    label.font = [UIFont systemFontOfSize:15.f];
    label.textColor = [UIColor colorWithHexString:@"#999999"];
    NSDictionary *dic = self.peopleMuArray[section];
    label.text = dic.allKeys[0];
    return bgView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_MIN_LENGTH, 0.1)];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    return bgView;
}

//响应点击索引时的委托方法
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    NSInteger count = 0;
    for (NSString *letter in self.indexTitlesArr) {
        if([letter isEqualToString:title]) {
            return count;
        }
        count++;
    }
    return 0;
}

//返回索引数组
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.indexTitlesArr;
}



+(void)load
{
    NSLog(@"子类load");
}

+(void)initialize
{
    NSLog(@"initialize");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
