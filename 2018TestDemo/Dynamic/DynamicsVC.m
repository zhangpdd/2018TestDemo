//
//  DynamicVC.m
//  2018TestDemo
//
//  Created by zp on 2018/9/13.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "DynamicsVC.h"
#import "HttpRequestTool.h"
@interface DynamicsVC ()


@end

@implementation DynamicsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [HttpRequestTool GET:@"http://120.77.61.63:9198/api/DocManager/DownloadDesignDocVersionOfFolder?folderId=106" parameters:nil progress:^(NSProgress *progress) {
        
    } success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
    //http://pt.qiandeng.gov.cn/river/webService/WebService_river.asmx/hdxys
    //[dic setValue:@"" forKey:@"hdbh"];
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionary];
    [dic setValue:@"" forKey:@"hdbh"];
    [HttpRequestTool POST:@"http://pt.qiandeng.gov.cn/river/webService/WebService_river.asmx/hdxys" parameters:dic progress:^(NSProgress *progress) {
        
    } success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
    
    [HttpRequestTool POST:@"http://pt.qiandeng.gov.cn/webService/hqappService.asmx/checkNewVer_ios" parameters:nil progress:^(NSProgress *progress) {
        
    } success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
    
    // Do any additional setup after loading the view.
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
