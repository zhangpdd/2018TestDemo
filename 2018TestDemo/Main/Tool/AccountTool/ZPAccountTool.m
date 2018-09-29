//
//  ZPAccountTool.m
//  ssd
//
//  Created by 张鹏 on 2017/6/12.
//  Copyright © 2017年 zhangpeng. All rights reserved.
//

#import "ZPAccountTool.h"

#define ZPAccountFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"accountInfo.archive"]

@implementation ZPAccountTool

/**
 *  存储帐号信息
 */
+ (void)save:(ZPAccount *)account
{
    // 归档存储帐号信息
    [NSKeyedArchiver archiveRootObject:account toFile:ZPAccountFilepath];
}

/**
 *  读取帐号信息
 */
+ (ZPAccount *)account
{
    // 读取帐号信息
    ZPAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:ZPAccountFilepath];
    
    return account;
}

/**
 删除信息
 */
+(void)clearUserInfo
{
    //创建文件管理对象
    NSFileManager* fileManager=[NSFileManager defaultManager];
    //文件是否存在
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:ZPAccountFilepath];
    //进行逻辑判断
    if (!blHave) {
        NSLog(@"文件不存在");
        return ;
    }else {
        //文件是否被删除
        BOOL blDele= [fileManager removeItemAtPath:ZPAccountFilepath error:nil];
        //进行逻辑判断
        if (blDele) {
            NSLog(@"删除成功");
        }else {
            NSLog(@"删除失败");
        }
    }
}


@end
