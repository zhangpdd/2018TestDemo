//
//  UILabel+Creat.h
//  GJXS
//
//  Created by 周鹏 on 2017/7/7.
//  Copyright © 2017年 周鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Creat)
/**
 创建普通的lable
 
 @param font font
 @param color 字体颜色
 @return label
 */
+(UILabel *)CreatCustomLabelWithFont:(UIFont *)font TitleColor:(UIColor *)color;
@end
