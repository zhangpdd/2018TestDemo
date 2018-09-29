//
//  ChooseCollectionCell.m
//  2018TestDemo
//
//  Created by zp on 2018/8/1.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "ChooseCollectionCell.h"
#import "ChooseModel.h"
@interface ChooseCollectionCell()

//选项
@property (strong , nonatomic) UILabel *titleLabel;
//选中image
@property (strong , nonatomic) UIImageView *selectImage;

@end

@implementation ChooseCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = Font16;
        [self.contentView addSubview:self.titleLabel];
        
        self.selectImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.selectImage];
    }
    return self;
}

+(BOOL)requiresConstraintBasedLayout
{
    return YES;
}

-(void)updateConstraints
{
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.offset(0);
        make.left.offset(20);
        make.right.offset(-50);
    }];
    
    [self.selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.contentView);
        make.right.offset(-20);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
    }];
    [super updateConstraints];
}

- (void)setModel:(ChooseModel *)model
{
    self.titleLabel.text = [NSString stringWithFormat:@"%@--%@",model.name,model.typeID];
    NSString *imageNameStr = model.isSelect ? @"choose_select" : @"";
    self.selectImage.image = [UIImage imageNamed:imageNameStr];
}

@end
