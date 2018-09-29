//
//  ZFJPermissionManager.m
//  FingerprintUnlock.git
//
//  Created by ZFJ on 2018/7/5.
//  Copyright © 2018年 张福杰. All rights reserved.
//

#import "ZFJPermissionManager.h"
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <CoreLocation/CoreLocation.h>
#import <Contacts/Contacts.h>
#import <AddressBook/AddressBook.h>
@import CoreTelephony;
#import <EventKit/EventKit.h>
#import <UIKit/UIKit.h>

@interface ZFJPermissionManager()

@property (strong, nonatomic) CLLocationManager *LocationManager;

@end

@implementation ZFJPermissionManager

- (void)checkUpAPPPermission:(ZFJCheckPermissionType)permissionType completed:(void(^)(ZFJCheckResultType authStatus))completed{
    if(permissionType == ZFJCheckDataRestricted){
        //检查联网权限
        CTCellularData *cellularData = [[CTCellularData alloc]init];
        CTCellularDataRestrictedState state = cellularData.restrictedState;
        if(state == kCTCellularDataRestricted){
            //蜂窝移动网络状态：关闭
            if(completed){
                completed(ZFJStatusDenied);
            }
        }else if (state == kCTCellularDataNotRestricted){
            //蜂窝移动网络状态：开启
            if(completed){
                completed(ZFJStatusAuthorized);
            }
        }else if (state == kCTCellularDataRestrictedStateUnknown){
            //蜂窝移动网络状态：未知 WIFI OR OTHERS
            if(completed){
                completed(ZFJStatusUnknown);
            }
        }
        
    }else if(permissionType == ZFJCheckPhotoLibrary){
        //检查相册权限
        PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
        if (photoAuthorStatus == PHAuthorizationStatusDenied) {
            //用户拒绝当前应用访问相册,我们需要提醒用户打开访问开关
            if(completed){
                completed(ZFJStatusDenied);
            }
        }else if (photoAuthorStatus == PHAuthorizationStatusRestricted){
            //家长控制,不允许访问
            if(completed){
                completed(ZFJStatusRestricted);
            }
        }else if (photoAuthorStatus == PHAuthorizationStatusNotDetermined){
            //用户还没有做出选择
            if(completed){
                completed(ZFJStatusNotDetermined);
            }
        }else if (photoAuthorStatus == PHAuthorizationStatusAuthorized){
            //用户允许当前应用访问权限
            if(completed){
                completed(ZFJStatusAuthorized);
            }
        }
    }else if (permissionType == ZFJCheckCamera){
        //检查相机权限
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if(authStatus == AVAuthorizationStatusNotDetermined){
            //用户还没有做出选择
            if(completed){
                completed(ZFJStatusNotDetermined);
            }
        }else if (authStatus == AVAuthorizationStatusRestricted){
            //家长控制,不允许访问
            if(completed){
                completed(ZFJStatusRestricted);
            }
        }else if (authStatus == AVAuthorizationStatusDenied){
            //未授权
            if(completed){
                completed(ZFJStatusDenied);
            }
        }else if (authStatus == AVAuthorizationStatusAuthorized){
            //用户允许当前应用访问权限
            if(completed){
                completed(ZFJStatusAuthorized);
            }
        }
    }else if (permissionType == ZFJCheckLocation){
        //检查定位权限
        CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
        if(authorizationStatus == kCLAuthorizationStatusNotDetermined){
            //用户尚未对该应用程序作出选择
            if(completed){
                completed(ZFJStatusNotDetermined);
            }
        }else if(authorizationStatus == kCLAuthorizationStatusRestricted){
            //应用程序的定位权限被限制
            if(completed){
                completed(ZFJStatusRestricted);
            }
        }else if(authorizationStatus == kCLAuthorizationStatusAuthorizedAlways){
            //一直允许获取定位
            if(completed){
                completed(ZFJStatusAuthorizedAlways);
            }
        }else if(authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse){
            //在使用时允许获取定位
            if(completed){
                completed(ZFJStatusAuthorizedWhenInUse);
            }
        }else if(authorizationStatus == kCLAuthorizationStatusDenied){
            //拒绝获取定位
            if(completed){
                completed(ZFJStatusDenied);
            }
        }
        
    }else if (permissionType == ZFJCheckNotification){
        //检查通知权限
        //获取通知中心 是否 允许程序通知消息的值，7.0的用
        UIUserNotificationType types = [[UIApplication sharedApplication] currentUserNotificationSettings].types;
        if(types == UIUserNotificationTypeNone){
            //用户拒绝访问权限,我们需要提醒用户打开访问开关
            if(completed){
                completed(ZFJStatusDenied);
            }
        }else if (types == (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)){
            //通知可以使用
            if(completed){
                completed(ZFJStatusAuthorized);
            }
        }
        /*
         UIUserNotificationTypeNone    = 0,      // 用户禁止了推送
         UIUserNotificationTypeBadge   = 1 << 0, // 用户开启了推送角标
         UIUserNotificationTypeSound   = 1 << 1, // 用户开启了推送提示音
         UIUserNotificationTypeAlert   = 1 << 2, // 用户开启了通知栏提醒
         */
    }else if (permissionType == ZFJCheckAudio){
        //检查麦克风权限
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
        if(authStatus == AVAuthorizationStatusNotDetermined){
            //没有询问是否开启麦克风
            if(completed){
                completed(ZFJStatusNotDetermined);
            }
        }else if (authStatus == AVAuthorizationStatusRestricted){
            //未授权，家长限制
            if(completed){
                completed(ZFJStatusRestricted);
            }
        }else if (authStatus == AVAuthorizationStatusDenied){
            //用户拒绝访问权限,我们需要提醒用户打开访问开关
            if(completed){
                completed(ZFJStatusDenied);
            }
        }else if (authStatus == AVAuthorizationStatusAuthorized){
            //用户允许当前应用访问权限
            if(completed){
                completed(ZFJStatusAuthorized);
            }
        }
    }else if(permissionType == ZFJCheckAddressBook){
        //检查通讯录权限 @import Contacts
        if([[[UIDevice currentDevice]systemVersion] floatValue] >= 9.0){
            CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
            if(status == CNAuthorizationStatusAuthorized){
                if(completed){
                    completed(ZFJStatusAuthorized);
                }
            }else if(status == CNAuthorizationStatusDenied){
                if(completed){
                    completed(ZFJStatusDenied);
                }
            }else if(status == CNAuthorizationStatusRestricted){
                if(completed){
                    completed(ZFJStatusRestricted);
                }
            }else if(status == CNAuthorizationStatusNotDetermined){
                if(completed){
                    completed(ZFJStatusNotDetermined);
                }
            }
        }else{
            //9.0以前 AddressBook
            //ABAuthorizationStatus ABstatus = ABAddressBookGetAuthorizationStatus();
            
            //9.0以后 AddressBook
            CNAuthorizationStatus ABstatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
            if(ABstatus == CNAuthorizationStatusAuthorized){
                if(completed){
                    completed(ZFJStatusAuthorized);
                }
            }else if(ABstatus == CNAuthorizationStatusDenied){
                if(completed){
                    completed(ZFJStatusDenied);
                }
            }else if(ABstatus == CNAuthorizationStatusNotDetermined){
                if(completed){
                    completed(ZFJStatusNotDetermined);
                }
            }else if(ABstatus == CNAuthorizationStatusRestricted){
                if(completed){
                    completed(ZFJStatusRestricted);
                }
            }
        }
    }else if (permissionType == ZFJCheckCalendars){
        //日历权限
        EKAuthorizationStatus EKstatus = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeEvent];
        switch (EKstatus) {
            case EKAuthorizationStatusAuthorized:
                if(completed){
                    completed(ZFJStatusAuthorized);
                }
                break;
            case EKAuthorizationStatusDenied:
                if(completed){
                    completed(ZFJStatusDenied);
                }
                break;
            case EKAuthorizationStatusNotDetermined:
                if(completed){
                    completed(ZFJStatusNotDetermined);
                }
                break;
            case EKAuthorizationStatusRestricted:
                if(completed){
                    completed(ZFJStatusRestricted);
                }
                break;
            default:
                break;
        }
    }else if (permissionType == ZFJCheckReminders){
        //备忘录权限
        EKAuthorizationStatus EKstatus = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeReminder];
        switch (EKstatus) {
            case EKAuthorizationStatusAuthorized:
                if(completed){
                    completed(ZFJStatusAuthorized);
                }
                break;
            case EKAuthorizationStatusDenied:
                if(completed){
                    completed(ZFJStatusDenied);
                }
                break;
            case EKAuthorizationStatusNotDetermined:
                if(completed){
                    completed(ZFJStatusNotDetermined);
                }
                break;
            case EKAuthorizationStatusRestricted:
                if(completed){
                    completed(ZFJStatusRestricted);
                }
                break;
            default:
                break;
        }
    }else{
        //
    }
}

