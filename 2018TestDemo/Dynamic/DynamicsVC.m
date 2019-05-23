//
//  DynamicVC.m
//  2018TestDemo
//
//  Created by zp on 2018/9/13.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "DynamicsVC.h"
#import "HttpRequestTool.h"
#import "CarouselImageView.h"
@interface DynamicsVC ()<CarouselImageViewDelegate>


@end

@implementation DynamicsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadCarousImage];
    
    
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

- (void)loadCarousImage
{
    CarouselImageView *carousView=[[CarouselImageView alloc] initWithCarouselImageViewFrame:CGRectMake(0, 100, FrameW, 200) delegate:self placeholderImage:[UIImage imageNamed:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1554923179843&di=b5cd86830a309113d4a48aa15591cef8&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F3bbff849d09944ee844715290116c174e8d1ed745db84-LUNs0q_fw658"]];
    carousView.imageArr = [NSArray arrayWithObjects:
                           @"http://ygjkclass.com/pdres/ext_images/banner1.png",
                           @"http://ygjkclass.com/pdres/ext_images/banner3.png",
                           @"http://ygjkclass.com/pdres/ext_images/banner2.png",
                           @"http://ygjkclass.com/pdres/ext_images/tnb-2.png",
                           @"http://ygjkclass.com/pdres/ext_images/shimian-1.jpg", nil];
    
    [self.view addSubview:carousView];
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
