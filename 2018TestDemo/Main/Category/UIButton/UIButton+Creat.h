//
//  UIButton+Creat.h
//  GJXS
//
//  Created by 周鹏 on 2017/7/7.
//  Copyright © 2017年 周鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Creat)
/**
 创建背景色带标题的按钮
 
 @param norColor 正常色
 @param hightedColor 点击色
 @param title 标题
 @param selector 方法
 @param target self
 @return 按钮
 */
+(UIButton *_Nonnull)CreatButtonWithNorColor:(UIColor *_Nullable)norColor HightedColor:(UIColor *_Nullable)hightedColor Title:(NSString *_Nullable)title SelectorName:(NSString *_Nullable)selector Target:(nullable id)target;

@end
