//
//  ZPAccountTool.h
//  ssd
//
//  Created by 张鹏 on 2017/6/12.
//  Copyright © 2017年 zhangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZPAccount.h"
@interface ZPAccountTool : NSObject

/**
 *  存储帐号信息
 */
+ (void)save:(ZPAccount *)account;

/**
 *  删除帐号信息
 */
+ (void)clearUserInfo;

/**
 *  读取帐号信息
 */
+ (ZPAccount *)account;

@end
