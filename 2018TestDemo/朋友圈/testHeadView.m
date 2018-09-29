//
//  testHeadView.m
//  2018TestDemo
//
//  Created by zp on 2018/6/8.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "testHeadView.h"
#import "dyModel.h"
#import "DynamicConfigFile.h"

@interface testHeadView()

@property (strong , nonatomic) UILabel *contentLabel;//说说内容

@end

@implementation testHeadView
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        __weak __typeof(self) weakself = self;
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakself);
        }];
        
        self.contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.font = [UIFont systemFontOfSize:SectionHeaderContentFontSize];
        _contentLabel.numberOfLines = 0;//暂设为不限行数
        [self.contentView addSubview:_contentLabel];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(SectionHeaderVerticalSpace);
            make.left.offset(SectionHeaderHorizontalSpace);
            make.right.offset(-SectionHeaderHorizontalSpace);
            
        }];
        
        self.contentLabel.text=@"人生四大悲：久旱逢甘雨，一滴；他乡遇故知，债主；洞房花烛夜，隔壁；金榜题名 时，做梦。";
        
    }
    return self;
}



@end
