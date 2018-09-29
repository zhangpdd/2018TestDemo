//
//  BackAnimateVC.m
//  2018TestDemo
//
//  Created by zp on 2018/5/17.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "BackAnimateVC.h"
#import "RCAnimatedImagesView.h"

@interface BackAnimateVC ()<RCAnimatedImagesViewDelegate>

@property(retain, nonatomic) RCAnimatedImagesView *animatedImagesView;

@end

@implementation BackAnimateVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    [_animatedImagesView startAnimating];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    
    [_animatedImagesView stopAnimating];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout=UIRectEdgeNone;

    //添加动态图
    self.animatedImagesView = [[RCAnimatedImagesView alloc]
                               initWithFrame:CGRectMake(0, NavTopHeight, FrameW, FrameH-NavTopHeight)];
    [self.view addSubview:_animatedImagesView];
    _animatedImagesView.delegate = self;
    
    [_animatedImagesView startAnimating];
}

- (NSUInteger)animatedImagesNumberOfImages:(RCAnimatedImagesView *)animatedImagesView {
    return 2;
}


- (UIImage *)animatedImagesView:(RCAnimatedImagesView *)animatedImagesView imageAtIndex:(NSUInteger)index {
    return [UIImage imageNamed:@"login_background.png"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
