//
//  TestLayout.h
//  JHCollectionViewLayout
//
//  Created by zp on 2019/3/12.
//  Copyright © 2019年 Jivan. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface TestLayout : UICollectionViewLayout


@property (assign, nonatomic) CGFloat interItemSpace;//水平距离
@property (assign, nonatomic) CGFloat lineSpace;//垂直距离
@property (assign, nonatomic) UIEdgeInsets sectionInsets;//边距
@property (nonatomic, assign) int columnsCount;//显示多少列

/** 存放所有的高度*/
@property (nonatomic,strong) NSMutableArray *HeightArr;
@end

NS_ASSUME_NONNULL_END
