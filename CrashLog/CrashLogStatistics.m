//
//  CrashLogStatistics.m
//  CrashLog
//
//  Created by 李永强 on 15/1/9.
//  Copyright (c) 2015年 tongbaotu. All rights reserved.
//

#import "CrashLogStatistics.h"
#import "CurentTime.h"
@implementation CrashLogStatistics
+(void)collectionCrashLogStatistics:(NSException *)exception{
    NSArray *arr = [exception callStackSymbols];//得到当前调用栈信息
    NSString *reason = [exception reason];//非常重要，就是崩溃的原因
    NSString *name = [exception name];//异常类型
    [[NSUserDefaults  standardUserDefaults] setObject:reason forKey:@"error_reason"];
    [[NSUserDefaults  standardUserDefaults] setObject:name forKey:@"error_name"];
    [[NSUserDefaults standardUserDefaults]  setObject:[CurentTime getCurentTime] forKey:@"error_time"];
    [[NSUserDefaults standardUserDefaults]  setObject:arr forKey:@"error_arr"];

    NSLog(@"exception type : %@ \n crash reason : %@ \n call stack info : %@", name, reason, arr);
}
@end
