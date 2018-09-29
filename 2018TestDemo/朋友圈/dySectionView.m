//
//  dySectionView.m
//  2018TestDemo
//
//  Created by zp on 2018/6/8.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "dySectionView.h"
#import "dyModel.h"
#import "DynamicConfigFile.h"
#import "NSString+Category.h"

@interface dySectionView()

@property (strong , nonatomic) UIImageView *headImageView;//头像

@property (strong , nonatomic) UILabel *nameLabel;//名字昵称

@property (strong , nonatomic) UILabel *contentLabel;//说说内容

@property (nonatomic, strong) UIButton *moreBtn;//全文收起

@property (strong , nonatomic) nineView *JGGPictureView;//九宫格图片

@end

@implementation dySectionView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
//        self.headImageView = [[UIImageView alloc] init];
////                self.headImageView.layer.cornerRadius = SectionHeaderHeadSize/2;
////                self.headImageView.layer.masksToBounds = YES;
////                self.headImageView.layer.shouldRasterize = YES;
////                self.headImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
//        [self.contentView addSubview:_headImageView];
//
//        self.nameLabel = [[UILabel alloc] init];
//        _nameLabel.textAlignment = NSTextAlignmentLeft;
//        _nameLabel.textColor = [UIColor orangeColor];
//        _nameLabel.font = [UIFont systemFontOfSize:SectionHeaderNameFontSize];
//        [self.contentView addSubview:_nameLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.font = [UIFont systemFontOfSize:SectionHeaderContentFontSize];
        _contentLabel.numberOfLines = 0;//暂设为不限行数
        [self.contentView addSubview:_contentLabel];
        
        
        
//        self.JGGPictureView = [[nineView alloc] init];
//        [self.contentView addSubview:_JGGPictureView];
        
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
    
//    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.offset(SectionHeaderTopSpace);
//        make.left.offset(SectionHeaderHorizontalSpace);
//        make.width.height.mas_equalTo(SectionHeaderHeadSize);
//    }];
//
//    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakself.headImageView.mas_top).offset(0);
//        make.left.equalTo(weakself.headImageView.mas_right).offset(SectionHeaderHorizontalSpace);
//        make.right.offset(-SectionHeaderHorizontalSpace);
//    }];
    
//    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakself.nameLabel.mas_bottom).offset(SectionHeaderVerticalSpace);
//        make.left.equalTo(weakself.headImageView.mas_right).offset(SectionHeaderHorizontalSpace);
//        make.right.offset(-SectionHeaderHorizontalSpace);
//
//    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(SectionHeaderVerticalSpace*2+SectionHeaderHeadSize);
        make.left.offset(SectionHeaderHorizontalSpace);
        make.right.offset(-SectionHeaderHorizontalSpace);
        
    }];
    
    //    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(weakself.contentLabel.mas_bottom).offset(0);
    //        make.left.equalTo(weakself.headImageView.mas_right).offset(SectionHeaderHorizontalSpace);
    //        make.height.mas_equalTo(SectionHeaderMoreBtnHeight);
    //    }];
    
//    [self.JGGPictureView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakself.contentLabel.mas_bottom).offset(SectionHeaderVerticalSpace);
//        make.left.equalTo(weakself.headImageView.mas_right).offset(SectionHeaderHorizontalSpace);
//        make.right.offset(-SectionHeaderHorizontalSpace);
//    }];
    
    
    
    
    [super updateConstraints];
}





-(void)setModel:(dyModel *)model
{
    __weak __typeof(self) weakSelf = self;
    _model = model;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.photo]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@",model.userName];
    self.contentLabel.text = [NSString stringWithFormat:@"%@",model.message];
    
    
    ///解决图片复用问题
//    [self.JGGPictureView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//
//    [self.JGGPictureView setDataSource:model.messageSmallPics completeBlock:^(NSInteger index) {
//
//        !weakSelf.tapImageBlock ? : weakSelf.tapImageBlock(index);
//
//    }];
//
//    CGFloat JGGHeight = 0;
//
//    if (model.messageSmallPics.count ==0)
//    {
//        JGGHeight = 0;
//
//
//    }else if (model.messageSmallPics.count ==1)
//    {
//        UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey:model.messageSmallPics[0]];
//
//        JGGHeight = FrameW-SectionHeaderHeadSize-SectionHeaderHorizontalSpace*3;
//        // 没有找到已下载的图片。
//        if (!image) {
//
//            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.messageSmallPics[0]]];
//            UIImage *image = [UIImage imageWithData:data];
//
//            CGFloat imghg = image.size.height/2;
//            CGFloat imgwd = image.size.width/2;
//            if (imgwd > (FrameW-SectionHeaderHeadSize-SectionHeaderHorizontalSpace*3)) {
//                JGGHeight = (FrameW-SectionHeaderHeadSize-SectionHeaderHorizontalSpace*3) * imghg/imgwd;
//
//            }else{
//                JGGHeight = imghg;
//            }
//        }else
//        {
//            //手动计算
//            CGFloat imghg = CGImageGetHeight(image.CGImage)/2;
//            CGFloat imgwd = CGImageGetWidth(image.CGImage)/2;
//            if (imgwd > (FrameW-SectionHeaderHeadSize-SectionHeaderHorizontalSpace*3)) {
//                JGGHeight = (FrameW-SectionHeaderHeadSize-SectionHeaderHorizontalSpace*3) * imghg/imgwd;
//
//            }else{
//                JGGHeight = imghg;
//            }
//        }
//
//    }else if (model.messageSmallPics.count>1 && model.messageSmallPics.count <=3)
//    {
//        JGGHeight = SectionHeaderSomePicturesHeight+ SectionHeaderPictureSpace*0;
//
//    }else if (model.messageSmallPics.count>3 && model.messageSmallPics.count <=6)
//    {
//        JGGHeight = SectionHeaderSomePicturesHeight *2 + SectionHeaderPictureSpace*1;
//
//    }else if (model.messageSmallPics.count>6 && model.messageSmallPics.count <=9)
//    {
//        JGGHeight = SectionHeaderSomePicturesHeight *3 + SectionHeaderPictureSpace*2;
//    }
//
//    [self.JGGPictureView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(JGGHeight);
//    }];
//
    
}


@end
