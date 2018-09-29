//
//  DynamicCommentCell.h
//  2018TestDemo
//
//  Created by zp on 2018/5/23.
//  Copyright © 2018年 zp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommentModel;

@interface DynamicCommentCell : UITableViewCell

@property (strong , nonatomic) CommentModel *model;

@end
