//
//  UIBarButtonItem+Extension.h

//
//  Created by 👄 on 15/9/14.
//  Copyright (c) 2015年 sczy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackView:UIView

@property(nonatomic,strong)UIButton *btn;

@end


@interface UIBarButtonItem (Extension)

/**
 导航栏左边纯title按钮
 */
+ (UIBarButtonItem *)leftItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

/**
 导航栏右边纯title按钮
 */
+ (UIBarButtonItem *)rightItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

/**
 导航栏纯图片按钮
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;

@end

