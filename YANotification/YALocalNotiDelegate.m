//
//  YALocalNotiDelegate.m
//  NSLocalNotificationDemo
//
//  Created by app-01 on 2017/10/10.
//  Copyright © 2017年 app-01 org. All rights reserved.
//

#import "YALocalNotiDelegate.h"

NSString *const YALocalNotiCateIdentifier = @"YALocalNotiCateID";
NSString *const YTNotiType = @"YTNotiType";
NSString *const YTNotiTypeLocal = @"YTNotiTypeLocal";
NSString *const YTNotiTypeLocalEvent = @"YTNotiTypeLocalEvent";//注册本地推送事件
extern NSString *const kUserClickLocalNotiEvent;

@interface YALocalNotiDelegate ()

@property (nonatomic,copy) NSString *notiID;

@end

@implementation YALocalNotiDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //    if (@available(iOS 10.0, *)) {
    //
    //    } else {
    UILocalNotification *noti = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (noti != nil) {
        self.notiID = [noti.userInfo objectForKey:identifier];
    }
    //    }
    return YES;
}

#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
// 如果在应用内展示通知 （如果不想在应用内展示，可以不实现这个方法）
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    completionHandler(UNNotificationPresentationOptionNone);
}

// 对通知进行响应
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response {
    
    // 根据类别标识符处理目标反应
    self.notiID = response.notification.request.identifier;
    NSString *sysVersion = [UIDevice currentDevice].systemVersion;
}


- (void)_handleResponse:(UNNotificationResponse *)response {
    
    NSString *actionIndentifier = response.actionIdentifier;
    
    // 处理留言
    if ([actionIndentifier isEqualToString:@"inputIndentifier"]) {
        
        UNTextInputNotificationResponse *input = (UNTextInputNotificationResponse *)response;
        UIViewController *navVC = (UIViewController *)self.window.rootViewController;
        navVC.view.backgroundColor = [UIColor redColor];
        [[UIPasteboard generalPasteboard] setString:input.userText];
    }
    // 处理确定点击事件
    else if ([actionIndentifier isEqualToString:@"commitIndentifier"]) {
        
        UIViewController *navVC = (UIViewController *)self.window.rootViewController;
        navVC.view.backgroundColor =[UIColor greenColor];
    }
    // 处理取消点击事件
    else {
        
        UIViewController *navVC = (UIViewController *)self.window.rootViewController;
        navVC.view.backgroundColor =[UIColor yellowColor];
    }
}
#endif


//iOS 8.0 , 10.0
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)(void))completionHandler
{
    completionHandler();
}

/**didReceiveNotificationResponse
 只有当发送出一个本地通知, 并且满足以下条件时, 才会调用该方法
 APP 处于前台情况
 当用用户点击了通知, 从后台, 进入到前台时,
 当锁屏状态下, 用户点击了通知, 从后台进入前台
 
 注意: 当App彻底退出时, 用户点击通知, 打开APP , 不会调用这个方法
 
 但是会把通知的参数传递给 application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
 
 */

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"%s", __FUNCTION__);
    
    // 查看当前的状态出于(前台: 0)/(后台: 2)/(从后台进入前台: 1)
    
    // 执行响应操作
    // 如果当前App在前台,执行操作
    if (application.applicationState == UIApplicationStateActive) {
    } else if (application.applicationState == UIApplicationStateInactive) {
        self.notiID = [notification.userInfo objectForKey:identifier];
        // 后台进入前台
    } else if (application.applicationState == UIApplicationStateBackground) {
        // 当前App在后台
        self.notiID = [notification.userInfo objectForKey:identifier];
    }
    
    NSString *sysVersion = [UIDevice currentDevice].systemVersion;
}

///
- (void)resetNotiID {
    self.notiID = @"";
}
@end
/*
 NSString *const identifier = @"YTidentifier";
 NSString *const cateID = @"YTCateID999";
 NSString *const YAUNDefaultImage = @"splash_icon";
 NSString *const YALocalNotiCateIdentifier = @"YALocalNotiCateID";
 */




