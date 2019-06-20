//
//  WkHeightVC.m
//  2018TestDemo
//
//  Created by zp on 2018/9/21.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "WkHeightVC.h"
#import <WebKit/WebKit.h>

#define requestUrl @"https://www.91jf.com/newweb/index.php?tpl=wap&url=main&act=photo_vip"//@"http://shop.jiaoyizhao.com/html/desc.html"//

@interface WkHeightVC ()

@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) WKWebView *wkWebView;

@end

@implementation WkHeightVC
- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,CGFLOAT_MIN)];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestUrl]];
        request.timeoutInterval = 15.0f;
        [_wkWebView loadRequest:request];
        
        [self.view addSubview:_wkWebView];
        
    }
    return _wkWebView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"正在获取ContentHeight...";
    
    //初始化progressView
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, NavTopHeight+5, self.view.frame.size.width, 2)];
    self.progressView.progressTintColor = [UIColor blueColor];
    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.view addSubview:self.progressView];
    
    
    /*
     *3.添加KVO，WKWebView有一个属性estimatedProgress，就是当前网页加载的进度，所以监听这个属性。
     */
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    UITextView *ruleTextView = [[UITextView alloc] init];
    ruleTextView.backgroundColor = [UIColor whiteColor];
    ruleTextView.editable = NO;//不可编辑
    ruleTextView.textColor = [UIColor blackColor];
    
    if (@available(iOS 11.0, *)) {
        ruleTextView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    ruleTextView.frame = CGRectMake(0, NavTopHeight, FrameW, FrameH-NavTopHeight);
    [self.view addSubview:ruleTextView];
    
    NSString *str= @"👻还有防盗锁，用过的人都说好，这个出游季，带上一个不会错！&lt;br&gt;✈出游旺季带什么好？&lt;br&gt;装下你所需的20寸万向轮拉杆箱~&lt;br&gt;【七匹狼】品牌保证🎉&lt;br&gt;颜控必备的奢华铝合金拉丝面箱体&lt;br&gt;券后【99】✨&lt;br&gt;——————————&lt;br&gt;";
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    ruleTextView.text = attributedString.string;
    
}

#pragma mark - 监听    =====WKWebView代理相关关
/* *4.在监听方法中获取网页加载的进度，并将进度赋给progressView.progress*/
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.wkWebView.estimatedProgress;
        
        NSLog(@"%f",self.progressView.progress);
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
                
            }];
        }
        if (self.wkWebView.estimatedProgress < 1.0){
            return;
        }
        //完全加载后获取webview的高度
        NSString *js = @"document.body.scrollHeight";
        [self.wkWebView evaluateJavaScript:js completionHandler:^(id _Nullable height, NSError * _Nullable error) {
            
            NSLog(@"progress:%f height:%@ ===== %f",self.wkWebView.estimatedProgress,[height class],[height floatValue]);
            
            CGFloat h = [height floatValue];
            self.wkWebView.frame = CGRectMake(0, NavTopHeight, self.view.frame.size.width, h);
            
            self.title = [NSString stringWithFormat:@"ContentHeight = %.2f",h];
            
        }];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    
    
    //NSString *promptCode = [NSStringstringWithFormat:@"mymethd(\"%@\")",self.data];
    //当wkwebview把html加载完之后，调用此方法，其中@"mymethd(\"%@\")"，是方法名和要传的参数
}

#pragma mark - WKWKNavigationDelegate Methods
/**5.在WKWebViewd的代理中展示进度条，加载完成后隐藏进度条*/
//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载网页");
    
    //    [self showLoadingHUD];
    
    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止progressView被网页挡住
    [self.view bringSubviewToFront:self.progressView];
}







- (void)dealloc
{
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"子试图消失");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
