//
//  ZZDocument.m
//  testword
//
//  Created by zhang peng on 2019/5/28.
//  Copyright © 2019 tts.com. All rights reserved.
//

#import "ZZDocument.h"

@implementation ZZDocument


- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError {
    self.data = contents;
    return YES;
}

@end
