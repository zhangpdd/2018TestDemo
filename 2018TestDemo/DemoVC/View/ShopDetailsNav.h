//
//  ShopDetailsNav.h
//  2018TestDemo
//
//  Created by zp on 2018/5/21.
//  Copyright © 2018年 zp. All rights reserved.
//
typedef void(^SegmentClickBlock)(NSInteger index);
#import <UIKit/UIKit.h>

@interface ShopDetailsNav : UIView

@property (copy , nonatomic) SegmentClickBlock segMentClick;


-(void)updateFrame: (NSInteger) index;

@end
