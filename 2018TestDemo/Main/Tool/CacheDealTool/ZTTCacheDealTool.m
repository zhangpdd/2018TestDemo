
//
//  ZTTCacheDealTool.m
//  WisdomMake
//
//  Created by 鹏 on 2017/1/16.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "ZTTCacheDealTool.h"

@implementation ZTTCacheDealTool
/**
 获取缓存大小
 
 @return 缓存的值
 */
+(NSString *)GetCacheSize
{
    //1.获取ppnetWork缓存大小
//    NSInteger ppNetWorkBytes = [PPNetworkCache getAllHttpCacheSize];
//    CGFloat ppSize = ppNetWorkBytes/1000/1000.f;
    
    //2.获取sdwebimage缓存大小
    NSString *path1 =  NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    CGFloat folderSize = 0;
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path1])
    {
        //SDWebImage框架自身计算缓存的实
        folderSize += [[SDImageCache sharedImageCache] getSize]/1000.0/1000.0;
    }
    return [NSString stringWithFormat:@"%.2fM",folderSize];
}


/**
 清理缓存大小
 */
+(void)ClearCacheSize
{
    [SVProgressHUD show];
    //1.清除ppnetWork缓存大小
    //[PPNetworkCache removeAllHttpCache];
    //2.清除sdwebimage缓存大小
    NSString *path =  NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path])
    {
        //获取目录下面的文件名字
        NSArray *childFiles = [manager subpathsAtPath:path];
        for (NSString *fileName in childFiles)
        {
            //拼接地址和文件名
            NSString *filePath = [NSString stringWithFormat:@"%@/%@",path,fileName];
            //清理文件
            NSError *error = nil;
            [manager removeItemAtPath:filePath error:&error];
        }
        //清理缓存
        [[SDImageCache sharedImageCache]clearMemory];
    }
    [SVProgressHUD dismissWithDelay:1.0];
    
    NSLog(@"清理完成-%@",[self GetCacheSize]);
}
@end
