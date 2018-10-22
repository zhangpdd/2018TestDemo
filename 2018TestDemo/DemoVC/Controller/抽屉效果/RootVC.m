//
//  RootVC.m
//  2018TestDemo
//
//  Created by zp on 2018/10/15.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "RootVC.h"
#import "centerVC.h"
#import "leftVC.h"
#import "rightVC.h"

@interface RootVC ()
{
    BOOL _isChange;
    BOOL _isH;
}
@end

@implementation RootVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    centerVC *centerVc = [[centerVC alloc] init];
    
    leftVC *leftVc = [leftVC new];
    
    rightVC *rightVc = [rightVC new];
    
    [self addChildViewController:leftVc];
    [self addChildViewController:rightVc];
    
    
    UINavigationController *centerNC = [[UINavigationController alloc] initWithRootViewController:centerVc];
    [self addChildViewController:centerNC];
    
    
    leftVc.view.frame = CGRectMake(0, 0, 250, [UIScreen mainScreen].bounds.size.height);
    
    rightVc.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 250, 0, 250, [UIScreen mainScreen].bounds.size.height);
    
    centerNC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    
    
    [self.view addSubview:leftVc.view];
    [self.view addSubview:rightVc.view];
    [self.view addSubview:centerNC.view];
    
    centerVc.navigationItem.leftBarButtonItem = ({
        UIBarButtonItem *leftB = [[UIBarButtonItem alloc] initWithTitle:@"左边" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
        leftB;
    });
    
    
    centerVc.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *rightB = [[UIBarButtonItem alloc] initWithTitle:@"右边" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightAction:)];
        rightB;
    });
}


/**
 *  左边按钮事件: rightVC 和 centerNC 向右偏移
 */
- (void)leftAction:(UIBarButtonItem *)sender {
    
    UINavigationController *centerNC = self.childViewControllers.lastObject;
    rightVC *rightVc = self.childViewControllers[1];
    leftVC *leftVc = self.childViewControllers.firstObject;
    [UIView animateWithDuration:0.5 animations:^{
        
        /*       if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
         // iOS 7
         [self prefersStatusBarHidden];
         [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
         }
         */
        if ( centerNC.view.center.x != self.view.center.x ) {
            
            
            NSLog(@"1回来");
            leftVc.view.frame = CGRectMake(0, 0, 250, [UIScreen mainScreen].bounds.size.height);
            rightVc.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 250, 0, 250, [UIScreen mainScreen].bounds.size.height);
            centerNC.view.frame = [UIScreen mainScreen].bounds;
            _isChange = !_isChange;
            return;
        }{
            
            
            centerNC.view.frame = CGRectMake(250, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            rightVc.view.frame = CGRectMake(250, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            
            // [[UIApplication sharedApplication]setStatusBarHidden:_isChange];
            // [self setNavigationBarHidden:_isChange animated:YES];
            
        }
    }];
    
}


/**
 * 右边按钮事件: leftVC 和 centerNC 向左偏移
 */
- (void)rightAction:(UIBarButtonItem *)sender {
    UINavigationController *centerNC = self.childViewControllers.lastObject;
    leftVC *leftVc = self.childViewControllers.firstObject;
    rightVC *rightVc = self.childViewControllers[1];
    [UIView animateWithDuration:0.5 animations:^{
        
        if ( centerNC.view.center.x != self.view.center.x ) {
            
            
            NSLog(@"1回来");
            leftVc.view.frame = CGRectMake(0, 0, 250, [UIScreen mainScreen].bounds.size.height);
            rightVc.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 250, 0, 250, [UIScreen mainScreen].bounds.size.height);
            centerNC.view.frame = [UIScreen mainScreen].bounds;
            
        }else{
            centerNC.view.frame = CGRectMake(-250, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            leftVc.view.frame =CGRectMake(-250, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        }
    }];
    
}


@end
