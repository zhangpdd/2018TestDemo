//
//  TestLayout.m
//  JHCollectionViewLayout
//
//  Created by zp on 2019/3/12.
//  Copyright © 2019年 Jivan. All rights reserved.
//

#import "TestLayout.h"

@interface TestLayout()

//所有元素的布局信息
@property (strong, nonatomic) NSMutableArray * attrubutesArray;

/** 存放所有列的当前高度*/
@property (nonatomic,strong) NSMutableArray *columnHeight;

@end
@implementation TestLayout
- (NSMutableArray *)columnHeight
{
    if (!_columnHeight) {
        _columnHeight = [NSMutableArray array];
    }
    return _columnHeight;
}

-(NSMutableArray *)attrubutesArray{
    if (!_attrubutesArray) {
        _attrubutesArray = [NSMutableArray array];
    }
    return _attrubutesArray;
}

//预布局方法 所有的布局应该写在这里面
-(void)prepareLayout
{
    [super prepareLayout];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    //所有列的当前高度(2个)
    [self.columnHeight removeAllObjects];
    for (int i = 0; i < self.columnsCount; i++) {
        [self.columnHeight addObject:@(self.sectionInsets.top)];
    }
    
    [self.attrubutesArray removeAllObjects];
    //得到每个item属性并存储
    for (NSInteger i = 0; i < count; i ++) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes * attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrubutesArray addObject:attributes];
    }
}

//  返回indexPath这个位置Item的布局属性,每次要显示一个新的cell的时候就要调用
//  找到最短的那一列,在这个最短的那一列后面返回一个attribute
 - (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //通过indexpath创建一个item属性
    UICollectionViewLayoutAttributes *temp = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //获取宽度
    CGFloat itemW = (self.collectionView.frame.size.width - self.sectionInsets.left - self.sectionInsets.right-(self.columnsCount * self.interItemSpace))/self.columnsCount;
    //使用for循环,找出高度最短的那一列
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeight[0] doubleValue];
    
    for (NSInteger i = 1; i < self.columnsCount; i++) {
        
        CGFloat columnHeight  =[self.columnHeight[i] doubleValue];
        if (minColumnHeight > columnHeight) {
            
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    
    //高度
    CGFloat itemH = [self.HeightArr[indexPath.row] doubleValue];
    
    CGFloat x = self.sectionInsets.left + destColumn*(itemW + self.interItemSpace);
    CGFloat y = minColumnHeight ;

    if (y != self.sectionInsets.top)
    {
        y += self.lineSpace;
    }
    
    temp.frame = CGRectMake(x,y,itemW,itemH);
    
    self.columnHeight[destColumn] =  @(y+ itemH);
    
    return temp;
}

//返回尺寸
- (CGSize)collectionViewContentSize
{
    CGFloat maxHeight = [[self.columnHeight valueForKeyPath:@"@max.floatValue"] floatValue];
    return CGSizeMake(0, maxHeight+self.sectionInsets.bottom);
}

//返回rect范围内的布局属性
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrubutesArray;
}
@end
