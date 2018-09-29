//
//  UINavigationBar+CustomBar.m
//  2018TestDemo
//
//  Created by zp on 2018/7/17.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "UINavigationBar+CustomBar.h"
#import <objc/runtime.h>

@implementation UINavigationBar (CustomBar)

static char overlayKey;

#pragma mark -- runtime:get/set
//覆盖层view
- (UIView *)overlayView
{
    /**
     *  获取到某个类的某个关联对象
     *
     *  @param object#> 关联的对象 description#>
     *  @param key#>    属性的key值 description#>
     */
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlayView:(UIView *)overlayView
{
    /**
     *  为某个类关联某个对象
     *
     *  @param object#> 要关联的对象 description#>
     *  @param key#>    要关联的属性key description#>
     *  @param value#>  你要关联的属性 description#>
     *  @param policy#> 添加的成员变量的修饰符 description#>
     */
    objc_setAssociatedObject(self, &overlayKey, overlayView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)setNavBarBgColor:(UIColor *)backgroundColor
{
    if (!self.overlayView) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + statusBarHeight)];
        self.overlayView.userInteractionEnabled = NO;
        self.overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth;    // Should not set `UIViewAutoresizingFlexibleHeight`
        [[self.subviews firstObject] insertSubview:self.overlayView atIndex:0];
    }
    self.overlayView.backgroundColor = backgroundColor;
}

- (void)setNavBarTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)setNavBarAlpha:(CGFloat)alpha
{
    self.overlayView.alpha = alpha;
    
}

- (void)navBarReset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlayView removeFromSuperview];
    self.overlayView = nil;
}

@end