- (void)requestAccessPermission:(ZFJCheckPermissionType)permissionType completed:(void(^)(BOOL isScu))completed{
    if(permissionType == ZFJCheckDataRestricted){
        //联网权限
        [self jumpToAPPSetting];
    }else if (permissionType == ZFJCheckLocation){
        //检查定位权限 这里可以根据自己项目需求更改
        self.LocationManager = [[CLLocationManager alloc] init];
        [self.LocationManager requestAlwaysAuthorization];//一直获取定位信息
        [self.LocationManager requestWhenInUseAuthorization];//使用的时候获取定位信息
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8) {
            //由于IOS8中定位的授权机制改变 需要进行手动授权
            //获取授权认证
            [self.LocationManager requestWhenInUseAuthorization];
        }
        [self.LocationManager startUpdatingLocation];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self checkUpAPPPermission:ZFJCheckLocation completed:^(ZFJCheckResultType authStatus) {
                if(authStatus == ZFJStatusAuthorizedAlways || authStatus == ZFJStatusAuthorizedWhenInUse){
                    if(completed){
                        completed(YES);
                    }
                }else{
                    if(completed){
                        completed(NO);
                    }
                }
            }];
        });
    }else if (permissionType == ZFJCheckAddressBook){
        //检查通讯录权限
        if([[[UIDevice currentDevice]systemVersion] floatValue] >= 9.0){
            CNContactStore *contactStore = [[CNContactStore alloc] init];
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if(completed){
                    completed(granted);
                }
            }];
        }else{
            ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
            
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                if (granted) {
                    CFRelease(addressBook);
                }
                if(completed){
                    completed(granted);
                }
            });
        }
    }else if (permissionType == ZFJCheckCalendars){
        //检查日历权限
        EKEventStore *store = [[EKEventStore alloc]init];
        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
            if(completed){
                completed(granted);
            }
        }];
    }else if (permissionType == ZFJCheckReminders){
        //备忘录权限
        EKEventStore *store = [[EKEventStore alloc]init];
        [store requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
            if(completed){
                completed(granted);
            }
        }];
    }else if (permissionType == ZFJCheckPhotoLibrary){
        //检查相册权限
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            BOOL granted = status == PHAuthorizationStatusAuthorized ? YES : NO;
            if(completed){
                completed(granted);
            }
        }];
    }else if (permissionType == ZFJCheckAudio){
        //检查麦克风权限
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            //granted: YES麦克风准许 NO麦克风不准许
            if(completed){
                completed(granted);
            }
        }];
    }else if (permissionType == ZFJCheckCamera){
        //检查相机权限
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            //granted: YES相机准许 NO相机不准许
            if(completed){
                completed(granted);
            }
        }];
    }else if (permissionType == ZFJCheckNotification){
        //检查通知权限
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }
}


/**
 跳转到设置APP页面
 */
- (void)jumpToAPPSetting{
    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        
        NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        [[UIApplication sharedApplication] openURL:url];
        
    }
}

/**
 用户拒绝访问权限,我们需要提醒用户打开访问开关
 
 @param meg 提示文字
 */
- (void)showStatusDeniedMeg:(NSString *)meg{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:meg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self jumpToAPPSetting];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        //
    }];
    
    [alert addAction:action1];
    [alert addAction:action2];
    
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

@end

















