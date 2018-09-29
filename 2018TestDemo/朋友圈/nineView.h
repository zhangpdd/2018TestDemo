//
//  nineView.h
//  2018TestDemo
//
//  Created by zp on 2018/6/8.
//  Copyright © 2018年 zp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDPhotoBrowser.h"

typedef void(^TapBlcok)(NSInteger index);

@interface nineView : UIView<SDPhotoBrowserDelegate>

/**
 *  九宫格显示的数据源
 */
@property (nonatomic, retain)NSArray *dataSource;
/**
 *  TapBlcok
 */
@property (copy, nonatomic) TapBlcok tapBlock;


/**
 *  Description 九宫格
 *  @param jggView NinePicturesView对象
 *  @param dataSource 数据源
 *  @param tapBlock tapBlock点击的block
 
 */
//-(void)JGGView:(NinePictureView *)jggView DataSource:(NSArray *)dataSource completeBlock:(TapBlcok )tapBlock;

-(void)setDataSource:(NSArray *)dataSource completeBlock:(TapBlcok )tapBlock;

@end
