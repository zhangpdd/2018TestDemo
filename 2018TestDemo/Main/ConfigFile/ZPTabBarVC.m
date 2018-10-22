//
//  ZPTabBarVC.m
//  2018TestDemo
//
//  Created by zp on 2018/4/25.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "ZPTabBarVC.h"
#import "ZPNavgationVC.h"
#import "HomeVC.h"
#import "MessageVC.h"
#import "DynamicsVC.h"
#import "ProfileVC.h"
#import "ZPCustomTabBar.h"
#import "UITabBar+RedDot.h"
@interface ZPTabBarVC ()

@end

@implementation ZPTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 利用KVC来使用自定义的tabBar 中间凸出按钮
    [self setValue:[[ZPCustomTabBar alloc] init] forKey:@"tabBar"];
    
    // 创建子控制器
    HomeVC *home = [[HomeVC alloc] init];
    [self addChildVC:home title:@"首页" norImage:@"icon_home" selImage:@"icon_home_click"];
    
    MessageVC *message = [[MessageVC alloc]init];
    [message.tabBarItem setBadgeValue:@"2"];
    if (@available(iOS 10.0, *)) {
        [message.tabBarItem setBadgeColor:UIColorFromRGB(0x1f93ff)];
        [message.tabBarItem setBadgeTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
        [message.tabBarItem setBadgeTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateSelected];
    } else {
        // Fallback on earlier versions
    }
    [self addChildVC:message title:@"消息" norImage:@"icon_sp" selImage:@"icon_sp_click"];
    
    DynamicsVC *dynamic = [[DynamicsVC alloc]init];
    [dynamic.tabBarItem setBadgeValue:@"3"];
    [self addChildVC:dynamic title:@"动态" norImage:@"icon_dt" selImage:@"icon_dt_click"];
    
    ProfileVC *profile = [[ProfileVC alloc]init];
    //显示
    [self.tabBar showBadgeOnItemIndex:4];
    //隐藏
    //[self.tabBarController.tabBar hideBadgeOnItemIndex:2];
    [self addChildVC:profile title:@"我的" norImage:@"icon_wd" selImage:@"icon_wd_click"];
    
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];//背景颜色
    [[UITabBar appearance] setTranslucent:NO];//半透明属性 vc底部在tabbar上面
    
//    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
//    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
//    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
}

// 添加子控制器
-(void)addChildVC:(UIViewController *)childVC title:(NSString *)title  norImage:(NSString *)norImage selImage:(NSString *)selImage
{
    //子控制器的文字  同时设置tabbar和navigationBar的文字
    childVC.title = title;
    
    //设置默认图片
    childVC.tabBarItem.image  = [UIImage imageNamed:norImage];
    //对选中图片进行处理，不渲染，显示原图
    childVC.tabBarItem.selectedImage=[[UIImage imageNamed:selImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置tabbar下方的默认文字样式，大小， 颜色
    NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName]=[UIFont systemFontOfSize:12];
    textAttrs[NSForegroundColorAttributeName]=UIColorFromRGB(0X7a7e83);
    [childVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //设置tabbar下方的选中文字样式，大小， 颜色
    NSMutableDictionary *selectedTextAtts=[NSMutableDictionary dictionary];
    selectedTextAtts[NSFontAttributeName]=[UIFont systemFontOfSize:12];
    selectedTextAtts[NSForegroundColorAttributeName]=UIColorFromRGB(0x1f93ff);
    [childVC.tabBarItem setTitleTextAttributes:selectedTextAtts forState:UIControlStateSelected];
    
    //先给外面传进来的小控制器 包装 一个导航控制器
    ZPNavgationVC *nav = [[ZPNavgationVC alloc] initWithRootViewController:childVC];
    
    //添加为子控制器
    [self addChildViewController:nav];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
