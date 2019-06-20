//
//  iCloudManager.h
//  testword
//
//  Created by zhang peng on 2019/5/28.
//  Copyright © 2019 tts.com. All rights reserved.
//
typedef void(^downloadBlock)(id obj);
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface iCloudManager : NSObject

+ (BOOL)iCloudEnable;

+ (void)downloadWithDocumentURL:(NSURL*)url callBack:(downloadBlock)block;

@end

NS_ASSUME_NONNULL_END
