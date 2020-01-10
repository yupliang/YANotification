//
//  YALocalNotiDelegate.h
//  NSLocalNotificationDemo
//
//  Created by app-01 on 2017/10/10.
//  Copyright © 2017年 app-01 org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface YALocalNotiDelegate : NSObject

@property (weak, nonatomic) UIWindow *window;
@property (nonatomic,copy,readonly) NSString *notiID;

- (void)resetNotiID;

///application life cycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

///delegate Methods
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler ;

//withCompletionHandler:(nonnull void (^)(void))completionHandler
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response;


//iOS 8.0 , 10.0
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)(void))completionHandler;

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;
@end

extern NSString *const YALocalNotiCateIdentifier;
extern NSString *const identifier;
extern NSString *const YTNotiType;
extern NSString *const YTNotiTypeLocal;
NS_ASSUME_NONNULL_END

