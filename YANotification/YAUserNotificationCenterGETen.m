//
//  YAUserNotificationCenterGETen.m
//  NSLocalNotificationDemo
//
//  Created by app-01 on 2017/10/10.
//  Copyright © 2017年 app-01 org. All rights reserved.
//

#import "YAUserNotificationCenterGETen.h"
#import <UserNotifications/UserNotifications.h>

@implementation YAUserNotificationCenterGETen

NSString *const cateID = @"YTCateID999";
NSString *const YAUNDefaultImage = @"splash_icon";
extern NSString *const identifier;
extern NSString *const YTNotiType;
extern NSString *const YTNotiTypeLocal;
extern NSString *const YTNotiTypeLocalEvent;
- (instancetype)init
{
    if (@available(iOS 10.0, *)) {
        
    } else {
        NSAssert(NO, @"should create instance in >= iOS 10.0");
        return nil;
    }
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)scheduleLocalNotificationWithID:(NSString *)notiID title:(nonnull NSString *)title subTitle:(nullable NSString *)subTitle body:(nonnull NSString *)body imagePath:(nullable NSString *)imagePath badge:(NSInteger)badge fireTime:(NSTimeInterval)second action:(nullable NSString *)action {
    if (!(second > 0)) {
        return;
    }
    if (action != nil && action.length > 0) {
        UNNotificationAction *commitAction = [UNNotificationAction actionWithIdentifier:action title:action options:UNNotificationActionOptionForeground];
        
        UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:cateID actions:@[commitAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        
        NSSet *set = [[NSSet alloc] initWithObjects:category, nil];
        [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:set];
    } else {
        UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:cateID actions:@[] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        
        NSSet *set = [[NSSet alloc] initWithObjects:category, nil];
        [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:set];
    }
    if (title == nil) {
        title = @"";
    }
    if (subTitle == nil) {
        subTitle = @"";
    }
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    
    content.title = title;
    
    content.subtitle = subTitle;
    
    content.body = body;
    content.userInfo = @{identifier:notiID,YTNotiType:YTNotiTypeLocal};
    
    content.badge = [NSNumber numberWithInteger:badge];
    
    content.sound = [UNNotificationSound defaultSound];
    NSURL *imageUrl = nil;
    NSString *imgPath = imagePath;
    if (imgPath == nil || imgPath.length == 0) {
        imgPath = [[NSBundle mainBundle] pathForResource:YAUNDefaultImage ofType:@"png"];
    }
    if (imgPath != nil) {
        imageUrl = [NSURL fileURLWithPath:imgPath];
    }
    if (imageUrl) {
        UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"imageIndetifier" URL:imageUrl options:nil error:nil];
        
        content.attachments = @[attachment];
    }
    
    // 标识符
    content.categoryIdentifier = cateID;
    
    // 2、创建通知触发
    /* 触发器分三种：
     UNTimeIntervalNotificationTrigger : 在一定时间后触发，如果设置重复的话，timeInterval不能小于60
     可调整时间测试，可理解为绝对时间间隔
     UNCalendarNotificationTrigger : 在某天某时触发，可重复
     可调时间测试 钟表到达对应时间点
     */
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:second repeats:NO];
    
    UNNotificationRequest *notificationRequest = [UNNotificationRequest requestWithIdentifier:notiID content:content trigger:trigger];
    
    // 4、将请求加入通知中心
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
        if (error == nil) {
        } else {
            NSString *errorMsg = [error localizedDescription];
            if (error == nil) {
                errorMsg = @"error";
            }
        }
    }];
}
- (void)cancelLocalNotificationWithID:(NSString *)notiID {
    if (notiID != nil) {
        [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[notiID]];
    }
}

- (void)cancelAllLocalNotification {
    
    //    [[UNUserNotificationCenter currentNotificationCenter] removeAllDeliveredNotifications];
    
    [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
}

@end
