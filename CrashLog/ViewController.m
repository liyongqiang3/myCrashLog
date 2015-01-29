//
//  ViewController.m
//  CrashLog
//
//  Created by 李永强 on 15/1/9.
//  Copyright (c) 2015年 tongbaotu. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "Clas.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * reason =  [[NSUserDefaults standardUserDefaults] objectForKey:@"error_reason" ];
        NSString * name =  [[NSUserDefaults standardUserDefaults] objectForKey:@"error_name" ];
    NSString * time = [[NSUserDefaults standardUserDefaults] objectForKey:@"error_time"];
    NSArray * arr =[[NSUserDefaults standardUserDefaults] objectForKey:@"error_arr"];

    NSLog(@"-------reason------%@",reason);
       NSLog(@"-------name------%@",name);
     NSLog(@"-------arr------%@",arr);
    Student * myStudent =   nil ; // [[Student alloc]init];
    myStudent.age = 1 ;
    myStudent.name  = @"jksdj";
    NSLog(@"%@",myStudent.name);
    Clas * myClass = [[Clas alloc]init] ;
    NSLog(@"%@",myClass.students);
    NSDate * nowDate = [NSDate date] ;
    NSArray * dataArray = [[NSArray alloc]init];
    [dataArray writeToFile:nil atomically:YES];
    NSDictionary * dict = [[NSDictionary alloc]init];
    [dict writeToURL:nil atomically:YES];

//     NSLog(@"---now date ------%@",[self getCurentTime]);
//    [myClass setMyStudent:myStudent];
//    NSString * haode = [dataArray o bjectAtIndex:1];
    //[[NSUserDefaults  standardUserDefaults] setObject:reason forKey:@"error_reason"];
    [[NSUserDefaults  standardUserDefaults] setObject:name forKey:@"error_name"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSString * )getCurentTime{
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
