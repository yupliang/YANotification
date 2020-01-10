//
//  YAUserNotificationCenterLTen.m
//  NSLocalNotificationDemo
//
//  Created by app-01 on 2017/10/10.
//  Copyright © 2017年 app-01 org. All rights reserved.
//

#import "YAUserNotificationCenterLTen.h"
#import <UIKit/UIKit.h>

@implementation YAUserNotificationCenterLTen

extern NSString *const cateID ;
extern NSString *const YTNotiTypeLocalEvent;
NSString *const identifier = @"YTidentifier";

- (instancetype)init
{
    if (@available(iOS 10.0, *)) {
        NSAssert(NO, @"create this instance < iOS 10.0");
        return nil;
    }
    if (@available(iOS 8.0, *)) {
        
    } else {
        NSAssert(NO, @"create this instance >= iOS 8.0");
        return nil;
    }
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)scheduleLocalNotificationWithID:(NSString *)notiID title:(nonnull NSString *)title subTitle:(nullable NSString *)subTitle body:(nonnull NSString *)body imagePath:(nullable NSString *)imagePath badge:(NSInteger)badge fireTime:(NSTimeInterval)second action:(nullable NSString *)action {
    [self cancelLocalNotificationWithID:notiID];
    //创建一个本地通知
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:second];
    
    notification.fireDate = fireDate;
    // 时区
    notification.timeZone = nil;//与>=iOS 10 处理方式统一
    // 设置重复的间隔
    notification.repeatInterval = 0;//0表示不重复
    // 通知内容
    notification.alertBody =  body;
    if (@available(iOS 8.2, *)) {
//        notification.alertTitle = title;
    }
    
    notification.applicationIconBadgeNumber = badge;
    // 通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:notiID forKey:identifier];
    
    notification.userInfo = userDict;
    
    notification.category = cateID;
    
    UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
    
    if (action == nil || action.length == 0) {
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = cateID;
        [categorys setActions:@[] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:[NSSet setWithObject:categorys]];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        UIMutableUserNotificationAction *act = [[UIMutableUserNotificationAction alloc] init];
        act.identifier = action;
        act.title= action;
        act.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = cateID;
        [categorys setActions:@[act] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:[NSSet setWithObject:categorys]];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    
    
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}


- (void)cancelLocalNotificationWithID:(NSString *)notiID {
    if (notiID == nil) return;
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    if (localNotifications) {
        
        for (UILocalNotification *notification in localNotifications) {
            NSDictionary *userInfo = notification.userInfo;
            if (userInfo) {
                NSString *info = userInfo[identifier];
           
                if ([info isEqualToString:notiID]) {
                    if (notification) {
                        [[UIApplication sharedApplication] cancelLocalNotification:notification];
                    }
                    break;
                }
            }
        }
    }
}
- (void)cancelAllLocalNotification {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

@end
