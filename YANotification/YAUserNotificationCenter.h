//
//  YAUserNotificationCenter.h
//  NSLocalNotificationDemo
//
//  Created by app-01 on 2017/10/10.
//  Copyright © 2017年 app-01 org. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface YAUserNotificationCenter : NSObject

+ (YAUserNotificationCenter *)getProperUserNotificationCenter;
/**
 * @param badge 0 to hide
 * @param notiID value should be unique(or will be weired).
 */
- (void)scheduleLocalNotificationWithID:(NSString *)notiID
                                  title:(NSString *)title
                               subTitle:(nullable NSString *)subTitle
                                   body:(NSString *)body
                              imagePath:(nullable NSString *)imagePath
                                  badge:(NSInteger)badge
                               fireTime:(NSTimeInterval)second
                                 action:(nullable NSString *)action;
- (void)cancelLocalNotificationWithID:(NSString *)notiID;
- (void)cancelAllLocalNotification;

- (void)goToNotificationSetting;
- (int)pushNotificationState;
- (void)requestNofiticationAuthentication:(void(^_Nullable)(BOOL flag))callBack;
- (void)removeNotificationAuthentication;
@end

extern NSString *const cateID;

NS_ASSUME_NONNULL_END
