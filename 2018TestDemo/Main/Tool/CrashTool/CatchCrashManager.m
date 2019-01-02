//
//  CatchCrashManager.m
//  ShinowDonor
//
//  Created by admin on 16/9/18.
//  Copyright © 2016年 shinow. All rights reserved.
//

#import "CatchCrashManager.h"
//#import "LoginModel.h"
//#import "LoginModelUtil.h"
#import <sys/utsname.h>
#import <sys/socket.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <net/if.h>
#import <arpa/inet.h>
#import <AFNetworking.h>

@interface CatchCrashManager ()

@end

@implementation CatchCrashManager

void uncaughtExceptionHandler(NSException *exception)
{
    /** 时间 */
    NSString *crashTime = [CatchCrashManager getCurrentTimeString];
    
    //LoginModel *model = [LoginModelUtil getLoginModel];
    /** 用户名 */
    //NSString *userName = model.Name;
    /** 用户ID */
    //NSString *userId = model.ID;
    /** 版本号 */
    //ApiRequest *apiRequest = [[ApiRequest alloc]init];
    //NSString *versionName = apiRequest.version;
    /** 手机型号 */
    NSString *phoneModel = [CatchCrashManager iphoneType];
    /** 系统版本 */
    NSString *OSVersion = [NSString stringWithFormat:@"%@ %@", [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion]];
    /** NetWork */
    NSString *netWorkModel = [[NSUserDefaults standardUserDefaults] objectForKey:@"NetWork"];
    
    /** 异常信息 */
    // 异常的堆栈信息
    NSArray *stackArray = [exception callStackSymbols];
    // 异常的原因
    NSString *reason = [exception reason];
    // 异常名称
    NSString *name = [exception name];
    // 异常描述
    NSString *exceptionInfo = [NSString stringWithFormat:@"Exception reason：%@\nException name：%@\nException stack：%@", name, reason, stackArray];
    
    /** 所有信息 */
    //NSString *crashInfo = [NSString stringWithFormat:@"CrashTime：%@\nUserName：%@\nUserId：%@\nVersionName：%@\nModel：%@\nOSVersion：%@\nNetWork：%@\n%@", crashTime, userName, userId, versionName, phoneModel, OSVersion, netWorkModel, exceptionInfo];
    
    NSString *crashInfo = [NSString stringWithFormat:@"CrashTime：%@\nUserName：\nUserId：\nVersionName：\nModel：%@\nOSVersion：%@\nNetWork：%@\n%@", crashTime, phoneModel, OSVersion, netWorkModel, exceptionInfo];
    
    /** 保存到本地 */
    NSString *fileName = [NSString stringWithFormat:@"%@/Documents/error.log", NSHomeDirectory()];
    NSData *crashInfoData = [NSData dataWithContentsOfFile:fileName options:0 error:nil];
    NSString *crashInfoString = [[NSString alloc] initWithData:crashInfoData encoding:NSUTF8StringEncoding];
    
    if (crashInfoString.length == 0)
    {
        [[NSString stringWithFormat:@"%@\n----------------------", crashInfo] writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:nil];
    } else
    {
        [[NSString stringWithFormat:@"%@\n%@\n----------------------", crashInfoString, crashInfo] writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
}

+ (NSString *)iphoneType
{
    //需要#import <sys/utsname.h>
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone3,1"] || [platform isEqualToString:@"iPhone3,2"] || [platform isEqualToString:@"iPhone3,3"])
        return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"])
        return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"] || [platform isEqualToString:@"iPhone5,2"])
        return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"] || [platform isEqualToString:@"iPhone5,4"])
        return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"] || [platform isEqualToString:@"iPhone6,2"])
        return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"])
        return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"])
        return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"])
        return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"])
        return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"])
        return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"])
        return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPhone9,2"])
        return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPhone10,1"] || [platform isEqualToString:@"iPhone10,4"])
        return @"iPhone 8";
    
    if ([platform isEqualToString:@"iPhone10,2"] || [platform isEqualToString:@"iPhone10,5"])
        return @"iPhone 8 Plus";
    
    if ([platform isEqualToString:@"iPhone10,3"] || [platform isEqualToString:@"iPhone10,6"])
        return @"iPhone X";
    
    if ([platform isEqualToString:@"11,2"])
        return @"iPhone XS";
    
    if ([platform isEqualToString:@"iPhone11,4"] || [platform isEqualToString:@"iPhone11,6"])
        return @"iPhone XS Max";
    
    if ([platform isEqualToString:@"iPhone11,8"])
        return @"iPhone XR";
    
    if ([platform isEqualToString:@"x86_64"] || [platform isEqualToString:@"i386"])
        return @"iPhone Simulator";
    
    return @"其他设备";
}

+ (NSString *)getCurrentTimeString
{
    NSDate *curDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [dateFormatter stringFromDate:curDate];
}

+ (NSString *)getDeviceIPIpAddresses
{
    int sockfd = socket(AF_INET,SOCK_DGRAM, 0);
    NSMutableArray *ips = [NSMutableArray array];
    int BUFFERSIZE = 4096;
    struct ifconf ifc;
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    struct ifreq *ifr, ifrcopy;
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd,SIOCGIFCONF, &ifc) >= 0)
    {
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; )
        {
            ifr = (struct ifreq *)ptr;
            int len =sizeof(struct sockaddr);
            if (ifr -> ifr_addr.sa_len > len)
            {
                len = ifr -> ifr_addr.sa_len;
            }
            
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family !=AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name,':')) != NULL) *cptr =0;
            if (strncmp(lastname, ifr->ifr_name,IFNAMSIZ) == 0)continue;
            memcpy(lastname, ifr->ifr_name,IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd,SIOCGIFFLAGS, &ifrcopy);
            
            if ((ifrcopy.ifr_flags &IFF_UP) == 0)continue;
            
            NSString *ip = [NSString stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            
            [ips addObject:ip];
        }
    }
    close(sockfd);
    
    NSString *deviceIP = @"";
    
    for (int i=0; i < ips.count; i++)
    {
        if (ips.count > 0)
        {
            deviceIP = [NSString stringWithFormat:@"%@", ips.lastObject];
        }
    }
    
    return deviceIP;
}

+ (NSString *)getCrashInfo
{
    NSString *fileName = [NSString stringWithFormat:@"%@/Documents/error.log", NSHomeDirectory()];
    NSData *crashInfoData = [NSData dataWithContentsOfFile:fileName options:0 error:nil];
    NSString *crashInfoString = [[NSString alloc] initWithData:crashInfoData encoding:NSUTF8StringEncoding];
    return crashInfoString;
}

+ (void)clearCrashInfo
{
    NSString *fileName = [NSString stringWithFormat:@"%@/Documents/error.log", NSHomeDirectory()];
    [@"" writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@end
