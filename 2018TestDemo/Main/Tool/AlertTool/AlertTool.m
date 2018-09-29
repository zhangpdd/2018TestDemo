//
//  AlertTool.m
//  2018TestDemo
//
//  Created by zp on 2018/6/5.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "AlertTool.h"

@implementation AlertTool

+(void)ShowAlertMsg:(NSString *)msg ToView:(UIView *)presentView Position:(postionType)postion
{
    if (presentView) {
        
        if (postion == TopOfView)
        {
            [presentView makeToast:msg duration:1.5 position:CSToastPositionTop];

        }else if (postion == CenterOfView)
        {
            [presentView makeToast:msg duration:1.5 position:CSToastPositionCenter];

        }else if (postion == BottomOfView)
        {
            [presentView makeToast:msg duration:1.5 position:CSToastPositionBottom];
        }
        
    }
}

+ (void)ShowAlertTitle:(NSString *)title msg:(NSString *)msg InVC:(UIViewController *)VC
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        [alertVC dismissViewControllerAnimated:YES completion:nil];
    }]];

    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        [alertVC dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    
//    [alertVC addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//
//        [alertVC dismissViewControllerAnimated:YES completion:nil];
//    }]];
//
    
    
    
    [VC presentViewController:alertVC animated:YES completion:nil];
}

@end
