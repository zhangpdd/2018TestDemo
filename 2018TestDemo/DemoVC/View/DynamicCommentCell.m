//
//  DynamicCommentCell.m
//  2018TestDemo
//
//  Created by zp on 2018/5/23.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "DynamicCommentCell.h"
#import "DynamicFrameModel.h"
#import "CommentModel.h"
#import "DynamicConfigFile.h"



@interface DynamicCommentCell()

@property (strong , nonatomic) UILabel *commentLabel;//评论内容

@end
@implementation DynamicCommentCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        __weak __typeof(self) weakself = self;
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakself);
        }];
        
        UIImageView *bgImageView = [[UIImageView alloc] init];
        bgImageView.backgroundColor = UIColorFromRGB(0Xeeeeee);
        [self.contentView addSubview:bgImageView];
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.left.offset(SectionHeaderHorizontalSpace*2 + SectionHeaderHeadSize);
            make.right.offset(-SectionHeaderHorizontalSpace);
            make.bottom.offset(0);
        }];
        
        self.commentLabel = [[UILabel alloc] init];
        _commentLabel.textAlignment = NSTextAlignmentLeft;
        _commentLabel.backgroundColor = UIColorFromRGB(0Xeeeeee);
        _commentLabel.textColor = [UIColor blackColor];
        _commentLabel.font = [UIFont systemFontOfSize:SectionHeaderCommentFontSize];
        _commentLabel.numberOfLines = 0;//暂设为不限行数
        [self.contentView addSubview:_commentLabel];
        [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(6);
            make.left.offset(SectionHeaderHorizontalSpace*2 + SectionHeaderHeadSize + 5);
            make.right.offset(-SectionHeaderHorizontalSpace-5);
            //make.bottom.offset(-3);
        }];
    }
    return self;
}


- (void)setModel:(CommentModel *)model
{
    NSString *text = @"";
    
    if (!model.commentUserName || !model.commentByUserName || [[NSString stringWithFormat:@"%@",model.commentByUserId] isEqualToString:model.commentUserId]) {
        text = [NSString stringWithFormat:@"%@: %@", model.commentUserName, model.commentText];
    } else {
        text = [NSString stringWithFormat:@"%@回复%@: %@", model.commentUserName, model.commentByUserName, model.commentText];
    }
    
    self.commentLabel.text = [NSString stringWithFormat:@"%@",text];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
