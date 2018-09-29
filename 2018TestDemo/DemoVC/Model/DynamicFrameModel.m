//
//  DynamicFrameModel.m
//  2018TestDemo
//
//  Created by zp on 2018/5/24.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "DynamicFrameModel.h"
#import "DynamicModel.h"

#import "DynamicConfigFile.h"
#import "NSString+Category.h"

@implementation DynamicFrameModel

- (NSMutableArray *)loadDatas {
    NSData *messagesData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Data" ofType:@"json"]]];
    NSDictionary *JSONDic = [NSJSONSerialization JSONObjectWithData:messagesData options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *muArray = [NSMutableArray array];
    
    for (NSDictionary *eachDic in JSONDic[@"data"][@"rows"]) {
        
        DynamicFrameModel *framemodel=[[DynamicFrameModel alloc] init];
        framemodel.model =[DynamicModel mj_objectWithKeyValues:eachDic];
        [muArray addObject:framemodel];
    }
    return muArray;
}

- (NSMutableArray *)cellHeightArr
{
    if (!_cellHeightArr){
        _cellHeightArr = [NSMutableArray array];
    }
    return _cellHeightArr;
}

- (void)setModel:(DynamicModel *)model
{
    _model = model;
    // 设置正文的frame
    CGFloat textHeight =  [model.message sizeWithFont:[UIFont systemFontOfSize:SectionHeaderContentFontSize] lineSpacing:SectionHeaderLineSpace maxSize:CGSizeMake(FrameW-SectionHeaderHorizontalSpace*3-SectionHeaderHeadSize, MAXFLOAT)];
    
    CGFloat moreBtnHeight =0;// textHeight > SectionHeaderMaxContentHeight ? SectionHeaderMoreBtnHeight : 0;
    
    //textHeight = textHeight > SectionHeaderMaxContentHeight ? SectionHeaderMaxContentHeight : textHeight;
    
    // 设置配图的frame
    CGFloat JGGHeight = 0;
    if (model.messageSmallPics) {// 有配图
        
        NSArray *arr=[model.messageSmallPics mutableCopy];
        
        if (arr.count==1)
        {
            UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey:model.messageSmallPics[0]];
            
            CGFloat OnePicHeight = FrameW-SectionHeaderHeadSize-SectionHeaderHorizontalSpace*3;
            // 没有找到已下载的图片就使用默认的占位图，当然高度也是默认的高度了。
            if (!image) {
                
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.messageSmallPics[0]]];
                UIImage *image = [UIImage imageWithData:data];
                
                CGFloat imghg = image.size.height/2;
                CGFloat imgwd = image.size.width/2;
                if (imgwd > (FrameW-SectionHeaderHeadSize-SectionHeaderHorizontalSpace*3)) {
                    OnePicHeight = (FrameW-SectionHeaderHeadSize-SectionHeaderHorizontalSpace*3) * imghg/imgwd;
                    
                }else{
                    OnePicHeight = imghg;
                }
            }else
            {
                //手动计算cell
                CGFloat imghg = CGImageGetHeight(image.CGImage)/2;
                CGFloat imgwd = CGImageGetWidth(image.CGImage)/2;
                if (imgwd > (FrameW-SectionHeaderHeadSize-SectionHeaderHorizontalSpace*3)) {
                    OnePicHeight = (FrameW-SectionHeaderHeadSize-SectionHeaderHorizontalSpace*3) * imghg/imgwd;
                    
                }else{
                    OnePicHeight = imghg;
                }
            }
            
            JGGHeight = OnePicHeight;
            
        }else if (arr.count>=2 && arr.count <=3)
        {
            JGGHeight = SectionHeaderSomePicturesHeight *1 + SectionHeaderPictureSpace*0;
        }else if (arr.count>3 && arr.count <=6)
        {
            JGGHeight = SectionHeaderSomePicturesHeight *2 + SectionHeaderPictureSpace*1;
            
        }else if (arr.count>6 && arr.count <=9)
        {
            JGGHeight = SectionHeaderSomePicturesHeight *3 + SectionHeaderPictureSpace*2;
        }

    }
    
    // 行高
    self.HeadViewHeight = SectionHeaderTopSpace + SectionHeaderNameLabelHeight + SectionHeaderVerticalSpace + textHeight + moreBtnHeight +SectionHeaderVerticalSpace+ JGGHeight + SectionHeaderVerticalSpace + SectionHeaderTimeLabelHeight + SectionHeaderBottomSpace;
    
    
    
    for (NSDictionary *dic in model.commentMessages) {
        NSString *text = @"";
        if (![dic valueForKey:@"commentByUserName"] || ![dic valueForKey:@"commentByUserName"] || [[NSString stringWithFormat:@"%@",[dic valueForKey:@"commentByUserId"]] isEqualToString:model.userId]) {
            text = [NSString stringWithFormat:@"%@: %@", [dic valueForKey:@"commentUserName"], [dic valueForKey:@"commentText"]];
        } else {
            text = [NSString stringWithFormat:@"%@回复%@: %@", [dic valueForKey:@"commentUserName"], [dic valueForKey:@"commentByUserName"], [dic valueForKey:@"commentText"]];
        }
        CGFloat commentHeight = [text sizeWithFont:[UIFont systemFontOfSize:SectionHeaderCommentFontSize] lineSpacing:SectionHeaderLineSpace maxSize:CGSizeMake(FrameW-SectionHeaderHorizontalSpace*3-SectionHeaderHeadSize-10, MAXFLOAT)];
        [self.cellHeightArr addObject:@(commentHeight +6)];
    }
}




@end
