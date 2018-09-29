//
//  ChooseView.m
//  2018TestDemo
//
//  Created by zp on 2018/8/1.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "ChooseView.h"
#import "ChooseCollectionCell.h"
#import "ChooseModel.h"
@interface ChooseView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//面料列表
@property (nonatomic, strong) UICollectionView *collectionView;
//上次选中
@property (nonatomic, assign) NSInteger lastIndex;
//本次选中
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation ChooseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _lastIndex=0;
        _selectedIndex=0;
        
        self.clipsToBounds = YES;
    }
    return self;
}

-(void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    ChooseModel *model=dataArray[_selectedIndex];
    model.isSelect=YES;
    [self.collectionView reloadData];
}


#pragma mark - 动画显示
- (void)ShowChooseView
{
    self.hidden = NO;
    //告知需要更改约束
    [self.collectionView.superview setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.top.offset(0);
        }];
        //告知父类控件绘制，不添加注释的这两行的代码无法生效
        [self.collectionView.superview layoutIfNeeded];
        
    }];
}

#pragma mark - 动画消失
- (void)HideChooseView
{
    CGFloat height = (self.dataArray.count*50) >300 ? 300 : self.dataArray.count*50;
    //告知需要更改约束
    [self.collectionView.superview setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.5 animations:^{
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.offset(-height);
        }];
        
        //告知父类控件绘制，不添加注释的这两行的代码无法生效
        [self.collectionView.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

#pragma mark - section数量
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark - cell数量
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

#pragma mark - 定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath
{
    if (self.Column>0)
    {
        return CGSizeMake(FrameW/self.Column,50);
    }else
        return CGSizeMake(FrameW,50);
    
}

#pragma mark - cell初始化
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"oneLineCell" forIndexPath:indexPath];
    if (_dataArray.count && indexPath.row < _dataArray.count)
    {
        ChooseModel *model = _dataArray[indexPath.row];
        
        cell.model = model;
    }
    return cell;
}


#pragma mark - 点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedIndex = indexPath.row;
    if (_selectedIndex != _lastIndex)
    {
        ChooseModel *model = _dataArray[_selectedIndex];
        model.isSelect = !model.isSelect;
        
        ChooseModel *lastModel = _dataArray[_lastIndex];
        lastModel.isSelect = !lastModel.isSelect;
        
        [_collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:_lastIndex inSection:0],[NSIndexPath indexPathForRow:_selectedIndex inSection:0], nil]];
        
    }else
    {
        ChooseModel *model = _dataArray[_selectedIndex];
        model.isSelect = YES;
        [_collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:_selectedIndex inSection:0], nil]];
    }
    _lastIndex = _selectedIndex;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self HideChooseView];
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
        //[layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        //设置headerView的尺寸大小
        //layout.headerReferenceSize = CGSizeMake(MainScreenWidth, 40);
        //设置footerView的尺寸大小
        //layout.footerReferenceSize = CGSizeMake(ScreenWidth, ScaleHeight*1020);
        //设置itemSize
        //layout.itemSize =CGSizeMake(FrameW,50);
        //水平方向的间距
        layout.minimumInteritemSpacing = 0;
        //垂直方向的间距
        layout.minimumLineSpacing = 0;
        //定义UICollectionView 的边距
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        //2.初始化collectionView
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        
        CGFloat height = (self.dataArray.count*50) >300 ? 300 : self.dataArray.count*50;
        [self addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.offset(-height);
            make.left.right.offset(0);
            make.height.mas_equalTo(height);
        }];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        //取消弹性效果
        //_collectionView.bounces = NO;
        //禁止右侧滚动条
        _collectionView.showsVerticalScrollIndicator = YES;
        //设置允许多选
        //_collectionView.allowsMultipleSelection = YES;
        
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [_collectionView registerClass:[ChooseCollectionCell class] forCellWithReuseIdentifier:@"oneLineCell"];
        
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
}


@end
