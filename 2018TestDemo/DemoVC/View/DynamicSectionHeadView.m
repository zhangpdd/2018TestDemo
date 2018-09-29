//
//  DynamicSectionHeadView.m
//  2018TestDemo
//
//  Created by zp on 2018/5/23.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "DynamicSectionHeadView.h"
#import "DynamicModel.h"
#import "DynamicConfigFile.h"
#import "NSString+Category.h"
@interface DynamicSectionHeadView()

@property (strong , nonatomic) UIImageView *headImageView;//头像

@property (strong , nonatomic) UILabel *nameLabel;//名字昵称

@property (strong , nonatomic) UILabel *contentLabel;//说说内容

@property (nonatomic, strong) UIButton *moreBtn;//全文收起

@property (strong , nonatomic) NinePictureView *JGGPictureView;//九宫格图片

@property (nonatomic, strong) UILabel *timeLabel;//时间

@property (nonatomic, strong) UIButton *commentBtn;//点击弹出菜单

@property (nonatomic, strong) UIImageView *corner;//小尖角

@property (nonatomic, strong) CommentMenuView *menuView;//评论点赞

@end
@implementation DynamicSectionHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.headImageView = [[UIImageView alloc] init];
//        self.headImageView.layer.cornerRadius = SectionHeaderHeadSize/2;
//        self.headImageView.layer.masksToBounds = YES;
//        self.headImageView.layer.shouldRasterize = YES;
//        self.headImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        [self.contentView addSubview:_headImageView];
        
        self.nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = [UIColor orangeColor];
        _nameLabel.font = [UIFont systemFontOfSize:SectionHeaderNameFontSize];
        [self.contentView addSubview:_nameLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.font = [UIFont systemFontOfSize:SectionHeaderContentFontSize];
        _contentLabel.numberOfLines = 0;//暂设为不限行数
        [self.contentView addSubview:_contentLabel];
        
        self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setTitleColor:UIColorFromRGB(0X5E8CC1) forState:UIControlStateNormal];
        [_moreBtn setTitle:@"全文" forState:UIControlStateNormal];
        [_moreBtn setTitle:@"全文" forState:UIControlStateSelected];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:SectionHeaderContentFontSize];
        [_moreBtn addTarget:self action:@selector(clickMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
        //[self.contentView addSubview:_moreBtn];
        
        self.JGGPictureView = [[NinePictureView alloc] init];
        [self.contentView addSubview:_JGGPictureView];
        
        self.timeLabel = [[UILabel alloc] init];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = [UIFont systemFontOfSize:SectionHeaderTimeFontSize];
        [self.contentView addSubview:_timeLabel];
        
        self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn setImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
        [_commentBtn addTarget:self action:@selector(clickCommentBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_commentBtn];
        
        self.corner = [[UIImageView alloc] init];
        _corner.backgroundColor = UIColorFromRGB(0Xeeeeee);
        //x改成你要的角度 順時針90就用90 逆時針90就用-90 无论是M_PI还是-M_PI都是逆时针旋转
        CGAffineTransform transform = CGAffineTransformMakeRotation(45 * M_PI/180.0);
        [_corner setTransform:transform];
        [self.contentView addSubview:_corner];
        
        self.menuView = [CommentMenuView new];
        [self.contentView addSubview:_menuView];
        
        __weak typeof(self) weakSelf = self;
        
        
        self.menuView.likeblock = ^{
           
             !weakSelf.praiseBlock ? : weakSelf.praiseBlock();
        };
        
        self.menuView.commentblock = ^{
            
             !weakSelf.commentBlock ? : weakSelf.commentBlock();
        };
        

        
    }
    return self;
}

+(BOOL)requiresConstraintBasedLayout{
    
    return YES;
}

- (void)updateConstraints
{
    __weak __typeof(self) weakself = self;
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakself);
    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(SectionHeaderTopSpace);
        make.left.offset(SectionHeaderHorizontalSpace);
        make.width.height.mas_equalTo(SectionHeaderHeadSize);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.headImageView.mas_top).offset(0);
        make.left.equalTo(weakself.headImageView.mas_right).offset(SectionHeaderHorizontalSpace);
        make.right.offset(-SectionHeaderHorizontalSpace);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.nameLabel.mas_bottom).offset(SectionHeaderVerticalSpace);
        make.left.equalTo(weakself.headImageView.mas_right).offset(SectionHeaderHorizontalSpace);
        make.right.offset(-SectionHeaderHorizontalSpace);
        
    }];
    
