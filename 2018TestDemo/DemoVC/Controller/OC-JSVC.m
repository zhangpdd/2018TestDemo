//
//  OC-JSVC.m
//  2018TestDemo
//
//  Created by zp on 2018/5/22.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "OC-JSVC.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>

@interface OC_JSVC ()<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@property (nonatomic,weak) JSContext * context;


@end

@implementation OC_JSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, FrameW, 240)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *baseURL = [[NSBundle mainBundle] bundleURL];
    [self.webView loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:baseURL];
    
    
    [self loadUI];
}

- (void)loadUI
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(50, 260, FrameW-100, 40)];
    label.text=@"小红：18870707070";
    [self.view addSubview:label];
    
    
    UIButton *btn1=[[UIButton alloc] initWithFrame:CGRectMake(50, 320, FrameW-100, 50)];
    btn1.tag=123;
    btn1.backgroundColor=[UIColor redColor];
    [btn1 setTitle:@"小黄的手机号" forState:0];
    [self.view addSubview:btn1];
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btn2=[[UIButton alloc] initWithFrame:CGRectMake(50, 380, FrameW-100, 40)];
    btn2.tag=234;
    btn2.backgroundColor=[UIColor redColor];
    [btn2 setTitle:@"打电话给小黄" forState:0];
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btn3=[[UIButton alloc] initWithFrame:CGRectMake(50, 440, FrameW-100, 40)];
    btn3.tag=345;
    btn3.backgroundColor=[UIColor redColor];
    [btn3 setTitle:@"给小黄发短信" forState:0];
    [self.view addSubview:btn3];
    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)btnClick: (UIButton *)sender
{
    //网页加载完成之后调用JS代码才会执行，因为这个时候html页面已经注入到webView中并且可以响应到对应方法
    if (sender.tag == 123) {
        [self.webView stringByEvaluatingJavaScriptFromString:@"alertMobile()"];
    }
    
    if (sender.tag == 234) {
        [self.webView stringByEvaluatingJavaScriptFromString:@"alertName('小红')"];
    }
    
    if (sender.tag == 345) {
        [self.webView stringByEvaluatingJavaScriptFromString:@"alertSendMsg('18870707070','周末爬山真是件愉快的事情')"];
    }
    
    
}

- (void)showMsg:(NSString *)msg {
    [[[UIAlertView alloc] initWithTitle:@"js传值给OC" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
}

#pragma mark - JS调用OC方法列表
- (void)showMobile {
    [self showMsg:@"我是下面的小红 手机号是:18870707070"];
}

- (void)showName:(NSString *)name {
    
    NSString *naem1=[name stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *info = [NSString stringWithFormat:@"我是%@, 很高兴见到你",naem1];
    
    [self showMsg:info];
}

- (void)showSendNumber:(NSString *)num msg:(NSString *)msg {
    
    NSString *num1=[num stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *msg1=[msg stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *info = [NSString stringWithFormat:@"这是我的手机号: %@, %@ !!",num1,msg1];
    
    [self showMsg:info];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    //OC调用JS是基于协议拦截实现的 下面是相关操作
    NSString *absolutePath = request.URL.absoluteString;
    
    NSString *scheme = @"rrcc://";
    
    if ([absolutePath hasPrefix:scheme]) {
        NSString *subPath = [absolutePath substringFromIndex:scheme.length];
        
        if ([subPath containsString:@"?"]) {//1个或多个参数
            
            if ([subPath containsString:@"&"]) {//多个参数
                NSArray *components = [subPath componentsSeparatedByString:@"?"];
                
                NSString *methodName = [components firstObject];
                
                methodName = [methodName stringByReplacingOccurrencesOfString:@"_" withString:@":"];
                SEL sel = NSSelectorFromString(methodName);
                
                NSString *parameter = [components lastObject];
                NSArray *params = [parameter componentsSeparatedByString:@"&"];
                
                if (params.count == 2) {
                    if ([self respondsToSelector:sel]) {
                        [self performSelector:sel withObject:[params firstObject] withObject:[params lastObject]];
                    }
                }
                
                
            } else {//1个参数
                NSArray *components = [subPath componentsSeparatedByString:@"?"];
                
                NSString *methodName = [components firstObject];
                methodName = [methodName stringByReplacingOccurrencesOfString:@"_" withString:@":"];
                SEL sel = NSSelectorFromString(methodName);
                
                NSString *parameter = [components lastObject];
                
                if ([self respondsToSelector:sel]) {
                    [self performSelector:sel withObject:parameter];
                }
                
            }
            
        } else {//没有参数
            NSString *methodName = [subPath stringByReplacingOccurrencesOfString:@"_" withString:@":"];
            SEL sel = NSSelectorFromString(methodName);
            
            if ([self respondsToSelector:sel]) {
                [self performSelector:sel];
            }
        }
    }
    
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"网页加载完毕");
    //获取js的运行环境
    _context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //html调用无参数OC
    _context[@"test1"] = ^(){
        [self menthod1];
    };
    //html调用OC(传参数过来)
    _context[@"test2"] = ^(){
        NSArray * args = [JSContext currentArguments];//传过来的参数
        //        for (id  obj in args) {
        //            NSLog(@"html传过来的参数%@",obj);
        //        }
        NSString * name = args[0];
        
        [self menthod2:name];
    };
    
    _context[@"test3"] = ^(){
        NSArray * args = [JSContext currentArguments];//传过来的参数
        //        for (id  obj in args) {
        //            NSLog(@"html传过来的参数%@",obj);
        //        }
        NSString * name = args[0];
        NSString * str = args[1];
        [self menthod3:name and:str];
    };
    
    //OC调用JS方法
    //1.直接调用
    //    NSString *alertJS=@"alert('test js OC')"; //准备执行的js代码
    //    [_context evaluateScript:alertJS];
    
    
    
}



#pragma 供JS调用的方法
-(void)menthod1{
    NSLog(@"JS调用了无参数OC方法");
    [self showMsg:@"JS调用了无参数OC方法"];
}
-(void)menthod2:(NSString *)str1{
    NSLog(@"%@",str1);
    NSString *info = [NSString stringWithFormat:@"我是%@, 很高兴见到你",str1];
    [self showMsg:info];
}

-(void)menthod3:(NSString *)str1 and:(NSString *)str2{
    NSLog(@"%@++++++%@",str1,str2);
    NSString *info = [NSString stringWithFormat:@"这是我的手机号: %@, %@ !!",str1,str2];
    [self showMsg:info];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
