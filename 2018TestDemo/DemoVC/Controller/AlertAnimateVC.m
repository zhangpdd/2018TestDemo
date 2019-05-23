//
//  AlertAnimateVC.m
//  2018TestDemo
//
//  Created by zp on 2018/5/17.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "AlertAnimateVC.h"
#import "animateView.h"
#import "demoRequest.h"
@interface AlertAnimateVC ()

@property(nonatomic, strong) animateView *aView;

@end

@implementation AlertAnimateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *haha=[[UIView alloc] initWithFrame:self.view.bounds];
    
    NSLog(@"%f",haha.frame.size.width);
    
    UITextView *ruleTextView = [[UITextView alloc] init];
    ruleTextView.backgroundColor = [UIColor whiteColor];
    ruleTextView.editable = NO;//不可编辑
    ruleTextView.text = @"1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；v\n1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；v\n1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；\n1.每个用户同一商家每天只能领取一次商家红包；";
    ruleTextView.textColor = [UIColor blackColor];
    ruleTextView.font = Font(16);
    
//    if (@available(iOS 11.0, *)) {
//        ruleTextView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        // Fallback on earlier versions
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
    [self.view addSubview:ruleTextView];
    [ruleTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(NavTopHeight);
        make.left.right.bottom.offset(0);
    }];
    
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem rightItemWithTitle:@"弹出" target:self action:@selector(ShowAlert)];
}

- (void)ShowAlert
{
    
        //NSLog(@"uuid---%@",[NSString uuid]);
    [demoRequest getStatusListPageNum:@"1" PageSize:@"10" SucceededBlock:^(id responseObject) {
        
        NSLog(@"success");
    } failedBlock:^(NSError *error) {
        NSLog(@"fail");
    }];
    
    
    

    
    if (!_aView)
    {
        self.aView=[[animateView alloc] initWithFrame:CGRectMake(50, 100, 200, 300)];
    }
    [self.view addSubview:self.aView];
    
    
//    self.aView.layer.affineTransform = CGAffineTransformMakeScale(0.01, 0.01);
//
//    [UIView animateWithDuration: 0.5 animations:^{
//        self.aView.layer.affineTransform = CGAffineTransformMakeScale(1.0, 1.0);
//        self.aView.alpha = 1;
//    } completion:nil];
    
    self.aView.layer.affineTransform = CGAffineTransformMakeScale(0.01, 0.01);
    self.aView.alpha = 0;
    
//    [UIView animateWithDuration:1.0 animations:^{
//        self.aView.layer.affineTransform = CGAffineTransformMakeScale(1.0, 1.0);
//        self.aView.alpha = 1;
//    }];
    [UIView animateWithDuration:1.0 delay:0.1 usingSpringWithDamping:0.4 initialSpringVelocity:4 options:UIViewAnimationOptionCurveLinear animations:^{
        self.aView.layer.affineTransform = CGAffineTransformMakeScale(1.0, 1.0);
        self.aView.alpha = 1;
    } completion:^(BOOL finished) {

    }];
    
    
//    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
//
//    self.aView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.2,0.2);
//    self.aView.alpha = 0;
//    [UIView animateWithDuration:1.0 delay:0.1 usingSpringWithDamping:0.4 initialSpringVelocity:4 options:UIViewAnimationOptionCurveLinear animations:^{
//        self.aView.transform = transform;
//        self.aView.alpha = 1;
//    } completion:^(BOOL finished) {
//
//    }];
    
}

+(void)load
{
    NSLog(@"子类load");
}

+(void)initialize
{
    NSLog(@"initialize");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
