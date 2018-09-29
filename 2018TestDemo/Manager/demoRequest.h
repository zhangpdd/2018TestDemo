//
//  demoRequest.h
//  2018TestDemo
//
//  Created by zp on 2018/6/6.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "HttpRequestTool.h"
@class DynamicModel;
@interface demoRequest : HttpRequestTool

/**
 主页列表
 
 @param pageNum 页码
 @param pageSize 每页数量
 @param succeededBlock 成功执行操作
 @param failedBlock 失败执行操作
 */
+(void)getStatusListPageNum:(NSString *)pageNum
                   PageSize:(NSString *)pageSize
             SucceededBlock:(void(^)(id responseObject))succeededBlock
                failedBlock:(ZPNetworkFailedBlock)failedBlock;



@end
