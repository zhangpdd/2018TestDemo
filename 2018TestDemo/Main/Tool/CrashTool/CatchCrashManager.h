//
//  CatchCrashManager.h
//  ShinowDonor
//
//  Created by admin on 16/9/18.
//  Copyright © 2016年 shinow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatchCrashManager : NSObject

void uncaughtExceptionHandler(NSException *exception);

+ (NSString *)getCrashInfo;

+ (void)clearCrashInfo;

/*
 
 NSString *crashInfo = [CatchCrashManager getCrashInfo];
 这个就是获取到崩溃信息
 
 
 
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
 {
 self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
 self.window.backgroundColor = [UIColor whiteColor];
 LoginViewController *login = [[LoginViewController alloc] init];
 RootNavigationController *nav = [[RootNavigationController alloc] initWithRootViewController:login];
 [self.window setRootViewController:nav];
 
 NSUserDefaults *isMessCenter = [NSUserDefaults standardUserDefaults];
 [isMessCenter setObject:@"0" forKey:@"IsMessCenter"];
 [isMessCenter synchronize];
 
 NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
 
 [self.window  makeKeyAndVisible];
 
 return YES;
 }
 
 NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
 这个就是捕获异常信息
 */


@end
