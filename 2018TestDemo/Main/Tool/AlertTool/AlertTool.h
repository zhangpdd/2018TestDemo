//
//  AlertTool.h
//  2018TestDemo
//
//  Created by zp on 2018/6/5.
//  Copyright © 2018年 zp. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum postionType{
    
    TopOfView,
    CenterOfView,
    BottomOfView
    
}postionType;
@interface AlertTool : NSObject


/**
 提示语类方法

 @param msg 提示词
 @param presentView 显示的试图
 @param postion 显示的位置
 */
+(void)ShowAlertMsg:(NSString *)msg ToView:(UIView *)presentView Position:(postionType)postion;



+(void)ShowAlertTitle:(NSString *)title msg:(NSString *)msg InVC:(UIViewController *)VC;

@end
