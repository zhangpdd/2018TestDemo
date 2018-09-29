//
//  ZTTCacheDealTool.h
//  WisdomMake
//
//  Created by 鹏 on 2017/1/16.
//  Copyright © 2017年 鹏. All rights reserved.
//获取磁盘缓存大小，可删除

#import <Foundation/Foundation.h>

@interface ZTTCacheDealTool : NSObject

/**
 获取缓存大小

 @return 缓存的值
 */
+(NSString *)GetCacheSize;


/**
 清理缓存大小
 */
+(void)ClearCacheSize;


@end
