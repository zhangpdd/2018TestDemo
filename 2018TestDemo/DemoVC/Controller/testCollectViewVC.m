//
//  testCollectViewVC.m
//  JHCollectionViewLayout
//
//  Created by zp on 2019/3/12.
//  Copyright © 2019年 Jivan. All rights reserved.
//

#import "testCollectViewVC.h"
#import "TestLayout.h"
@interface testCollectViewVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *mainCollectionView;

@property (nonatomic,assign) int rowCount;

@property (nonatomic,strong) NSMutableArray* heightArr;

@end

@implementation testCollectViewVC
-(NSArray *)heightArr{
    if(!_heightArr){
        //随机生成高度
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i< self.rowCount; i++) {
            
            [arr addObject:@(arc4random()%100+100)];
        }
        _heightArr = [arr copy];
    }
    return _heightArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.rowCount = 20;
    
    TestLayout* layout = [[TestLayout alloc]init];
    layout.HeightArr = self.heightArr;
    layout.interItemSpace = 10;
    layout.sectionInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.lineSpace = 10;
    layout.columnsCount = 2;
    
    //2.初始化collectionView
    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NavTopHeight, FrameW, FrameH-NavTopHeight) collectionViewLayout:layout];
    
    [self.view addSubview:self.mainCollectionView];
    self.mainCollectionView.backgroundColor = [UIColor clearColor];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [self.mainCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    //4.设置代理
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
}

#pragma mark collectionView代理方法
//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.rowCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor redColor];
    
    return cell;
}

-(void)dealloc
{
    NSLog(@"释放");
}
@end
