//
//  HttpRequestManager.m
//  2018TestDemo
//
//  Created by zp on 2018/7/11.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "HttpRequestManager.h"

@implementation HttpRequestManager

// 创建静态对象 防止外部访问
static HttpRequestManager *_manager = nil;

// 为了使实例易于外界访问 我们一般提供一个类方法
// 类方法命名规范 share类名|default类名|类名
+ (instancetype)sharedManager
{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        if (_manager == nil) {
//            _manager = [self manager];
//        }
//    });
    return [self manager];
}

//alloc会调用allocWithZone:
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager == nil) {
            _manager = [super allocWithZone:zone];
        }
    });
    return _manager;
}

// 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
-(id)copyWithZone:(NSZone *)zone
{
    return _manager;
}
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _manager;
}


@end
