//
//  UIButton+Creat.m
//  GJXS
//
//  Created by 周鹏 on 2017/7/7.
//  Copyright © 2017年 周鹏. All rights reserved.
//

#import "UIButton+Creat.h"

@implementation UIButton (Creat)
/**
 创建背景色带标题的按钮
 
 @param norColor 正常色
 @param hightedColor 点击色
 @param title 标题
 @param selector 方法
 @param target self
 @return 按钮
 */
+(UIButton *_Nonnull)CreatButtonWithNorColor:(UIColor *_Nullable)norColor HightedColor:(UIColor *_Nullable)hightedColor Title:(NSString *_Nullable)title SelectorName:(NSString *_Nullable)selector Target:(nullable id)target{
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (norColor) {
        [loginBtn setBackgroundImage:[UIImage imageWithColor:norColor] forState:UIControlStateNormal];
    }
    if (hightedColor) {
        [loginBtn setBackgroundImage:[UIImage imageWithColor:hightedColor] forState:UIControlStateHighlighted];
    }
    if (title) {
        [loginBtn setTitle:title forState:UIControlStateNormal];
        [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        loginBtn.titleLabel.font = [UIFont systemFontOfSize:12];//12 * ScaleSize
    }
    if (selector) {
        SEL selecter = NSSelectorFromString(selector);
        [loginBtn addTarget:target action:selecter forControlEvents:UIControlEventTouchUpInside];
    }
    return loginBtn;
}



@end
