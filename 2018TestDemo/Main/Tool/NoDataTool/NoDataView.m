//
//  NoDataView.m
//  2018TestDemo
//
//  Created by zp on 2018/4/28.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "NoDataView.h"

@interface NoDataView()
/** 加载按钮 */
@property (weak, nonatomic) UIButton *reloadBtn;
/** 图片 */
@property (weak, nonatomic) UIImageView *imageView;
/** 提示 label */
@property (weak, nonatomic) UILabel *tipLabel;
/** 按钮点击 */
@property (nonatomic, copy) void(^reloadBlock)(UIButton *sender);
@end

@implementation NoDataView

- (UIButton *)reloadBtn
{
    if(!_reloadBtn)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _reloadBtn = btn;
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor lightGrayColor]];
        
        [btn setTitle:@"点击重新加载" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(reloadClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reloadBtn;
}


- (UIImageView *)imageView
{
    if(!_imageView)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        _imageView = imageView;
    }
    return _imageView;
}

- (UILabel *)tipLabel
{
    if(!_tipLabel)
    {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _tipLabel = label;
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor lightGrayColor];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:16];
    }
    return _tipLabel;
}

//当一个控件即将被添加到父控件中会调用
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    self.backgroundColor = newSuperview.backgroundColor;
    NSLog(@"oldSuperview=%@,newSuperview=%@",self,newSuperview);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.left.right.equalTo(self);
            make.top.mas_offset(frame.size.height * 0.3);
        }];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.tipLabel.mas_bottom).offset(10);
            make.centerX.equalTo(self.mas_centerX);
        }];
        
        [self.reloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.imageView.mas_bottom).offset(10);
            make.height.mas_equalTo(44);
        }];
    }
    return self;
}

- (void)configWithType:(BlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(UIButton *sender))block
{
    if (hasData) {
        [self removeFromSuperview];
        return;
    }
    
    self.reloadBtn.hidden = YES;
    self.tipLabel.hidden = YES;
    self.imageView.hidden = YES;
    self.reloadBlock = block;
    
    if (hasError) {
        [self.imageView setImage:[UIImage imageNamed:@"common_noNetWork"]];
        self.tipLabel.text = @"貌似出了点差错";
        self.reloadBtn.hidden = NO;
        self.tipLabel.hidden = NO;
        self.imageView.hidden = NO;
    } else
    {
        switch (blankPageType)
        {
            case BlankPageViewTypeNoData:
            {
                [self.imageView setImage:[UIImage imageNamed:@"common_noRecord"]];
                self.tipLabel.text = @"暂无数据";
            }
                break;
            case BlankPageViewTypeProject:
            {
                [self.imageView setImage:[UIImage imageNamed:@"common_noRecord"]];
                self.tipLabel.text = @"这里还什么都没有";
            }
                break;
                
            default:
                break;
        }
        self.reloadBtn.hidden = NO;
        self.tipLabel.hidden = NO;
        self.imageView.hidden = NO;
        
    }
}

- (void)reloadClick:(UIButton *)btn
{
    !self.reloadBlock ? : self.reloadBlock(btn);
    
//    if (self.reloadBlock)
//    {
//        self.reloadBlock(btn);
//    }
}

@end



//static void *BlankPageViewKey = &BlankPageViewKey;

@implementation UIView (ConfigBlank)

- (void)setBlankPageView:(NoDataView *)blankPageView{
    objc_setAssociatedObject(self, @selector(blankPageView),
                             blankPageView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NoDataView *)blankPageView{
    return objc_getAssociatedObject(self, @selector(blankPageView));
}

- (void)configBlankPage:(BlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block{
    if (hasData)
    {
        if (self.blankPageView)
        {
            self.blankPageView.hidden = YES;
            [self.blankPageView removeFromSuperview];
        }
    }else
    {
        if (!self.blankPageView)
        {
            self.blankPageView = [[NoDataView alloc] initWithFrame:self.bounds];
            
        }
        self.blankPageView.hidden = NO;
        [self addSubview:self.blankPageView];
        [self.blankPageView configWithType:blankPageType hasData:NO hasError:hasError reloadButtonBlock:block];
    }
}



@end
