//
//  demoRequest.m
//  2018TestDemo
//
//  Created by zp on 2018/6/6.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "demoRequest.h"

#define ZttURL [NSString stringWithFormat:@"https://www.apiopen.top/"]
//获取主题列表
#define GetTopics_URL [ZttURL stringByAppendingString:@"satinApi"]

@implementation demoRequest

+(void)getStatusListPageNum:(NSString *)pageNum
                   PageSize:(NSString *)pageSize
             SucceededBlock:(void(^)(id responseObject))succeededBlock
                failedBlock:(ZPNetworkFailedBlock)failedBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:pageNum forKey:@"page"];
    [params setObject:pageSize forKey:@"type"];
    
    [self POST:GetTopics_URL parameters:params progress:nil success:^(id responseObject) {
        
        
            if (responseObject && [responseObject isKindOfClass:[NSDictionary class]])
            {
                //字典转模型，处理之后传回数据
                !succeededBlock ? : succeededBlock(responseObject);
            }
        
    } failure:^(NSError *error) {
        
        !failedBlock ? : failedBlock(error);
    }];
    
    
//    [self GET:GetTopics_URL parameters:params progress:nil succeed:^(id data) {
//
//        if (succeededBlock)
//        {
//            //字典转模型，处理之后传回数据
//            succeededBlock(data);
//        }
//
//    } failure:^(NSError *error) {
//        if (failedBlock)
//        {
//            failedBlock(error);
//        }
//    }];
    
}
@end