//    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakself.contentLabel.mas_bottom).offset(0);
//        make.left.equalTo(weakself.headImageView.mas_right).offset(SectionHeaderHorizontalSpace);
//        make.height.mas_equalTo(SectionHeaderMoreBtnHeight);
//    }];
    
    [self.JGGPictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.contentLabel.mas_bottom).offset(SectionHeaderVerticalSpace);
        make.left.equalTo(weakself.headImageView.mas_right).offset(SectionHeaderHorizontalSpace);
        make.right.offset(-SectionHeaderHorizontalSpace);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.JGGPictureView.mas_bottom).offset(SectionHeaderHorizontalSpace);
        make.left.equalTo(weakself.headImageView.mas_right).offset(SectionHeaderHorizontalSpace);
        make.right.offset(-SectionHeaderHorizontalSpace);
    }];
    
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.timeLabel.mas_top).offset(-SectionHeaderPictureSpace);
        make.right.offset(-SectionHeaderHorizontalSpace);
        make.width.equalTo(@(30));
        make.height.equalTo(@(25));
        
    }];
    
    
    [self.menuView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@32);
        make.centerY.equalTo(self.commentBtn);
        make.right.equalTo(self.commentBtn.mas_left);
        make.width.equalTo(@0);
    }];

    [self.corner mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).offset(6);
        make.width.height.equalTo(@8);
        make.left.equalTo(self.timeLabel.mas_left).offset(SectionHeaderHorizontalSpace);
    }];
    
    [super updateConstraints];
}

- (void)clickCommentBtn:(UIButton *)button {
    
    self.menuView.show = !self.menuView.isShowing;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.menuView.isShowing) {
        self.menuView.show = NO;
    }
}

-(void)setModel:(DynamicModel *)model
{
    __weak __typeof(self) weakSelf = self;
    _model = model;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.photo]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@",model.userName];
    self.contentLabel.text = [NSString stringWithFormat:@"%@",model.message];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",model.timeTag];
    
//    CGFloat contentHeight = [model.message sizeWithFont:[UIFont systemFontOfSize:SectionHeaderContentFontSize] lineSpacing:SectionHeaderLineSpace maxSize:CGSizeMake(FrameW-SectionHeaderHorizontalSpace*3-SectionHeaderHeadSize, MAXFLOAT)];
//    if (contentHeight > SectionHeaderMaxContentHeight)
//    {
//        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(SectionHeaderMaxContentHeight);
//        }];
//
//        [self.moreBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(SectionHeaderMoreBtnHeight);
//        }];
//
//    }else
//    {
//        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(contentHeight);
//        }];
//        [self.moreBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(0);
//        }];
//    }
//    self.moreBtn.hidden = (contentHeight > SectionHeaderMaxContentHeight) ? 0 : 1;
    
    
    ///解决图片复用问题
    [self.JGGPictureView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.JGGPictureView setDataSource:model.messageSmallPics completeBlock:^(NSInteger index) {
        
        !weakSelf.tapImageBlock ? : weakSelf.tapImageBlock(index);
       
    }];
    
    CGFloat JGGHeight = 0;
    
    if (model.messageSmallPics.count ==0)
    {
        JGGHeight = 0;
       
        
    }else if (model.messageSmallPics.count ==1)
    {
        UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey:model.messageSmallPics[0]];
        
        JGGHeight = FrameW-SectionHeaderHeadSize-SectionHeaderHorizontalSpace*3;
        // 没有找到已下载的图片。
        if (!image) {
    
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.messageSmallPics[0]]];
            UIImage *image = [UIImage imageWithData:data];
            
            CGFloat imghg = image.size.height/2;
            CGFloat imgwd = image.size.width/2;
            if (imgwd > (FrameW-SectionHeaderHeadSize-SectionHeaderHorizontalSpace*3)) {
                JGGHeight = (FrameW-SectionHeaderHeadSize-SectionHeaderHorizontalSpace*3) * imghg/imgwd;
                
            }else{
                JGGHeight = imghg;
            }
        }else
        {
            //手动计算
            CGFloat imghg = CGImageGetHeight(image.CGImage)/2;
            CGFloat imgwd = CGImageGetWidth(image.CGImage)/2;
            if (imgwd > (FrameW-SectionHeaderHeadSize-SectionHeaderHorizontalSpace*3)) {
                JGGHeight = (FrameW-SectionHeaderHeadSize-SectionHeaderHorizontalSpace*3) * imghg/imgwd;
                
            }else{
                JGGHeight = imghg;
            }
        }
        
    }else if (model.messageSmallPics.count>=2 && model.messageSmallPics.count <=3)
    {
        JGGHeight = SectionHeaderSomePicturesHeight+ SectionHeaderPictureSpace*0;
        
    }else if (model.messageSmallPics.count>3 && model.messageSmallPics.count <=6)
    {
        JGGHeight = SectionHeaderSomePicturesHeight *2 + SectionHeaderPictureSpace*1;
        
    }else if (model.messageSmallPics.count>6 && model.messageSmallPics.count <=9)
    {
        JGGHeight = SectionHeaderSomePicturesHeight *3 + SectionHeaderPictureSpace*2;
    }
    
    [self.JGGPictureView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(JGGHeight);
    }];
    
    if (model.commentMessages.count > 0 || model.commentMessages.count > 0) {
        self.corner.hidden = NO;
        
    } else {
        self.corner.hidden = YES;
    }
}

- (void)clickMoreBtn:(UIButton *)button {
    
    self.model.isExpand = !self.model.isExpand;
    if (self.model.isExpand) {
        [button setTitle:@"收起" forState:UIControlStateNormal];
    } else {
        [button setTitle:@"全文" forState:UIControlStateNormal];
    }
//    if ([_delegate respondsToSelector:@selector(spreadContent: section:)]) {
//        [_delegate spreadContent:!self.item.isSpread section:self.section];
//    }
}

@end
