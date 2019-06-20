//
//  ChildTestVC.m
//  2018TestDemo
//
//  Created by zp on 2019/1/9.
//  Copyright © 2019年 zp. All rights reserved.
//

#import "ChildTestVC.h"
#import "ChooseVC.h"
#import "WHGradientHelper.h"
@interface ChildTestVC ()

@end

@implementation ChildTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:1.0];
    
   
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSArray *arr = [NSArray arrayWithArray:self.navigationController.childViewControllers];
    NSLog(@"%@---%@---%@===",self.navigationController,arr,self.parentViewController);
    NSLog(@"%@",self.navigationController.visibleViewController);
    
//    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//    if (@available(iOS 10.0, *)) {
//        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
//            NSLog(@"===%d===",success);
//        }];
//    } else {
//        // Fallback on earlier versions
//    }
    //[self.parentViewController.navigationController pushViewController:[[ChooseVC alloc] init] animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"子试图消失");
}

@end
