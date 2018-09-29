//
//  dySectionView.h
//  2018TestDemo
//
//  Created by zp on 2018/6/8.
//  Copyright © 2018年 zp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "nineView.h"

@class dyModel;

@interface dySectionView : UITableViewHeaderFooterView

@property (strong ,nonatomic) dyModel *model;

/**
 *  点击图片的block
 */
@property (nonatomic, copy)TapBlcok tapImageBlock;

@end
