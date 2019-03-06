//
//  main.m
//  2018TestDemo
//
//  Created by zp on 2018/4/25.
//  Copyright © 2018年 zp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TESTModel.h"
#import <malloc/malloc.h>
int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        //测试内存大小
        NSLog(@"char==%lu>>short==%lu>>int==%lu>>float==%lu>>double==%lu",sizeof(char),sizeof(short),sizeof(int),sizeof(float),sizeof(double));
        
        TESTModel *test=[[TESTModel alloc] init];
        
        //结构体大小需要是最大成员变量大小的整数倍，这里的最大成员变量是指针变量（8个字节），结构体的最终的大小需要是8的整数倍
        NSLog(@"实际需要的内存大小%lu",class_getInstanceSize([test class]));
        //Apple系统中的malloc函数分配内存空间,是根据一个bucket的大小来分配的 ,16的倍数
        NSLog(@"系统分配的内存大小%lu",malloc_size((__bridge const void *)test));
        
        //类的本质是结构体，里面的组成就是一个isa指针+成员变量 ，指针的大小8个字节，然后加成员变量大小，然后再进行内存对齐
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
