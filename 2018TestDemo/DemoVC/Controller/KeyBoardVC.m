//
//  KeyBoardVC.m
//  2018TestDemo
//
//  Created by zp on 2018/7/13.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "KeyBoardVC.h"

@interface KeyBoardVC ()<UITextFieldDelegate>

@property (strong, nonatomic)UITextField *inputField;

@end

@implementation KeyBoardVC

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor redColor];
    
    self.inputField = [[UITextField alloc] init];
    self.inputField.backgroundColor=[UIColor greenColor];
    self.inputField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.inputField.delegate=self;
    [self.view addSubview:self.inputField];
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-100);
        make.left.right.offset(0);
        make.height.mas_equalTo(50);
    }];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}

-(void) keyboardWillShow:(NSNotification *)note {
    
        
    
}

-(void)keyboardDidShow:(NSNotification*)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    // Get the duration of the animation.
    
    NSLog(@"%f",keyboardRect.size.height);
    
    

    //告知需要更改约束
    [self.inputField.superview setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.inputField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(-keyboardRect.size.height);
            
        }];
        [self.inputField.superview layoutIfNeeded];//强制绘制
    }];
    
}

- (void)keyboardWillHide:(NSNotification*)notification {
    NSDictionary* userInfo = [notification userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    CGRect keyboardRect = [animationDurationValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    //告知需要更改约束
    [self.inputField.superview setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.inputField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(-100);
            
        }];
        [self.inputField.superview layoutIfNeeded];//强制绘制
    }];
    
}


//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    // 设置键盘显示和隐藏通知
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillShow:)
//                                                 name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillHide:)
//                                                 name:UIKeyboardWillHideNotification object:nil];
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    // 注销键盘显示和隐藏通知
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//}
//
//-(void)keyboardWillHide:(NSNotification *)notification
//{
//    CGFloat duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
//    [UIView animateWithDuration:duration animations:^{
//        [self.GoodBillTableView setScrollIndicatorInsets:UIEdgeInsetsZero];
//        [self.GoodBillTableView setContentInset:UIEdgeInsetsZero];
//    }];
//    
//}
//
//#pragma mark - Keyboard Notification
//-(void)keyboardWillShow:(NSNotification *)notification
//{
//    CGFloat duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
//    CGRect bounds = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    UIEdgeInsets e = UIEdgeInsetsMake(0, 0, bounds.size.height , 0);
//    [UIView animateWithDuration:duration animations:^{
//        [self.GoodBillTableView setScrollIndicatorInsets:e];
//        [self.GoodBillTableView setContentInset:e];
//        //[self.GoodBillTableView scrollRectToVisible:CGRectZero animated:YES];
//    }];
//    
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
