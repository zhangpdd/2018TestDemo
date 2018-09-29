//
//  ZPCustomTabBar.m
//  2018TestDemo
//
//  Created by zp on 2018/5/15.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "ZPCustomTabBar.h"
#import "UIButton+HQCustomIcon.h"
#import "UIButton+Edge.h"
@interface ZPCustomTabBar ()

/**
 中间的按钮
 */
@property (nonatomic, strong) UIButton *centerBtn;

@end

@implementation ZPCustomTabBar

#pragma mark - 中间按钮懒加载
- (UIButton *)centerBtn
{
    if (!_centerBtn) {
        _centerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, FrameW/5, 50)];//75
        //_centerBtn.backgroundColor = [UIColor yellowColor];
        [_centerBtn setImage:[UIImage imageNamed:@"发布"] forState:UIControlStateNormal];
        [_centerBtn setTitle:@"发布" forState:UIControlStateNormal];
        [_centerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _centerBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        //[_centerBtn setIconInTopWithSpacing:2.0];
        [_centerBtn setImagePositionWithType:SSImagePositionTypeTop spacing:2.0];
        [_centerBtn addTarget:self action:@selector(clickCenterBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerBtn;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置tabBarItem选中状态时的颜色
        //self.tintColor = [UIColor redColor];
        self.backgroundColor = [UIColor whiteColor];
        // 添加中间按钮到tabBar上
        [self addSubview:self.centerBtn];
        
    }
    return self;
}

#pragma mark - 重新布局tabBarItem（这里需要具体情况具体分析，本例是中间有个按钮，两边平均分配按钮）
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 把tabBarButton取出来（把tabBar的SubViews打印出来就明白了）
    NSMutableArray *tabBarButtonArray = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtonArray addObject:view];
        }
    }
    
    CGFloat barWidth = self.bounds.size.width;//tabbar宽度
    CGFloat barHeight = self.bounds.size.height;//tabbar高度
    CGFloat centerBtnWidth = CGRectGetWidth(self.centerBtn.frame);//中间按钮宽度
    CGFloat centerBtnHeight = CGRectGetHeight(self.centerBtn.frame);//中间按钮高度
    // 设置中间按钮的位置，居中，凸起一丢丢
    self.centerBtn.center = CGPointMake(barWidth / 2, barHeight - centerBtnHeight/2 - 10);
    // 重新布局其他tabBarItem
    // 平均分配其他tabBarItem的宽度
    CGFloat barItemWidth = (barWidth - centerBtnWidth) / tabBarButtonArray.count;
    // 逐个布局tabBarItem，修改UITabBarButton的frame
    [tabBarButtonArray enumerateObjectsUsingBlock:^(UIView *  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGRect frame = view.frame;//按钮的frame
        if (idx >= tabBarButtonArray.count / 2) {
            // 重新设置x坐标，如果排在中间按钮的右边需要加上中间按钮的宽度
            frame.origin.x = idx * barItemWidth + centerBtnWidth;
        } else {
            frame.origin.x = idx * barItemWidth;
        }
        // 重新设置宽度
        frame.size.width = barItemWidth;
        view.frame = frame;
    }];
    
    // 把中间按钮带到视图最前面
    [self bringSubviewToFront:self.centerBtn];
}

#pragma mark - 点击中间按钮所需操作
- (void)clickCenterBtn
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"点击了中间的按钮" message:@"do something!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:action];
    // 可以这样获取tabBarController
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    
    [tabBarController.selectedViewController presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - 重写hitTest方法，让超出tabBar部分也能响应事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.clipsToBounds || self.hidden || (self.alpha == 0.f)) {
        return nil;
    }
    UIView *result = [super hitTest:point withEvent:event];
    // 如果事件发生在tabbar里面直接返回
    if (result) {
        return result;
    }
    // 这里遍历那些超出的部分就可以了，不过这么写比较通用。
    for (UIView *subview in self.subviews) {
        // 把这个坐标从tabbar的坐标系转为subview的坐标系
        CGPoint subPoint = [subview convertPoint:point fromView:self];
        result = [subview hitTest:subPoint withEvent:event];
        // 如果事件发生在subView里就返回
        if (result) {
            return result;
        }
    }
    return nil;
}

@end
