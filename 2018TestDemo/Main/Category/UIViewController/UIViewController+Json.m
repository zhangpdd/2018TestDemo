//
//  UIViewController+Json.m
//  GJXS
//
//  Created by 周鹏 on 2017/7/10.
//  Copyright © 2017年 周鹏. All rights reserved.
//

#import "UIViewController+Json.h"

@implementation UIViewController (Json)

-(NSDictionary *)ConvertToDictionAryWithFileName:(NSString *)name{
    NSError *error;
    
    NSString *dataStr = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"txt"] encoding:NSUTF8StringEncoding error:&error];
    NSData *jsonData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *jerror;
    NSDictionary* Adata = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&jerror];
    return Adata;
}
@end
