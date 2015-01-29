//
//  CurentTime.m
//  CrashLog
//
//  Created by 李永强 on 15/1/9.
//  Copyright (c) 2015年 tongbaotu. All rights reserved.
//

#import "CurentTime.h"

@implementation CurentTime
+(NSString * )getCurentTime{
    // 获取系统当前时间
    NSDate * date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];

    //设置时间输出格式：
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:@"yyyy年MM月dd日 HH时mm分ss秒"];
    NSString * na = [df stringFromDate:currentDate];
    return  na ;
}
@end
