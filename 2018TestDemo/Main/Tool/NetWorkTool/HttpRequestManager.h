//
//  HttpRequestManager.h
//  2018TestDemo
//
//  Created by zp on 2018/7/11.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface HttpRequestManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

@end
