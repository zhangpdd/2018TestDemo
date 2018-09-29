//
//  ZPNavigationTool.h
//  2018TestDemo
//
//  Created by zp on 2018/7/2.
//  Copyright © 2018年 zp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZPNavigationTool : NSObject

+(void)backOnNavigationItemWithNavItem:(UINavigationItem *)navitem target:(id)target action:(SEL)action;

@end
