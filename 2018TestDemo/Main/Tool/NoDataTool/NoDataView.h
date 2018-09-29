//
//  NoDataView.h
//  2018TestDemo
//
//  Created by zp on 2018/4/28.
//  Copyright © 2018年 zp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    BlankPageViewTypeNoData,
    BlankPageViewTypeProject
} BlankPageViewType;


@interface NoDataView : UIView

- (void)configWithType:(BlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(UIButton *sender))block;

@end

@interface UIView (ConfigBlank)

- (void)configBlankPage:(BlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;
@end
