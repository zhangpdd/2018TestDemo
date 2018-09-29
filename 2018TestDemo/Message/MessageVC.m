//
//  MessageVC.m
//  2018TestDemo
//
//  Created by zp on 2018/9/13.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "MessageVC.h"

@interface MessageVC ()<UIGestureRecognizerDelegate>

@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=UIColorFromRGB(0x1f93ff);
    
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    tapGr.delegate = self;
    [self.view addGestureRecognizer:tapGr];
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
    NSString *str= [NSString stringWithFormat:@"%@",NSStringFromClass([touch.view class])] ;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
