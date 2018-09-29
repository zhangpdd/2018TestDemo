//
//  DynamicSectionFootView.m
//  2018TestDemo
//
//  Created by zp on 2018/5/29.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "DynamicSectionFootView.h"

@implementation DynamicSectionFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        __weak __typeof(self) weakself = self;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakself);
        }];
        
        UIImageView *line = [[UIImageView alloc] init];
        line.backgroundColor = UIColorFromRGB(0Xeeeeee);
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.height.equalTo(@0.5);
        }];
    }
    return self;
}


@end
