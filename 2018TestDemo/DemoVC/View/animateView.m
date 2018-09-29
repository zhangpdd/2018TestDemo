//
//  animateView.m
//  2018TestDemo
//
//  Created by zp on 2018/5/7.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "animateView.h"

@interface animateView()

/** 加载按钮 */
@property (weak, nonatomic) UIButton *reloadBtn;
/** 图片 */
@property (weak, nonatomic) UIImageView *imageView;
/** 提示 label */
@property (weak, nonatomic) UILabel *tipLabel;


@end
@implementation animateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor redColor];
        
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _tipLabel = label;
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor lightGrayColor];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:16];
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.left.right.equalTo(self);
            make.top.mas_offset(frame.size.height * 0.2);
        }];
        
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        _imageView = imageView;
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.tipLabel.mas_bottom).offset(10);
            make.centerX.equalTo(self.mas_centerX);
        }];
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _reloadBtn = btn;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor lightGrayColor]];
        
        [btn setTitle:@"点击消失" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(reloadClick) forControlEvents:UIControlEventTouchUpInside];
        [self.reloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.imageView.mas_bottom).offset(10);
            make.height.mas_equalTo(44);
        }];
        
        [self.imageView setImage:[UIImage imageNamed:@"common_noNetWork"]];
        self.tipLabel.text = @"貌似出了点差错";
    }
    return self;
}

- (void)reloadClick
{
    [UIView animateWithDuration: 0.5 animations:^{
        self.layer.affineTransform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
}


@end
