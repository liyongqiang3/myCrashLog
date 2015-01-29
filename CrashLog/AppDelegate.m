//
//  AppDelegate.m
//  CrashLog
//
//  Created by 李永强 on 15/1/9.
//  Copyright (c) 2015年 tongbaotu. All rights reserved.
//

#import "AppDelegate.h"
#import "CurentTime.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
//    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
//    NSString *timeString = [NSString stringWithFormat:@"%.0f", [dat timeIntervalSince1970]];
//    NSLog(@"--------nowtimeStr-----------%@",timeString);
//    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
//    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
//    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
//    [dateFormatter setDateFormat:@"yyyyMMddHHMMss"];
//    NSDate * date = [dateFormatter dateFromString:timeString];
//    NSLog(@"------date--%@",date);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
void UncaughtExceptionHandler(NSException *exception){
    NSArray *arr = [exception callStackSymbols];//得到当前调用栈信息
    NSString *reason = [exception reason];//非常重要，就是崩溃的原因
    NSString *name = [exception name];//异常类型
    [[NSUserDefaults  standardUserDefaults] setObject:reason forKey:@"error_reason"];
  [[NSUserDefaults  standardUserDefaults] setObject:name forKey:@"error_name"];
    [[NSUserDefaults standardUserDefaults]setObject:[CurentTime getCurentTime] forKey:@"error_time"];
       [[NSUserDefaults standardUserDefaults]setObject:arr forKey:@"error_arr"];
    NSLog(@"exception type : %@ \n crash reason : %@ \n call stack info : %@", name, reason, arr);
}

@end
