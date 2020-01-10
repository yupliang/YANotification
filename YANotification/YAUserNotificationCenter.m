//
//  YAUserNotificationCenter.m
//  NSLocalNotificationDemo
//
//  Created by app-01 on 2017/10/10.
//  Copyright © 2017年 app-01 org. All rights reserved.
//

#import "YAUserNotificationCenter.h"
#import "YAUserNotificationCenterLTen.h"
#import "YAUserNotificationCenterGETen.h"
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif
#import <UIKit/UIKit.h>

#define kUserRequestedNotificationAuthen @"kUserRequestedNotificationAuthen"
//#define kUserDisableNotificationAuthen @"kUserDisableNotificationAuthen"
@implementation YAUserNotificationCenter

+ (YAUserNotificationCenter *)getProperUserNotificationCenter {
    static YAUserNotificationCenter *userNotificationCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 10.0, *)) {
            userNotificationCenter = [[YAUserNotificationCenterGETen alloc] init];
        } else {
            userNotificationCenter = [[YAUserNotificationCenterLTen alloc] init];
        }
    });
    return userNotificationCenter;
}

- (void)scheduleLocalNotificationWithID:(NSString *)notiID title:(NSString *)title subTitle:(NSString *)subTitle body:(NSString *)body imagePath:(NSString *)imagePath badge:(NSInteger)badge fireTime:(NSTimeInterval)second action:(NSString *)action {}
- (void)cancelLocalNotificationWithID:(NSString *)notiID {}
- (void)cancelAllLocalNotification {}

- (void)goToNotificationSetting{
    NSString *string = UIApplicationOpenSettingsURLString;
    NSURL *url = [NSURL URLWithString:string];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}
- (int)pushNotificationState{
    BOOL requested = [[NSUserDefaults standardUserDefaults] boolForKey:kUserRequestedNotificationAuthen];
    
//    BOOL userDisable = [[NSUserDefaults standardUserDefaults] boolForKey:kUserDisableNotificationAuthen];
    if ([[UIApplication sharedApplication] currentUserNotificationSettings].types  == UIUserNotificationTypeNone) {
        if (requested) {
            return 0;
        } else {
            return 2;
        }
    } else {
        return 1;
    }
}
- (void)requestNofiticationAuthentication:(void (^)(BOOL))callBack{
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:kUserRequestedNotificationAuthen];
    // iOS 8 or later
    // [START register_for_notifications]
    
    if (@available(iOS 10.0,*)) {
        UNAuthorizationOptions authOptions =
        UNAuthorizationOptionAlert
        | UNAuthorizationOptionSound
        | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (callBack!=nil) {
                callBack(granted);
            }
        }];
    } else {
        UIUserNotificationType allNotificationTypes =
        (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    // [END register_for_notifications]
    
}
- (void)removeNotificationAuthentication{
//    [[NSUserDefaults standardUserDefaults] setBool:true forKey:kUserDisableNotificationAuthen];
    
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
}
@end
