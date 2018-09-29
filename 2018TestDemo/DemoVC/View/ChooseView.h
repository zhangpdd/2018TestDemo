//
//  ChooseView.h
//  2018TestDemo
//
//  Created by zp on 2018/8/1.
//  Copyright © 2018年 zp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseDelegate <NSObject>

//选中之后调用的方法
- (void)SelectItems: (NSArray *)SelectedItems;

@end

@interface ChooseView : UIView

@property (nonatomic, weak) id <ChooseDelegate>delegate;

//数据源
@property (nonatomic, strong) NSMutableArray *dataArray;

// 是否多选
@property (nonatomic, assign) BOOL MultiSelect;

// 列数
@property (nonatomic, assign) int Column;

//显示选择view
- (void)ShowChooseView;

//隐藏选择view
- (void)HideChooseView;

@end
