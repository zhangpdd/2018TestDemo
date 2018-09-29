//
//  HttpRequestTool.m
//  2018TestDemo
//
//  Created by zp on 2018/6/5.
//  Copyright © 2018年 zp. All rights reserved.
//

#import "HttpRequestTool.h"
#import <AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>
#import "HttpRequestManager.h"
/*get请求最多10秒，post最多30秒*/
#define getTimeOut 10.0f
#define postTimeOut 30.0f

@implementation HttpRequestTool

static NSMutableArray *_allSessionTask;
static AFHTTPSessionManager *_sessionManager;

/**
 开始监测网络状态
 */
+ (void)load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}
/**
 *  所有的HTTP请求共享一个AFHTTPSessionManager
 *  第一次使用该类的时候才触发
 *  原理参考地址:http://www.jianshu.com/p/5969bbb4af9f
 */
+ (void)initialize {
    //创建网络请求管理对象
    _sessionManager = [HttpRequestManager sharedManager];
    //请求时间
    [_sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    _sessionManager.requestSerializer.timeoutInterval = getTimeOut;
    [_sessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //申明返回的结果是json类型
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
}


#pragma mark - 开始监听网络
+ (void)networkStatusWithBlock:(ZPNetworkStatus)networkStatus {

    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                !networkStatus ? : networkStatus(ZPNetworkStatusUnknown);

                break;
            case AFNetworkReachabilityStatusNotReachable:
                !networkStatus ? : networkStatus(ZPNetworkStatusNotReachable);

                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                !networkStatus ? : networkStatus(ZPNetworkStatusReachableViaWWAN);

                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                !networkStatus ? : networkStatus(ZPNetworkStatusReachableViaWiFi);

                break;
        }
    }];
}

+ (BOOL)isNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (BOOL)isWWANNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

+ (BOOL)isWiFiNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

+ (void)cancelAllRequest {
    // 锁操作
    @synchronized(self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [[self allSessionTask] removeAllObjects];
    }
}

+ (void)cancelRequestWithURL:(NSString *)URL {
    if (!URL) { return; }
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:URL]) {
                [task cancel];
                [[self allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}



#pragma mark - GET请求
+ (__kindof NSURLSessionTask *)GET:(NSString *)URLString
                        parameters:(id)parameters
                          progress:(ZPProgressBlock)downLoadProgress
                           success:(ZPNetworkSuccessBlock)success
                           failure:(ZPNetworkFailedBlock)failure
{
    //发送网络请求(请求方式为GET)
    NSURLSessionTask *sessionTask = [_sessionManager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
//        if (downloadProgress) {
//
//            downLoadProgress(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
//        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[self allSessionTask] removeObject:task];
        !success ? : success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        [[self allSessionTask] removeObject:task];
        !failure ? : failure(error);
    }];
    
    // 添加sessionTask到数组
    !sessionTask ? : [[self allSessionTask] addObject:sessionTask];
    return sessionTask;
}


#pragma mark - POST请求
+ (__kindof NSURLSessionTask *)POST:(NSString *)URLString
                         parameters:(id)parameters
                           progress:(ZPProgressBlock)upLoadProgress
                            success:(ZPNetworkSuccessBlock)success
                            failure:(ZPNetworkFailedBlock)failure
{
    //发送网络请求(请求方式为POST)
    NSURLSessionTask *sessionTask = [_sessionManager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
//        if (uploadProgress) {
//            upLoadProgress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
//        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[self allSessionTask] removeObject:task];
        !success ? : success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[self allSessionTask] removeObject:task];
        !failure ? : failure(error);
    }];
    
    // 添加最新的sessionTask到数组
    !sessionTask ? : [[self allSessionTask] addObject:sessionTask];
    return sessionTask;
}

