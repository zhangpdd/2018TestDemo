//
//  dyModel.h
//  2018TestDemo
//
//  Created by zp on 2018/6/8.
//  Copyright © 2018年 zp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dyModel : NSObject

@property (nonatomic, copy) NSString *cid;


@property(nonatomic,copy)NSString *message_id;///发布说说的id

@property(nonatomic,copy)NSString *message;///发布说说的内容

@property (nonatomic, assign) BOOL isExpand;///发布说说的展开状态

@property(nonatomic,copy)NSString *timeTag;///发布说说的时间标签

@property(nonatomic,copy)NSString *message_type;///发布说说的类型（可能含有视频）

@property(nonatomic,copy)NSString *userId;///发布说说者id

@property(nonatomic,copy)NSString *userName;///发布说说者名字

@property(nonatomic,copy)NSString *photo;///发布说说者头像

@property(nonatomic,copy)NSMutableArray *messageSmallPics;///小图

@property(nonatomic,copy)NSMutableArray *messageBigPics;///大图

@property(nonatomic,copy)NSMutableArray *commentMessages;///评论相关的所有信息

@end
