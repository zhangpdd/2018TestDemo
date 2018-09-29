//
//  dyTableViewCell.m
//  2018TestDemo
//
//  Created by zp on 2018/6/29.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "dyTableViewCell.h"
#import "dyModel.h"
#import "DynamicConfigFile.h"

@interface dyTableViewCell()

@property (strong , nonatomic) UILabel *contentLabel;//说说内容

@end
@implementation dyTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        __weak __typeof(self) weakself = self;
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakself);
        }];
        
        self.contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.backgroundColor = [UIColor yellowColor];
        _contentLabel.font = [UIFont systemFontOfSize:SectionHeaderContentFontSize];
        _contentLabel.numberOfLines = 0;//暂设为不限行数
        [self.contentView addSubview:_contentLabel];
    }
    return self;
}

+(BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (void)updateConstraints
{
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(SectionHeaderVerticalSpace);
        make.left.offset(SectionHeaderHorizontalSpace);
        make.right.offset(-SectionHeaderHorizontalSpace);
        make.bottom.offset(-SectionHeaderVerticalSpace);
    }];
    [super updateConstraints];
}
- (void)setUP
{
    self.contentLabel.text=@"人生四大悲：久旱逢甘雨，一滴；他乡遇故知，债主；洞房花烛夜，隔壁；金榜题名 时，做梦。";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
