//
//  ChooseVC.m
//  2018TestDemo
//
//  Created by zp on 2018/8/1.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "ChooseVC.h"
#import "ChooseView.h"
#import "ChooseModel.h"
@interface ChooseVC ()
{
    UIButton *leftBtn;
    UIButton *rightBtn;
    NSArray *dataArr;
    NSArray *leftmodelArr;
    NSArray *rightmodelArr;
}

@property (strong , nonatomic) ChooseView *chooseView;

@end

@implementation ChooseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"单选 左下" forState:UIControlStateNormal];
    [leftBtn setTitle:@"单选 左上" forState:UIControlStateSelected];
    leftBtn.backgroundColor = [UIColor cyanColor];
    [leftBtn addTarget:self action:@selector(ToClickLeft) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(NavTopHeight);
        make.left.offset(0);
        make.width.mas_equalTo(FrameW/2);
        make.height.mas_equalTo(50);
    }];
    
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"多选 右下" forState:UIControlStateNormal];
    [rightBtn setTitle:@"多选 右上" forState:UIControlStateSelected];
    rightBtn.backgroundColor = [UIColor orangeColor];
    [rightBtn addTarget:self action:@selector(ToClickRight) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(NavTopHeight);
        make.left.offset(FrameW/2);
        make.width.mas_equalTo(FrameW/2);
        make.height.mas_equalTo(50);
    }];
    
    dataArr = [NSArray array];
    dataArr = @[
               @{
                   @"name" : @"Jack",
                   @"typeID" : @"001",
                   },
               @{
                   @"name" : @"Rose",
                   @"typeID" : @"002",
                   },
               @{
                   @"name" : @"huhu",
                   @"typeID" : @"003",
                   },
               @{
                   @"name" : @"heihei",
                   @"typeID" : @"004",
                   },
               @{
                   @"name" : @"jiejie",
                   @"typeID" : @"005",
                   },
               @{
                   @"name" : @"Rule",
                   @"typeID" : @"006",
                   },
               @{
                   @"name" : @"tager",
                   @"typeID" : @"007",
                   },
               @{
                   @"name" : @"hello",
                   @"typeID" : @"008",
                   }
               ];
    
    leftmodelArr = [NSArray array];
    leftmodelArr = [ChooseModel mj_objectArrayWithKeyValuesArray:dataArr];
    
    rightmodelArr = [NSArray array];
    rightmodelArr = [ChooseModel mj_objectArrayWithKeyValuesArray:dataArr];
    
    self.chooseView = [[ChooseView alloc] init];
    self.chooseView.Column = 1;
    self.chooseView.MultiSelect = YES;
    [self.view addSubview:self.chooseView];
    [self.chooseView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self->leftBtn.mas_bottom).offset(0);
        make.left.right.bottom.offset(0);
    }];

}

-(void)ToClickLeft
{
    self.chooseView.Column = 1;
    self.chooseView.MultiSelect = YES;
    
    self.chooseView.dataArray = [NSMutableArray arrayWithArray:leftmodelArr];
    
    [self.chooseView ShowChooseView];
}

-(void)ToClickRight
{
    self.chooseView.Column = 2;
    self.chooseView.MultiSelect = YES;
    
    self.chooseView.dataArray = [NSMutableArray arrayWithArray:rightmodelArr];
    
    [self.chooseView ShowChooseView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
