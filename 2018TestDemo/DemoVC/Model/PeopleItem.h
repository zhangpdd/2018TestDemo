//
//  PeopleItem.h
//  WeChat1
//
//  Created by Topsky on 2018/5/2.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeopleItem : NSObject

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *phoneNO;
@property (nonatomic, copy) NSString *fullPinyin;

/**
 通过字典来创建一个模型
 
 @param item 字典(可以是NSDictionary、NSData、NSString)
 @return 新建的对象
 */
- (instancetype)initWithItem:(id)item;

@end
