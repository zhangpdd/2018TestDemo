//
//  FMDBDemoVC.m
//  2018TestDemo
//
//  Created by zp on 2018/9/14.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "FMDBDemoVC.h"
#import <FMDatabase.h>
#import <FMDB.h>
@interface FMDBDemoVC ()

@property(nonatomic, strong) FMDatabase *db;

@end

@implementation FMDBDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int a=9;
    NSNumber *aa=@(a);
   
    
    [self creatBtn];
    [self creatTable];
}

- (void)creatBtn
{
    __weak __typeof(self) weakself = self;
    NSArray *titleArr = [NSArray arrayWithObjects:@"插入数据", @"查询数据",@"修改数据", @"删除数据", nil];
    for (int i =0; i<4; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor redColor];
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.tag = 1000 + i;
        [self.view addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.equalTo(weakself.view.mas_centerX);
            make.top.offset(NavTopHeight+100*i);
            make.size.mas_equalTo(CGSizeMake(100, 50));
        }];
    }
}

- (void)buttonAction: (UIButton *)sender
{
    if (sender.tag == 1000)
    {
        [self insert];
        
    }else if (sender.tag == 1001)
    {
        [self query];
        
    }else if (sender.tag == 1002)
    {
        [self update];
        
    }else if (sender.tag == 1003)
    {
        [self delete];
    }
}

//创建数据库
- (void)creatTable
{
    //1.创建database路径
    NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [docuPath stringByAppendingPathComponent:@"test.db"];
    NSLog(@"!!!dbPath = %@",dbPath);
    
    //2.创建对应路径下数据库
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    
    if ([self isFileExist:@"test.db"])
    {
        //3.在数据库中进行增删改查操作时，需要判断数据库是否open，如果open失败，可能是权限或者资源不足，数据库操作完成通常使用close关闭数据库
        [db open];
        if (![db open]) {
            NSLog(@"数据库打开失败！");
            return;
        }
        
    }else
    {
        //4.数据库中创建表（可创建多张）
        NSString *sql = @"create table if not exists t_student ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,'name' TEXT NOT NULL, 'phone' TEXT NOT NULL,'score' INTEGER NOT NULL)";
        //5.执行更新操作 此处database直接操作，不考虑多线程问题，多线程问题，用FMDatabaseQueue 每次数据库操作之后都会返回bool数值，YES，表示success，NO，表示fail,可以通过 @see lastError @see lastErrorCode @see lastErrorMessage
        BOOL result = [db executeUpdate:sql];
        if (result) {
            NSLog(@"create table success");
            
        }
        [db close];
        
    }
    
    
    self.db = db;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self isExitInTabNew:@"8"];
}

//插入数据
- (void)insert
{
    //插入数据
    NSString *name = [NSString stringWithFormat:@"name-%d", arc4random_uniform(100)];
    int score = arc4random_uniform(100);
    NSString *phone = [NSString stringWithFormat:@"phone-%d", arc4random_uniform(100)];
    //1.executeUpdate:不确定的参数用？来占位（后面参数必须是oc对象，；代表语句结束）
    BOOL result = [self.db executeUpdate:@"INSERT INTO t_student (name, score, phone) VALUES (?,?,?)",name,@(score),phone];
    //2.executeUpdateWithForamat：不确定的参数用%@，%d等来占位 （参数为原始数据类型，执行语句不区分大小写）
    //    BOOL result = [_db executeUpdateWithFormat:@"insert into t_student (name,age, sex) values (%@,%i,%@)",name,age,sex];
    //3.参数是数组的使用方式
    //    BOOL result = [_db executeUpdate:@"INSERT INTO t_student(name,age,sex) VALUES  (?,?,?);" withArgumentsInArray:@[name,@(age),sex]];
    if (result) {
        NSLog(@"插入成功");
    } else {
        NSLog(@"插入失败");
    }
}

//删除数据
- (void)delete
{
    //1.不确定的参数用？来占位 （后面参数必须是oc对象,需要将int包装成OC对象）
    int idNum = 5;
    BOOL result = [_db executeUpdate:@"delete from t_student where id = ?",@(idNum)];
    //2.不确定的参数用%@，%d等来占位
    //BOOL result = [_db executeUpdateWithFormat:@"delete from t_student where name = %@",@"王子涵"];
    if (result) {
        NSLog(@"删除成功");
    } else {
        NSLog(@"删除失败");
    }
    
    //如果表格存在 则销毁
//    BOOL result = [_db executeUpdate:@"drop table if exists t_student"];
//    if (result) {
//        NSLog(@"删除表成功");
//    } else {
//        NSLog(@"删除表失败");
//    }
    
}

//查询
- (void)query
{
    // 1.执行查询语句
    FMResultSet *resultSet = [self.db executeQuery:@"SELECT * FROM t_student"];
    
    // 2.遍历结果
    while ([resultSet next]) {
        int ID = [resultSet intForColumn:@"id"];
        NSString *name = [resultSet stringForColumn:@"name"];
        int score = [resultSet intForColumn:@"score"];
        NSString *phone = [resultSet stringForColumn:@"phone"];
        NSLog(@"%d == %@ == %d == %@", ID, name, score,phone);
    }
}

- (void)update
{
    //修改学生的名字
    NSString *newName = @"李浩宇";
    BOOL result = [self.db executeUpdate:@"update t_student set name = ? where id = ?",newName,@"6"];
    if (result) {
        NSLog(@"修改成功");
    } else {
        NSLog(@"修改失败");
    }
    
}

//判断消息是否存在记录中
- (BOOL)isExitInTabNew:(NSString *)newId
{
    NSString *sql = @"select * from t_student where id = ?";
    FMResultSet *results = [self.db executeQuery:sql,[NSNumber numberWithInt:[newId intValue]]];
    while (results.next)
    {
        if ([newId isEqualToString:[results stringForColumn:@"id"]])
        {
            NSLog(@"存在");
            return YES;
        }
    }
    NSLog(@"不存在");
    return NO;
}


//判断文件是否已经在沙盒中已经存在？
-(BOOL)isFileExist:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    NSLog(@"这个文件是否已经存在：%@",result?@"是的":@"不存在");
    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
