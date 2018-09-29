//
//  UIViewController+Json.h
//  GJXS
//
//  Created by 周鹏 on 2017/7/10.
//  Copyright © 2017年 周鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Json)

/**
 获取txt文件类型的字典

 @param name 文件名
 @return 字典
 */
-(NSDictionary *)ConvertToDictionAryWithFileName:(NSString *)name;

@end
