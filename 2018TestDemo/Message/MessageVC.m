//
//  MessageVC.m
//  2018TestDemo
//
//  Created by zp on 2018/9/13.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "MessageVC.h"
#import <sys/utsname.h>
#import "UIImage+Gif.h"
@interface MessageVC ()<UIGestureRecognizerDelegate>

@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=UIColorFromRGB(0x1f93ff);
    
    NSLog(@"%@,%@",[self class],[super class]);
    
    [self getDeviceName];
    
    UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 100, 100)];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(clickBtn1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton * btn2 = [[UIButton alloc]initWithFrame:CGRectMake(50, 50, 50, 50)];
    btn2.backgroundColor = [UIColor cyanColor];
    [btn2 addTarget:self action:@selector(clickBtn2) forControlEvents:UIControlEventTouchUpInside];
    [btn1 addSubview:btn2];
    
    
//    UIImageView *imagevie=[[UIImageView alloc] initWithFrame:CGRectMake(50, 200, 100, 100)];
//    
//    imagevie.image = [UIImage sd_animatedGIFNamed:@"动图"];
//    [self.view addSubview:imagevie];
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    tapGr.delegate = self;
    [self.view addGestureRecognizer:tapGr];
}

- (void)clickBtn1
{
    NSLog(@"点击1");
}
- (void)clickBtn2
{
    NSLog(@"点击2");
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return nil;
}

- (void)tap
{
    NSLog(@"tap");
    [self clearSystemGestureEffect];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touch");
    [self clearSystemGestureEffect];
}

- (void)clearSystemGestureEffect
{
    NSArray *windows = [UIApplication sharedApplication].windows;
    for (UIWindow *window in windows) {
        for (UIGestureRecognizer *gesture in window.gestureRecognizers) {
            //系统手势识别过程中不打断Touch时间的传递，用处：
            //1. 可防止touch事件延迟（实测有TableView时延迟高达0.8s）
            //2. 可防止Touch事件被系统手势捕获，即使被捕获，也能正常收到touchCanceled的回调
            gesture.delaysTouchesBegan = NO;
            gesture.delaysTouchesEnded = NO;
        }
    }
}



//解决tableView的点击事件与手势冲突
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //NSString *str= [NSString stringWithFormat:@"%@",NSStringFromClass([touch.view class])] ;
    if([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"])
    {
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 获取设备型号然后手动转化为对应名称
- (NSString *)getDeviceName
{
    //需要#import <sys/utsname.h>
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone3,1"] || [platform isEqualToString:@"iPhone3,2"] || [platform isEqualToString:@"iPhone3,3"])
        return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])
        return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"] || [platform isEqualToString:@"iPhone5,2"])
        return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"] || [platform isEqualToString:@"iPhone5,4"])
        return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"] || [platform isEqualToString:@"iPhone6,2"])
        return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"])
        return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])
        return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])
        return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])
        return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"])
        return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"])
        return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"])
        return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"] || [platform isEqualToString:@"iPhone10,4"])
        return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"] || [platform isEqualToString:@"iPhone10,5"])
        return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"] || [platform isEqualToString:@"iPhone10,6"])
        return @"iPhone X";
    if ([platform isEqualToString:@"11,2"])
        return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"] || [platform isEqualToString:@"iPhone11,6"])
        return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,8"])
        return @"iPhone XR";
    if ([platform isEqualToString:@"x86_64"] || [platform isEqualToString:@"i386"])
        return @"iPhone Simulator";
    
    return @"其他设备";
}

@end
