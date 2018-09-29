//
//  CommentModel.h
//  2018TestDemo
//
//  Created by zp on 2018/5/30.
//  Copyright © 2018年 zp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

@property(nonatomic,copy)NSString *commentId;

@property(nonatomic,copy)NSString *commentUserId;

@property(nonatomic,copy)NSString *commentUserName;

@property(nonatomic,copy)NSString *commentPhoto;

@property(nonatomic,copy)NSString *commentText;

@property(nonatomic,copy)NSString *commentByUserId;
@property(nonatomic,copy)NSString *commentByUserName;
@property(nonatomic,copy)NSString *commentByPhoto;
@property(nonatomic,copy)NSString *createDateStr;
@property(nonatomic,copy)NSString *checkStatus;


@end