#pragma mark - 上传单张/多张图片
+(__kindof NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                                       parameters:(id)parameters
                                             name:(NSString *)name
                                           images:(NSArray<UIImage *> *)images
                                        fileNames:(NSArray<NSString *> *)fileNames
                                       imageScale:(CGFloat)imageScale
                                        imageType:(NSString *)imageType
                                         progress:(ZPProgressBlock)progress
                                          success:(ZPNetworkSuccessBlock)success
                                          failure:(ZPNetworkFailedBlock)failure
{
    
    //formData 拼接需要上传的数据 在此生成一个要上传的数据体
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSUInteger i = 0; i < images.count; i++) {
            // 图片经过等比压缩后得到的二进制文件
            NSData *imageData = UIImageJPEGRepresentation(images[i], imageScale ?: 1.f);
            if (imageData.length>100*1024)
            {
                if (imageData.length>1024*1024) {//1M以及以上
                    imageData = UIImageJPEGRepresentation(images[i], 0.1);
                }else if (imageData.length>512*1024) {//0.5M-1M
                    imageData = UIImageJPEGRepresentation(images[i], 0.5);
                }else if (imageData.length>200*1024) {//0.25M-0.5M
                    imageData = UIImageJPEGRepresentation(images[i], 0.9);
                }
            }
            // 默认图片的文件名, 若fileNames为nil就使用
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *imageFileName = [NSString stringWithFormat:@"%@%ld.%@",str,i,imageType?:@"jpg"];
            
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:fileNames ? [NSString stringWithFormat:@"%@.%@",fileNames[i],imageType?:@"jpg"] : imageFileName
                                    mimeType:[NSString stringWithFormat:@"image/%@",imageType ?: @"jpg"]];
            
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度。1.0 * progress.completedUnitCount /progress.totalUnitCount
        dispatch_sync(dispatch_get_main_queue(), ^{
            !progress ? : progress(uploadProgress);
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[self allSessionTask] removeObject:task];
        !success ? : success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"上传图片失败error = %@",error);
        [[self allSessionTask] removeObject:task];
        !failure ? :failure(error);
    }];
    
    // 添加sessionTask到数组
    !sessionTask ? : [[self allSessionTask] addObject:sessionTask];
    return sessionTask;
}


#pragma mark - 上传文件
+ (__kindof NSURLSessionTask *)uploadFileWithURL:(NSString *)URL
               parameters:(id)parameters
                     name:(NSString *)name
                 filePath:(NSString *)filePath
                 progress:(ZPProgressBlock)progress
                  success:(ZPNetworkSuccessBlock)success
                  failure:(ZPNetworkFailedBlock)failure
{
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSError *error = nil;
        [formData appendPartWithFileURL:[NSURL URLWithString:filePath] name:name error:&error];
        (failure && error) ? failure(error) : nil;
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度 1.0 * progress.completedUnitCount /progress.totalUnitCount
        dispatch_sync(dispatch_get_main_queue(), ^{
            !progress ? : progress(uploadProgress);
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[self allSessionTask] removeObject:task];
        !success ? : success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传文件失败error = %@",error);
        [[self allSessionTask] removeObject:task];
        !failure ? : failure(error);
    }];
    
    // 添加sessionTask到数组
    !sessionTask ? : [[self allSessionTask] addObject:sessionTask];
    return sessionTask;
}

#pragma mark - 下载文件
+(__kindof NSURLSessionTask *)downloadWithURL:(NSString *)URL
                                      fileDir:(NSString *)fileDir
                                     progress:(ZPProgressBlock)progress
                                      success:(void (^)(NSString *))success
                                      failure:(ZPNetworkFailedBlock)failure
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    
    NSMutableURLRequest *mutableRequest = [request mutableCopy];    //拷贝request
    [mutableRequest addValue:@"cAYZNuJjo387hH8OWZcq0ZOgWkV2hTu3" forHTTPHeaderField:@"Authorization"];
    request = [mutableRequest copy];//拷贝回去
    
    
    __block NSURLSessionDownloadTask *downloadTask = [_sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度 1.0 * progress.completedUnitCount /progress.totalUnitCount
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        [[self allSessionTask] removeObject:downloadTask];
        if(failure && error) {failure(error) ; return ;};
        !success ? : success(filePath.absoluteString /** NSURL->NSString*/);
        
    }];
    //开始下载
    [downloadTask resume];
    // 添加sessionTask到数组
    !downloadTask ? : [[self allSessionTask] addObject:downloadTask];
    
    return downloadTask;
}


/**
 存储着所有的请求task数组
 */
+ (NSMutableArray *)allSessionTask {
    if (!_allSessionTask) {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    return _allSessionTask;
}

#pragma mark - 重置AFHTTPSessionManager相关属性

+ (void)setAFHTTPSessionManagerProperty:(void (^)(AFHTTPSessionManager *))sessionManager {
    !sessionManager ? : sessionManager(_sessionManager);
}

+ (void)setRequestTimeoutInterval:(NSTimeInterval)time {
    _sessionManager.requestSerializer.timeoutInterval = time;
}

+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [[HttpRequestManager sharedManager].requestSerializer setValue:value forHTTPHeaderField:field];
}

#pragma mark - 设置证书
+ (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName {
    // /先导入证书
    //NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"91jf" ofType:@"cer"];//证书的路径
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    // 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 如果需要验证自建证书(无效证书)，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    // 是否需要验证域名，默认为YES;
    securityPolicy.validatesDomainName = validatesDomainName;
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
    
    [_sessionManager setSecurityPolicy:securityPolicy];
}
@end
