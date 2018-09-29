//
//  DynamicFrameModel.h
//  2018TestDemo
//
//  Created by zp on 2018/5/24.
//  Copyright © 2018年 zp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DynamicModel;
@interface DynamicFrameModel : NSObject


/**
 27  *  行高
 28  */
@property (nonatomic, assign) CGFloat HeadViewHeight;

/**
 27  *  行高数组
 28  */
@property (nonatomic, strong) NSMutableArray *cellHeightArr;

/**
 32  *  模型数据
 33  */
@property (nonatomic, strong) DynamicModel *model;

/**
 加载数据

 @return 模型数组
 */
- (NSMutableArray *)loadDatas;

@end
