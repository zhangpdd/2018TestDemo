//
//  CarouselImageCell.m
//  2018TestDemo
//
//  Created by zhang peng on 2019/4/10.
//  Copyright © 2019 zp. All rights reserved.
//

#import "CarouselImageCell.h"
@interface CarouselImageCell()

//image
@property (strong , nonatomic) UIImageView *CarouselImage;

@end

@implementation CarouselImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.CarouselImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.CarouselImage];
    }
    return self;
}

+(BOOL)requiresConstraintBasedLayout
{
    return YES;
}

-(void)updateConstraints
{
    [self.CarouselImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [super updateConstraints];
}
-(void)setImageURL:(NSString *)imageURL
{
    [self.CarouselImage sd_setImageWithURL:[NSURL URLWithString:imageURL]];
}

@end
