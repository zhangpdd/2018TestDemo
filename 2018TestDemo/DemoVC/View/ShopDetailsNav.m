//
//  ShopDetailsNav.m
//  2018TestDemo
//
//  Created by zp on 2018/5/21.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "ShopDetailsNav.h"

@interface ShopDetailsNav()

@property (strong , nonatomic) UISegmentedControl *segmentedControl;

@property (strong , nonatomic) UIImageView *lineView;

@property (strong , nonatomic) UILabel *detailsLabel;

@end

@implementation ShopDetailsNav

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"商品",@"详情",@"评价",nil];
        self.segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
        // 设置默认选择项索
        self.segmentedControl.selectedSegmentIndex = 0;
        //self.segmentedControl.tintColor = UIColorFromRGB(0X4a5475);
        self.segmentedControl.tintColor = [UIColor clearColor];
        self.segmentedControl.backgroundColor = [UIColor clearColor];

        // 设置UISegmentedControl选中的图片
        //[self.segmentedControl setBackgroundImage:[UIImage imageNamed:@"dzjj_Segment_click"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        // 正常的图片
        //[self.segmentedControl setBackgroundImage:[UIImage imageNamed:@"dzjj_Segment_bg"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        // 设置选中的文字颜色
        [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColorFromRGB(0Xc3c0ff),NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:UIControlStateSelected];
        [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColorFromRGB(0X232323),NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:UIControlStateNormal];
        //点击事件
        [self.segmentedControl addTarget:self action:@selector(ClickAction:)forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.segmentedControl];
        
        self.lineView = [[UIImageView alloc] init];
        self.lineView.backgroundColor=UIColorFromRGB(0Xc3c0ff);
        [self addSubview:self.lineView];
       
        self.detailsLabel = [[UILabel alloc] init];
        self.detailsLabel.textAlignment=NSTextAlignmentCenter;
        self.detailsLabel.textColor=UIColorFromRGB(0X232323);
        self.detailsLabel.font=[UIFont systemFontOfSize:16];
        self.detailsLabel.text=@"图文详情";
        [self addSubview:self.detailsLabel];
        
        self.segmentedControl.frame = CGRectMake(0, 0, 150, 44);
        
        self.lineView.frame = CGRectMake(0, 42, 50, 2);
        
        self.detailsLabel.frame = CGRectMake(0, 44, 150, 44);
        
    }
    return self;
}



- (void)ClickAction:(UISegmentedControl *)Seg
{
    !self.segMentClick ? : self.segMentClick(Seg.selectedSegmentIndex);
}

- (void)updateFrame:(NSInteger)index
{

    
    if (index==3 || index ==4)
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            self.segmentedControl.frame = CGRectMake(0, -44*(4-index), 150, 44);
            
            self.lineView.frame = CGRectMake(0, 42-44*(4-index), 50, 2);
            
            self.detailsLabel.frame = CGRectMake(0, 44-44*(4-index), 150, 44);
            
        }];
        
        return;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.lineView.frame = CGRectMake(50*index, 42, 50, 2);
        self.segmentedControl.selectedSegmentIndex=index;
    }];
    
}

@end
