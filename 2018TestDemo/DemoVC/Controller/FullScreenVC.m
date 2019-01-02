//
//  FullScreenVC.m
//  2018TestDemo
//
//  Created by zp on 2018/5/17.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "FullScreenVC.h"
#import "demoRequest.h"
@interface FullScreenVC ()

@end

@implementation FullScreenVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //强制全屏
    [[UIDevice currentDevice]setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft]forKey:@"orientation"];
    [[self class]attemptRotationToDeviceOrientation];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.edgesForExtendedLayout=UIRectEdgeNone;

    self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    //强制全屏
    [[UIDevice currentDevice]setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft]forKey:@"orientation"];
    [[self class]attemptRotationToDeviceOrientation];
    
    UIButton *selectTimeButton=[[UIButton alloc] init];
    [selectTimeButton setTitleColor:UIColorFromRGB(0X9da8cd) forState:UIControlStateNormal];
    [selectTimeButton setTitle:@"强制横屏效果" forState:UIControlStateNormal];
    selectTimeButton.titleLabel.font=[UIFont boldSystemFontOfSize:ScaleSize*14.5];
    selectTimeButton.backgroundColor=[UIColor grayColor];
    [selectTimeButton addTarget:self action:@selector(ToDismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectTimeButton];
    [selectTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(ScaleHeight*45);
        make.right.offset(-ScaleWidth*30);
        make.width.offset(ScaleWidth*400);
        make.height.offset(ScaleHeight*200);
        
    }];
    
    [self GCDTest];
    [self gvf];
}

#pragma mark - 页面消失
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)GCDTest
{
    dispatch_group_t group = dispatch_group_create();
    
    //1
    dispatch_group_enter(group);
    //请求
    NSLog(@"123");
    dispatch_group_leave(group);
    
    //2
    dispatch_group_enter(group);
    //请求
    NSLog(@"456");
    dispatch_group_leave(group);
    
    //3
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //请求玩之后的操作
        NSLog(@"789");
    });
}

- (void)gvf
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //请求1
//        [网络请求:{
//            成功：dispatch_group_leave(group);
//            失败：dispatch_group_leave(group);
//        }];
        dispatch_group_leave(group);
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //请求2
//        [网络请求:{
//            成功：dispatch_group_leave;
//            失败：dispatch_group_leave;
//        }];
        dispatch_group_leave(group);
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //请求3
//        [网络请求:{
//            成功：dispatch_group_leave(group);
//            失败：dispatch_group_leave(group);
//        }];
        dispatch_group_leave(group);
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //界面刷新
        NSLog(@"任务均完成，刷新界面");
    });
    
    
    
}
- (void)ToDismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//是否支持自动旋转
- (BOOL)shouldAutorotate
{
    return NO;
}
//横屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}
//旋转的方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
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
