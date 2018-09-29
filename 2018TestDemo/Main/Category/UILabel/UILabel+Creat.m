//
//  UILabel+Creat.m
//  GJXS
//
//  Created by 周鹏 on 2017/7/7.
//  Copyright © 2017年 周鹏. All rights reserved.
//

#import "UILabel+Creat.h"

@implementation UILabel (Creat)
/**
 创建普通的lable
 
 @param font font
 @param color 字体颜色
 @return label
 */
+(UILabel *)CreatCustomLabelWithFont:(UIFont *)font TitleColor:(UIColor *)color
{
    UILabel *label = [[UILabel alloc]init];
    label.font = font;
    label.textColor = color;
    return label;
}
@end
