//
//  UserInfoVC.m
//  2018TestDemo
//
//  Created by zp on 2018/5/18.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "UserInfoVC.h"
#import "ZPAccountTool.h"
#import "UIView+Toast.h"
@interface UserInfoVC ()
{
    NSMutableDictionary *dic;
}
@end

@implementation UserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem rightItemWithTitle:@"用户信息" target:self action:@selector(ShowAlert)];
    
    dic=[NSMutableDictionary dictionaryWithDictionary:@{
                                    @"contactPhone":@"123456",
                                    @"icon":@"haha",
                                    @"nickName":@"好的",
                                    @"userId":@"007",
                                    @"userType":@"1",
                                    @"userPhone":@"321654",
                                    @"email":@"152152@145.com",
                                }];
    
    
    UIButton *saveButton=[[UIButton alloc] init];
    [saveButton setTitleColor:UIColorFromRGB(0X9da8cd) forState:UIControlStateNormal];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    saveButton.titleLabel.font=[UIFont boldSystemFontOfSize:ScaleSize*14.5];
    saveButton.backgroundColor=[UIColor grayColor];
    [saveButton addTarget:self action:@selector(ToSave) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(NavTopHeight+ScaleHeight*45);
        make.right.offset(-ScaleWidth*30);
        make.width.offset(ScaleWidth*400);
        make.height.offset(ScaleHeight*200);
        
    }];

    UIButton *deleteButton=[[UIButton alloc] init];
    [deleteButton setTitleColor:UIColorFromRGB(0X9da8cd) forState:UIControlStateNormal];
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    deleteButton.titleLabel.font=[UIFont boldSystemFontOfSize:ScaleSize*14.5];
    deleteButton.backgroundColor=[UIColor grayColor];
    [deleteButton addTarget:self action:@selector(ToDelete) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteButton];
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(NavTopHeight+ScaleHeight*345);
        make.right.offset(-ScaleWidth*30);
        make.width.offset(ScaleWidth*400);
        make.height.offset(ScaleHeight*200);
        
    }];

    
    
    
}

- (void)ShowAlert
{
    //[self.view makeToast:@"hhhhh"];
    
   //
    [self.view makeToast:[NSString stringWithFormat:@"用户信息%@",dic] duration:0.3 position:CSToastPositionCenter];
}

-(void)ToSave
{
    ZPAccount *account=[ZPAccount mj_objectWithKeyValues:dic];
    
    [ZPAccountTool save:account];
    
     [self.view makeToast:[NSString stringWithFormat:@"保存成功Account\n%@\n%@\n%@\n%@\n%@\n%@\n%@",account.contactPhone,account.icon,account.nickName,account.userId,account.userType,account.userPhone,account.email] duration:2.0 position:CSToastPositionCenter];
    
}

-(void)ToDelete
{
    [ZPAccountTool clearUserInfo];
    
    ZPAccount *account=[ZPAccountTool account];
    
    if (account.userPhone.length ==0)
    {
        NSLog(@"hahha1");
    }
    
    [self.view makeToast:@"" duration:2.0 position:CSToastPositionCenter];
    [self.view makeToast:[NSString stringWithFormat:@"删除成功Account\n%@\n%@\n%@\n%@\n%@\n%@\n%@",account.contactPhone,account.icon,account.nickName,account.userId,account.userType,account.userPhone,account.email] duration:2.0 position:CSToastPositionCenter];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
