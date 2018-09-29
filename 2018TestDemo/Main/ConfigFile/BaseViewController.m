//
//  BaseViewController.m
//  2018TestDemo
//
//  Created by zp on 2018/4/26.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "BaseViewController.h"
#import "CatchCrashManager.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    
//    self.navigationController.navigationBar.barTintColor=UIColorFromRGB(0X5d75fa);
//    self.navigationController.navigationBar.alpha=1.0;
//    self.navigationController.navigationBarHidden=NO;
//    self.navigationController.navigationBar.barTintColor=UIColorFromRGB(0X5d75fa);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //self.edgesForExtendedLayout=UIRectEdgeNone;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)){
            [[UIScrollView appearanceWhenContainedInInstancesOfClasses:@[[BaseViewController class]]] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    });

    //iOS11默认开启Self-Sizing 如果你没用到预估高度
    if (@available(iOS 11.0, *)) {
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }

    
    //NSString *crashInfo = [CatchCrashManager getCrashInfo];
    
    //NSLog(@"崩溃信息%@",crashInfo);
    
    //[self closeVC];
}

+(void)load
{
    NSLog(@"父类load");
}

+(void)initialize
{
    NSLog(@"父类initialize");
}

-(void)closeVC
{
    NSLog(@"父控制器");
}

/**
 判断控制器是否被销毁
 */
- (void)dealloc
{
    NSLog(@"dealloc---%@", NSStringFromClass([self class]));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
