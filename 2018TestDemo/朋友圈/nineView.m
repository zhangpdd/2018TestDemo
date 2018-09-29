//
//  nineView.m
//  2018TestDemo
//
//  Created by zp on 2018/6/8.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "nineView.h"
#import <UIImageView+WebCache.h>
#import "DynamicConfigFile.h"

@implementation nineView

-(void)setDataSource:(NSArray *)dataSource completeBlock:(TapBlcok )tapBlock
{
    
    self.backgroundColor=  [UIColor whiteColor];
    CGFloat width=SectionHeaderSomePicturesHeight;
    CGFloat height=width;
    
    self.dataSource=dataSource;
    
    for (NSUInteger i=0; i<dataSource.count; i++)
    {
        UIImageView *iv = [UIImageView new];
        
        [iv sd_setImageWithURL:[NSURL URLWithString:dataSource[i]] placeholderImage:[UIImage imageNamed:@"img_dt"]];
        

        iv.contentMode=UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = YES;
        
        iv.tag = 1000+i;
        iv.userInteractionEnabled = YES;//默认关闭NO，打开就可以接受点击事件
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageAction:)];
        [iv addGestureRecognizer:singleTap];
        
        self.tapBlock = tapBlock;//*/
        
        iv.backgroundColor=UIColorFromRGB(0Xf5f8f9);
        
        [self addSubview:iv];//*/
        //九宫格的布局
        if (dataSource.count ==1)
        {
            UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey:dataSource[0]];
            
            CGFloat OnePicWidth = FrameW-SectionHeaderHeadSize-SectionHeaderHorizontalSpace*3;
            CGFloat OnePicHeight = FrameW-SectionHeaderHeadSize-SectionHeaderHorizontalSpace*3;
            // 没有找到已下载的图片就使用默认的占位图，当然高度也是默认的高度了。
            if (!image) {
                
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:dataSource[0]]];
                UIImage *image = [UIImage imageWithData:data];
                
                CGFloat imghg = image.size.height/2;
                CGFloat imgwd = image.size.width/2;
                if (imgwd > (FrameW-SectionHeaderHeadSize-SectionHeaderHorizontalSpace*3)) {
                    OnePicHeight = (FrameW-SectionHeaderHeadSize-SectionHeaderHorizontalSpace*3) * imghg/imgwd;
                    
                }else{
                    OnePicWidth = imgwd;
                    OnePicHeight = imghg;
                }
            }else
            {
                //手动计算图片高度
                CGFloat imghg = CGImageGetHeight(image.CGImage)/2;
                CGFloat imgwd = CGImageGetWidth(image.CGImage)/2;
                if (imgwd > (FrameW-SectionHeaderHeadSize-SectionHeaderHorizontalSpace*3)) {
                    OnePicHeight = (FrameW-SectionHeaderHeadSize-SectionHeaderHorizontalSpace*3) * imghg/imgwd;
                    
                }else{
                    OnePicWidth = imgwd;
                    OnePicHeight = imghg;
                }
            }
            
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.offset(0);
                make.width.mas_equalTo(OnePicWidth);
                make.height.mas_equalTo(OnePicHeight);
            }];
        }else if (dataSource.count ==4)
        {
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset((i%2)*(SectionHeaderPictureSpace+SectionHeaderSomePicturesHeight));
                make.top.offset((i/2)*(SectionHeaderPictureSpace+SectionHeaderSomePicturesHeight));
                make.size.mas_equalTo(CGSizeMake(width, height));
            }];
        }else
        {
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset((i%3)*(SectionHeaderPictureSpace+SectionHeaderSomePicturesHeight));
                make.top.offset((i/3)*(SectionHeaderPictureSpace+SectionHeaderSomePicturesHeight));
                make.size.mas_equalTo(CGSizeMake(width, height));
            }];
        }
        
        
    }
    
}

-(void)tapImageAction:(UITapGestureRecognizer *)sender{
    
    UIImageView *picture = (UIImageView *)sender.view;;
    
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = picture.tag-1000;
    photoBrowser.imageCount = self.dataSource.count;
    photoBrowser.sourceImagesContainerView = self;
    [photoBrowser show];
    
    !self.tapBlock ? : self.tapBlock(picture.tag-1000);
    
}

#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlString = self.dataSource[index];
    return [NSURL URLWithString:urlString];
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    
    return [self.subviews[index] image];
}

@end
