//
//  ZPNavgationVC.m
//  2018TestDemo
//
//  Created by zp on 2018/4/25.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "ZPNavgationVC.h"

@interface ZPNavgationVC ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation ZPNavgationVC

// 第一次使用这个类的时候调用
+(void)initialize
{
    [self setNavBarAppearance];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    //这样写了以后就可以通过手势滑动返回上一层了
    __weak ZPNavgationVC *weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])  {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
}


/**
 设置默认属性
 */
+(void)setNavBarAppearance
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    // 设置导航栏标题默认颜色 字体
    [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                     NSForegroundColorAttributeName:UIColorFromRGB(0Xffffff)}];
    // 设置导航栏默认的背景颜色
    navBar.barTintColor = UIColorFromRGB(0x1f93ff);
    
    //navBar.backgroundColor=[UIColor redColor];
    //[navBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //这是背景图片 空图片 透明背景
    //[navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //设置导航条的样式
    //navBar.barStyle = UIBarStyleBlackOpaque;

    //设置透明度  yes的时候，self.view的原点是从导航栏左上角开始计算
    //慎用       no的时候，self.view的原点是从导航栏左下角开始计算
    //[navBar setTranslucent:NO];
    
    // 统一设置状态栏样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    [navBar setShadowImage:[[UIImage alloc]init]];
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //判断上一个控制器和现在的控制器是不是同一个，如果是，返回。如果不是push到当前控制器，这就有效避免了同一个控制器连续push的问题
    if ([self.topViewController isMemberOfClass:[viewController class]]) {
        return;
    }
    else{
        if (self.viewControllers.count != 0){
            // 隐藏tabbar
            viewController.hidesBottomBarWhenPushed = YES;
            
            viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"dc_btn_back" highIcon:@"dc_btn_back" target:self action:@selector(back)];
            
        }
    }
    [super pushViewController:viewController animated:animated];
}

//返回上一个控制器
-(void)back
{
    [self popViewControllerAnimated:YES];
}

//当有需求的时候，返回根控制器
-(void)popToRoot
{
    [self popToRootViewControllerAnimated:YES];
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isEqual:self.interactivePopGestureRecognizer] && self.viewControllers.count > 1 &&
        [self.visibleViewController isEqual:[self.viewControllers lastObject]]) {
        //判断当导航堆栈中存在页面，并且可见视图如果不是导航堆栈中的最后一个视图时，就会屏蔽掉滑动返回的手势。此设置是为了避免页面滑动返回时因动画存在延迟所导致的卡死。
        return YES;
    } else {
        return NO;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
