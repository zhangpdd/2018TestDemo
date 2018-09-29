//
//  UITabBar+RedDot.h
//  2018TestDemo
//
//  Created by zp on 2018/9/17.
//  Copyright © 2018年 zp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (RedDot)

- (void)showBadgeOnItemIndex:(NSInteger)index;   ///<显示小红点

- (void)hideBadgeOnItemIndex:(NSInteger)index;  ///<隐藏小红点

@end
