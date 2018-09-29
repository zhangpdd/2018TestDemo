//
//  ZPAccount.h
//  ssd
//
//  Created by 张鹏 on 2017/6/12.
//  Copyright © 2017年 zhangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZPAccount : NSObject<NSCoding>

@property(nonatomic,copy)NSString *contactPhone;

@property(nonatomic,copy)NSString *icon;

@property(nonatomic,copy)NSString *nickName;

@property(nonatomic,copy)NSString *userId;

@property(nonatomic,copy)NSString *userType;

@property(nonatomic,copy)NSString *userPhone;

@property(nonatomic,copy)NSString *email;


@end
