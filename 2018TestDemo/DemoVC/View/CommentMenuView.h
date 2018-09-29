//
//  CommentMenuView.h
//  2018TestDemo
//
//  Created by zp on 2018/5/30.
//  Copyright © 2018年 zp. All rights reserved.
//

typedef void(^likeButtonClickedBlock)(void);
typedef void(^commentButtonClickedBlock)(void);
#import "BaseView.h"

@interface CommentMenuView : BaseView

@property (nonatomic, assign, getter = isShowing) BOOL show;
@property (nonatomic, copy) likeButtonClickedBlock likeblock;
@property (nonatomic, copy) commentButtonClickedBlock commentblock;

-(void)setLikeTitle:(NSString *)title;


@end
