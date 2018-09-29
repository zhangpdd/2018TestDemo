//
//  UIButton+NsTimer.h
//  2018TestDemo
//
//  Created by zp on 2018/7/20.
//  Copyright © 2018年 zp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (NsTimer)

/**
 *  🐶计时时间
 */
@property(nonatomic,assign,readwrite)NSInteger time;

/**
 *  🐶定时器期间显示字段
 */
@property(nonatomic,copy) NSString *format;

/**
 开启计时器
 */
- (void)startTimer;

/**
 关闭计时器
 */
- (void)endTimer;

@end
