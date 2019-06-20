//
//  ProfileVC.m
//  2018TestDemo
//
//  Created by zp on 2018/9/13.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "ProfileVC.h"
#import "UITabBar+RedDot.h"
#import "HttpRequestTool.h"
#import "iCloudManager.h"
#import <WebKit/WebKit.h>
@interface ProfileVC ()<UITableViewDelegate, UITableViewDataSource,UIDocumentPickerDelegate>

@property (strong , nonatomic) UITableView *profileList;

@property (strong , nonatomic) NSArray *profileArr;

@property(nonatomic,strong) UIWebView* webView;

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
    
    
    //static NSString *str=@"123";
    
    __block int a = 10;
    NSLog(@"1---%p",&a);
    NSLog(@"1---%d",a);
    [UIView animateWithDuration:1 animations:^{
        NSLog(@"2--->:%p",&a);
        NSLog(@"2--->:%d",a);
        
    }];
    NSLog(@"3--->%p",&a);
    NSLog(@"3--->%d",a);
    
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 500, 300, 100)];
    self.webView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.webView];
    
    
    
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // ios8+才支持icloud drive功能
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >=11.0){
        //iOS 8 specific code here
        NSArray *documentTypes = @[@"public.content", @"public.text", @"public.source-code ", @"public.image", @"public.audiovisual-content", @"com.adobe.pdf", @"com.apple.keynote.key", @"com.microsoft.word.doc", @"com.microsoft.excel.xls", @"com.microsoft.powerpoint.ppt"];
        
        UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:documentTypes inMode:UIDocumentPickerModeOpen];
        documentPicker.delegate = self;
        documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:documentPicker animated:YES completion:nil];
    }
    
}


// 选中icloud里的pdf文件
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    
    NSArray *array = [[url absoluteString] componentsSeparatedByString:@"/"];
    NSString *fileName = [array lastObject];
    fileName = [fileName stringByRemovingPercentEncoding];
    
    BOOL fileUrlAuthozied = [url startAccessingSecurityScopedResource];
    if(fileUrlAuthozied){
        NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
        NSError *error;
        
        [fileCoordinator coordinateReadingItemAtURL:url options:0 error:&error byAccessor:^(NSURL *newURL) {
            
            if ([iCloudManager iCloudEnable]) {
                [iCloudManager downloadWithDocumentURL:url callBack:^(id obj) {
                    NSData *data = obj;
                    
                    //写入沙盒Documents
                    NSString *filePath = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@",fileName]];
                    [data writeToFile:filePath atomically:YES];
                    
                    
                    NSString *doucumentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
                    //2.拼接上文件路径
                    NSString *filtPath = [doucumentsPath stringByAppendingPathComponent:fileName];
                    
                    NSData *showData = [NSData dataWithContentsOfFile:filtPath];
                    
                }];
            }
            
            [self dismissViewControllerAnimated:YES completion:NULL];
            
            
            
        }];
        [url stopAccessingSecurityScopedResource];
    }else{
        //Error handling
        
    }
}



//http://ruiyi2.frpgz1.idcfengye.com/app/adam/api/v1/upload

- (void)uploadURL: (NSString *)url WithName:(NSString *)name
{
    [HttpRequestTool uploadFileWithURL:@"http://ruiyi2.frpgz1.idcfengye.com/app/adam/api/v1/upload" parameters:nil name:@"fileUploads" filePath:url progress:^(NSProgress *progress) {
        
    } success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
