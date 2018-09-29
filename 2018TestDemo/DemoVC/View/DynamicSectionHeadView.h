//
//  DynamicSectionHeadView.h
//  2018TestDemo
//
//  Created by zp on 2018/5/23.
//  Copyright © 2018年 zp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NinePictureView.h"
#import "CommentMenuView.h"
@class DynamicModel;
@interface DynamicSectionHeadView : UITableViewHeaderFooterView

@property (strong ,nonatomic) DynamicModel *model;

/**
 *  点击图片的block
 */
@property (nonatomic, copy)TapBlcok tapImageBlock;

/**
 *  点赞的block
 */
@property (nonatomic, copy)likeButtonClickedBlock praiseBlock;

/**
 *  评论的block
 */
@property (nonatomic, copy)commentButtonClickedBlock commentBlock;
@end
