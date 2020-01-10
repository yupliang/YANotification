//
//  YALocalPushHelper.m
//  Unity-iPhone
//
//  Created by app-01 on 2017/10/23.
//

#import "YALocalPushHelper.h"

@implementation YALocalPushHelper

/*
 [1,100] answer
 [101,200] challenge
 [201,300] coin
 [301,400] dailygift
 [401,500]text
 0 用户未点击通知
 */
+ (NSString *)getImagePathAccordingNotiID:(NSString *)notiID {
    NSString *imagePath = @"";
    if (notiID == nil && ![notiID respondsToSelector:@selector(intValue)]) {
        return imagePath;
    }
    int intID = [notiID intValue];
    if (intID >=1 && intID<=100) {
        imagePath = @"answer";
    } else if (intID>=101 && intID<=200) {
        imagePath = @"challenge";
    } else if (intID>=201 && intID<=300) {
        imagePath = @"coin";
    } else if (intID>=301 && intID<=400) {
        imagePath = @"dailygift";
    } else if (intID>=401 && intID<=500) {
        imagePath = @"text";
    }
    if (imagePath.length > 0) {
        imagePath = [[NSBundle mainBundle] pathForResource:imagePath ofType:@"png"];
    }
    return imagePath;
}
@end
