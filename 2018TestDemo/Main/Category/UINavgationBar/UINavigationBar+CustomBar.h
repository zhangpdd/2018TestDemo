//
//  UINavigationBar+CustomBar.h
//  2018TestDemo
//
//  Created by zp on 2018/7/17.
//  Copyright © 2018年 zp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (CustomBar)

/**
 更改导航栏颜色

 @param backgroundColor 颜色
 */
- (void)setNavBarBgColor:(UIColor *)backgroundColor;

/**
 更改透明度

 @param alpha 导航栏透明度
 */
- (void)setNavBarAlpha:(CGFloat)alpha;

/**
 导航栏背景高度

 @param translationY 高度
 */
- (void)setNavBarTranslationY:(CGFloat)translationY;

/**
 还原回系统导航栏
 */
- (void)navBarReset;

@end
