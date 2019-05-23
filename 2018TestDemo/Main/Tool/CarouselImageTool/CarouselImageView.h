//
//  CarouselImageView.h
//  2018TestDemo
//
//  Created by zhang peng on 2019/4/10.
//  Copyright © 2019 zp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CarouselImageViewDelegate <NSObject>



@end
@interface CarouselImageView : UIView

/** 初始轮播图（推荐使用） */
- (instancetype)initWithCarouselImageViewFrame:(CGRect)frame delegate:(id<CarouselImageViewDelegate>)delegate placeholderImage:(UIImage *)placeholderImage;

/** 网络加载图片数组 */
@property (strong, nonatomic) NSArray *imageArr;

/** 占位图，用于网络未加载到图片时 */
@property (nonatomic, strong) UIImage *placeholderImage;

@property (weak, nonatomic) id <CarouselImageViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
