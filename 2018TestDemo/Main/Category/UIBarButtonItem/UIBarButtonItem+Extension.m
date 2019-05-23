//
//  UIBarButtonItem+Extension.m

//
//  Created by 👄 on 15/9/14.
//  Copyright (c) 2015年 sczy. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+BGFrame.h"
@implementation BackView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    UINavigationBar *navBar = nil;
    UIView *aView = self.superview;
    while (aView) {
        if ([aView isKindOfClass:[UINavigationBar class]]) {
            navBar = (UINavigationBar *)aView;
            break;
        }
        aView = aView.superview;
    }
    UINavigationItem * navItem =   (UINavigationItem *)navBar.items.lastObject;
    UIBarButtonItem *leftItem = navItem.leftBarButtonItem;
    UIBarButtonItem *rightItem = navItem.rightBarButtonItem;
    
    
    if (rightItem) {//右边按钮
        BackView *backView = rightItem.customView;
        if ([backView isKindOfClass:self.class]) {
            backView.btn.left = backView.width -backView.btn.width;
        }
    }
    if (leftItem) {//左边按钮
        BackView *backView = leftItem.customView;
        if ([backView isKindOfClass:self.class]) {
            backView.btn.left = 0;
        }
    }
}



@end

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action {
    BackView *customView = [[BackView alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [customView addGestureRecognizer:tap];
    customView.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    customView.btn.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:16.0];
    if (icon) {
        [customView.btn setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    }
    if (highIcon) {
        [customView.btn setBackgroundImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    }
    customView.btn.frame = CGRectMake(0, 0, customView.btn.currentBackgroundImage.size.width, customView.btn.currentBackgroundImage.size.height);
    customView.btn.centerY = customView.centerY;
    [customView.btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:customView.btn];
    return  [[UIBarButtonItem alloc] initWithCustomView:customView];
}

+(UIBarButtonItem *)leftItemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:16.0];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    btn.frame = CGRectMake(0, 0, title.length * 18, 30);
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)rightItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:16.0];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15);
    btn.frame = CGRectMake(0, 0, title.length * 18, 30);
    [btn setEnlargeEdgeWithTop:0 right:20 bottom:0 left:0];
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}


@end
