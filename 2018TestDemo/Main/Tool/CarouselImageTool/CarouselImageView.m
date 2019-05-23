//
//  CarouselImageView.m
//  2018TestDemo
//
//  Created by zhang peng on 2019/4/10.
//  Copyright © 2019 zp. All rights reserved.
//

#import "CarouselImageView.h"
#import "CarouselImageCell.h"

@interface CarouselImageView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;

@end
@implementation CarouselImageView

- (instancetype)initWithCarouselImageViewFrame:(CGRect)frame delegate:(id<CarouselImageViewDelegate>)delegate placeholderImage:(UIImage *)placeholderImage
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        self.placeholderImage = placeholderImage;
        self.collectionView.frame = self.bounds;
        [self addSubview:self.collectionView];
        
        //NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
        //[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        
    }
    return self;
}

- (void)automaticScroll
{
    int targetIndex = self.imageArr.count * 0.5;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
}

 - (void)setImageArr:(NSArray *)imageArr
{
    NSMutableArray *arr= [NSMutableArray arrayWithArray:imageArr];
    [arr addObject:[imageArr firstObject]];
    [arr insertObject:[imageArr lastObject] atIndex:0];
    _imageArr = arr;
    [self.collectionView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}


#pragma mark - cell数量
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArr.count;
}

#pragma mark - cell初始化
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CarouselImageCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CarouselImageCell" forIndexPath:indexPath];
    if (self.imageArr.count && indexPath.row < self.imageArr.count)
    {
        cell.imageURL = self.imageArr[indexPath.row];
    }
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = self.frame.size.width;
    NSInteger index = scrollView.contentOffset.x / width;
    
    //当滚动到最后一张图片时，继续滚向后动跳到第一张
    if (index == self.imageArr.count - 1)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        return;
    }
    
    //当滚动到第一张图片时，继续向前滚动跳到最后一张
    //当且仅当滚过第0张图片的一半的时候，滚动到最后一张
    if (scrollView.contentOffset.x <= 0){
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.imageArr.count-2 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        return;
    }
}



#pragma mark - 点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}


/**
 collection懒加载
 
 @return collectionView
 */
-(UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        //设置headerView的尺寸大小
        //layout.headerReferenceSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        //设置footerView的尺寸大小
        //layout.footerReferenceSize = CGSizeMake(ScreenWidth, ScaleHeight*1020);
        //设置itemSize
        layout.itemSize =CGSizeMake(self.frame.size.width, self.frame.size.height);
        //水平方向的间距
        layout.minimumInteritemSpacing = 0;
        //垂直方向的间距
        layout.minimumLineSpacing = 0;
        //定义UICollectionView 的边距
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        //2.初始化collectionView
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        //页码滚动
        _collectionView.pagingEnabled = YES;
        
        //CGFloat height = (self.dataArray.count*50) >300 ? 300 : self.dataArray.count*50;
        [self addSubview:_collectionView];
//        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.top.offset(-height);
//            make.left.right.offset(0);
//            make.height.mas_equalTo(height);
//        }];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        //取消弹性效果
        //_collectionView.bounces = NO;
        //禁止右侧滚动条
        _collectionView.showsHorizontalScrollIndicator = NO;
        //设置允许多选
        //_collectionView.allowsMultipleSelection = YES;
        
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [_collectionView registerClass:[CarouselImageCell class] forCellWithReuseIdentifier:@"CarouselImageCell"];
        
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
}



@end
