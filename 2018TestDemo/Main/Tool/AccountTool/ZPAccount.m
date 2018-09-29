//
//  ZPAccount.m
//  ssd
//
//  Created by 张鹏 on 2017/6/12.
//  Copyright © 2017年 zhangpeng. All rights reserved.
//

#import "ZPAccount.h"

@implementation ZPAccount

/**
 *  当从文件中解析出一个对象的时候调用
 *  在这个方法中写清楚：怎么解析文件中的数据
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.contactPhone = [decoder decodeObjectForKey:@"contactPhone"];
        self.icon = [decoder decodeObjectForKey:@"icon"];
        self.nickName = [decoder decodeObjectForKey:@"nickName"];
        self.userId = [decoder decodeObjectForKey:@"userId"];
        self.userType = [decoder decodeObjectForKey:@"userType"];
        self.email = [decoder decodeObjectForKey:@"email"];
        self.userPhone = [decoder decodeObjectForKey:@"userPhone"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 *  在这个方法中写清楚：要存储哪些对象的哪些属性，以及怎样存储属性
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.contactPhone forKey:@"contactPhone"];
    [encoder encodeObject:self.icon forKey:@"icon"];
    [encoder encodeObject:self.nickName forKey:@"nickName"];
    [encoder encodeObject:self.userId forKey:@"userId"];
    [encoder encodeObject:self.userType forKey:@"userType"];
    [encoder encodeObject:self.userPhone forKey:@"userPhone"];
    [encoder encodeObject:self.email forKey:@"email"];
}

// 1 存储账号(需要自己解析)
//NTAccount *account = [[NTAccount alloc]initWithDict:responseObject];
//[NTAccountTool save:account];

//（毋需自己解析）
//ZPAccount *account = [ZPAccount mj_objectWithKeyValues:dataDic];
//[ZPAccountTool save:account];

//ZPAccount *account=[ZPAccountTool account];
//account.signTime=self.time.text;
//[ZPAccountTool save:account];



@end
