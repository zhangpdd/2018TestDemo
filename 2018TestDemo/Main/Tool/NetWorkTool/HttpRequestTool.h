//
//  HttpRequestTool.h
//  2018TestDemo
//
//  Created by zp on 2018/6/5.
//  Copyright © 2018年 zp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    /// 未知网络
    ZPNetworkStatusUnknown,
    /// 无网络
    ZPNetworkStatusNotReachable,
    /// 手机网络
    ZPNetworkStatusReachableViaWWAN,
    /// WIFI网络
    ZPNetworkStatusReachableViaWiFi
    
}ZPNetworkStatusType;

/// 请求成功的Block
typedef void(^ZPNetworkSuccessBlock)(id responseObject);

/// 请求失败的Block
typedef void(^ZPNetworkFailedBlock)(NSError *error);

/// 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小
typedef void (^ZPProgressBlock)(NSProgress *progress);

/// 网络状态的Block
typedef void(^ZPNetworkStatus)(ZPNetworkStatusType status);


@class AFHTTPSessionManager;

@interface HttpRequestTool : NSObject

/// 实时获取网络状态,通过Block回调实时获取(此方法可多次调用)
+ (void)networkStatusWithBlock:(ZPNetworkStatus)networkStatus;

/// 有网YES, 无网:NO
+ (BOOL)isNetwork;

/// 手机网络:YES, 反之:NO
+ (BOOL)isWWANNetwork;

/// WiFi网络:YES, 反之:NO
+ (BOOL)isWiFiNetwork;

/// 取消所有HTTP请求
+ (void)cancelAllRequest;

/// 取消指定URL的HTTP请求
+ (void)cancelRequestWithURL:(NSString *)URL;


/**
 GET请求

 @param URLString         请求地址
 @param parameters        请求参数
 @param downLoadProgress  进度信息
 @param success           请求成功的回调
 @param failure           请求失败的回调
 */
+ (__kindof NSURLSessionTask *)GET:(NSString *)URLString
                        parameters:(id)parameters
                          progress:(ZPProgressBlock)downLoadProgress
                           success:(ZPNetworkSuccessBlock)success
                           failure:(ZPNetworkFailedBlock)failure;


/**
 POST请求

 @param URLString       请求地址
 @param parameters      请求参数
 @param upLoadProgress  进度信息
 @param success         请求成功的回调
 @param failure         请求失败的回调
 */
+ (__kindof NSURLSessionTask *)POST:(NSString *)URLString
                         parameters:(id)parameters
                           progress:(ZPProgressBlock)upLoadProgress
                            success:(ZPNetworkSuccessBlock)success
                            failure:(ZPNetworkFailedBlock)failure;


/**
 上传单/多张图片

 @param URL         上传图片地址
 @param parameters  请求参数
 @param name        图片对应服务器上的字段
 @param images      图片数组
 @param fileNames   图片文件名数组, 可以为nil, 数组内的文件名默认为当前日期时间"yyyyMMddHHmmss"
 @param imageScale  图片文件压缩比 范围 (0.f ~ 1.f)
 @param imageType   图片文件的类型,例:png、jpg(默认类型)....
 @param progress    上传进度信息
 @param success     请求成功的回调
 @param failure     请求失败的回调
 */
+ (__kindof NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                                        parameters:(id)parameters
                                              name:(NSString *)name
                                            images:(NSArray<UIImage *> *)images
                                         fileNames:(NSArray<NSString *> *)fileNames
                                        imageScale:(CGFloat)imageScale
                                         imageType:(NSString *)imageType
                                          progress:(ZPProgressBlock)progress
                                           success:(ZPNetworkSuccessBlock)success
                                           failure:(ZPNetworkFailedBlock)failure;


/**
 *  上传文件
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param name       文件对应服务器上的字段
 *  @param filePath   文件本地的沙盒路径
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (__kindof NSURLSessionTask *)uploadFileWithURL:(NSString *)URL
                                      parameters:(id)parameters
                                            name:(NSString *)name
                                        filePath:(NSString *)filePath
                                        progress:(ZPProgressBlock)progress
                                         success:(ZPNetworkSuccessBlock)success
                                         failure:(ZPNetworkFailedBlock)failure;


/**
 *  下载文件
 *
 *  @param URL      请求地址
 *  @param fileDir  文件存储目录(默认存储目录为Download)
 *  @param progress 文件下载的进度信息
 *  @param success  下载成功的回调(回调参数filePath:文件的路径)
 *  @param failure  下载失败的回调
 */
+ (__kindof NSURLSessionTask *)downloadWithURL:(NSString *)URL
                                       fileDir:(NSString *)fileDir
                                      progress:(ZPProgressBlock)progress
                                       success:(void(^)(NSString *filePath))success
                                       failure:(ZPNetworkFailedBlock)failure;


#pragma mark - 设置AFHTTPSessionManager相关属性
#pragma mark 注意: 因为全局只有一个AFHTTPSessionManager实例,所以以下设置方式全局生效
/**
 在开发中,如果以下的设置方式不满足项目的需求,就调用此方法获取AFHTTPSessionManager实例进行自定义设置
 (注意: 调用此方法时在要导入AFNetworking.h头文件,否则可能会报找不到AFHTTPSessionManager的❌)
 @param sessionManager AFHTTPSessionManager的实例
 */
+ (void)setAFHTTPSessionManagerProperty:(void(^)(AFHTTPSessionManager *sessionManager))sessionManager;

/**
 *  设置请求超时时间:默认为30S
 *
 *  @param time 时长
 */
+ (void)setRequestTimeoutInterval:(NSTimeInterval)time;

/// 设置请求头
+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;


/**
 配置自建证书的Https请求, 参考链接: http://blog.csdn.net/syg90178aw/article/details/52839103
 
 @param cerPath 自建Https证书的路径
 @param validatesDomainName 是否需要验证域名，默认为YES. 如果证书的域名与请求的域名不一致，需设置为NO; 即服务器使用其他可信任机构颁发
 的证书，也可以建立连接，这个非常危险, 建议打开.validatesDomainName=NO, 主要用于这种情况:客户端请求的是子域名, 而证书上的是另外
 一个域名。因为SSL证书上的域名是独立的,假如证书上注册的域名是www.google.com, 那么mail.google.com是无法验证通过的.
 */
+ (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName;

@end
