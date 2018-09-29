//
//  ZPNavigationTool.m
//  2018TestDemo
//
//  Created by zp on 2018/7/2.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "ZPNavigationTool.h"

@implementation ZPNavigationTool

+(void)backOnNavigationItemWithNavItem:(UINavigationItem *)navitem target:(id)target action:(SEL)action
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -15;
    //左边返回按钮
    UIButton *fanHuiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fanHuiButton.frame = CGRectMake(0, 0, 44, 44);
    fanHuiButton.backgroundColor=[UIColor redColor];
    [fanHuiButton setImage:[UIImage imageNamed:@"dc_btn_back"] forState:UIControlStateNormal];
    [fanHuiButton setImage:[UIImage imageNamed:@"dc_btn_back"] forState:UIControlStateHighlighted];
    [fanHuiButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:fanHuiButton];
    if (@available(iOS 11.0, *)) {
        fanHuiButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        fanHuiButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        navitem.leftBarButtonItems = @[leftItem];
    }else{
        navitem.leftBarButtonItems = @[negativeSpacer,leftItem];
    }
}
@end
