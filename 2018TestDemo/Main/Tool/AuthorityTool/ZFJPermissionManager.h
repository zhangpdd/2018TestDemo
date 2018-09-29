//
//  ZFJPermissionManager.h
//  FingerprintUnlock.git
//
//  Created by ZFJ on 2018/7/5.
//  Copyright © 2018年 张福杰. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    ZFJCheckDataRestricted = 0, //联网权限
    ZFJCheckLocation = 1, //检查定位权限
    ZFJCheckAddressBook = 2, //检查通讯录权限
    ZFJCheckCalendars = 3, //检查日历权限
    ZFJCheckReminders = 4, //备忘录权限
    ZFJCheckPhotoLibrary = 5, //检查相册权限
    ZFJCheckAudio = 6, //检查麦克风权限
    ZFJCheckCamera = 7, //检查相机权限
    ZFJCheckNotification = 8 //检查通知权限
}ZFJCheckPermissionType;

typedef enum {
    
    ZFJStatusDenied = 0, //关闭
    ZFJStatusAuthorized = 1, //开启
    ZFJStatusUnknown = 2, //未知
    ZFJStatusRestricted = 3, //不允许访问
    ZFJStatusNotDetermined = 4, //没有做出选择
    ZFJStatusAuthorizedAlways = 5, //一直允许获取定位
    ZFJStatusAuthorizedWhenInUse = 6, //在使用时允许获取定位

}ZFJCheckResultType;

@interface ZFJPermissionManager : NSObject


/**
 检查APP权限

 @param permissionType 要检查的权限类型
 @param completed 结果回调(FIRST:6 2 2 2 2 2 2 2 0)
 */
- (void)checkUpAPPPermission:(ZFJCheckPermissionType)permissionType completed:(void(^)(ZFJCheckResultType authStatus))completed;

/**
 请求权限

 @param permissionType 要请求的权限类型
 @param completed 结果回调
 */
- (void)requestAccessPermission:(ZFJCheckPermissionType)permissionType completed:(void(^)(BOOL isScu))completed;

/**
 跳转到设置APP页面
 */
- (void)jumpToAPPSetting;

/**
 用户拒绝访问权限,我们需要提醒用户打开访问开关

 @param meg 提示文字
 */
- (void)showStatusDeniedMeg:(NSString *)meg;




@end
