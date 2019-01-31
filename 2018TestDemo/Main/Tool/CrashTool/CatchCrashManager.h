//
//  CatchCrashManager.h
//  ShinowDonor
//
//  Created by zp on 18/9/18.
//  Copyright © 2018年 shinow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatchCrashManager : NSObject

/* 添加崩溃信息监听 **/
+ (void)addExceptionHandler;

/* 获取崩溃信息 **/
+ (NSString *)getCrashInfo;

/* 清除崩溃信息 **/
+ (void)clearCrashInfo;

@end
