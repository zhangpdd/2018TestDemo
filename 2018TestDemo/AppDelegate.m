//
//  AppDelegate.m
//  2018TestDemo
//
//  Created by zp on 2018/4/25.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "AppDelegate.h"

#import "ZPNavgationVC.h"
#import "ZPTabBarVC.h"
#import "HttpRequestTool.h"
#import "CatchCrashManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //监听网络
    [self addNetWorkListener];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[ZPTabBarVC alloc]init];
    
    //捕获异常崩溃信息
    [CatchCrashManager addExceptionHandler];
    
//    NSArray *arr = @[@(0), @(1)];
//    NSLog(@"%@", arr[2]); //模拟越界异常
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


#pragma mark 网络监听
-(void)addNetWorkListener
{
    [HttpRequestTool networkStatusWithBlock:^(ZPNetworkStatusType networkStatus) {
        
        switch (networkStatus) {
                // 未知网络
            case ZPNetworkStatusUnknown:
                NSLog(@"未知网络,加载缓存数据");
                [SVProgressHUD showInfoWithStatus:@"未知网络"];
                [SVProgressHUD dismissWithDelay:1.0];
                break;
                // 无网络
            case ZPNetworkStatusNotReachable:
                NSLog(@"无网络,加载缓存数据");
                [SVProgressHUD showInfoWithStatus:@"无网络"];
                [SVProgressHUD dismissWithDelay:1.0];
                break;
                // 手机网络
            case ZPNetworkStatusReachableViaWWAN:
                NSLog(@"手机网络,请求数据");
                [SVProgressHUD showInfoWithStatus:@"手机网络,请求数据"];
                [SVProgressHUD dismissWithDelay:1.0];
                break;
                // 无线网络
            case ZPNetworkStatusReachableViaWiFi:
                NSLog(@"wifi网络,请求网络数据");
                [SVProgressHUD showInfoWithStatus:@"wifi网络,请求网络数据"];
                [SVProgressHUD dismissWithDelay:1.0];
                break;
        }
        
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    NSLog(@"yyyy");
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"byby!");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    NSLog(@"hello again!");
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"iiii");
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"123456");
    
}


@end
