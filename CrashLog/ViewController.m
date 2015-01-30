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
#import "FMDB.h"
#define  TABLENAME @"event_table"
#define  EVENTID @"eventId"
#define  TIME @"timestamp"
#define TYPE @"type"
#import "TSqliteManager.h"
#import "JSONKit.h"
@interface ViewController ()
{
    FMDatabase * db ;
}
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TSqliteManager * manager = [TSqliteManager shareInstance];
    [manager creatSqliteDb:@"user.sqlite"];
    NSLog(@"-----------creatSqliteDb--------");

//    [self creatDb];
//    [self insertDb];
//    [self selectDb];

//initional setup after loading the view, typically from a nib.
}
- (IBAction)addButtonEvnet:(id)sender {
    TEvent * myEvent = [[TEvent alloc]init];
    myEvent.eventId = @"0";
    myEvent.timestamp = @"1234646";
    myEvent.type = @"1";
    [[TSqliteManager shareInstance]insertSqliteDb:myEvent];
        NSLog(@"-----------insertSqliteDb--------");
}
- (IBAction)seleteButtonEvent:(id)sender {
    NSMutableArray * dataArray = [[TSqliteManager shareInstance] seleteSqliteDb];
     NSLog(@"-----------seleteButtonEvent--------");
    for (TEvent * myEVnet  in dataArray) {
        NSLog(@"_____---%@---%@-----%@",myEVnet.eventId,myEVnet.type,myEVnet.timestamp);
    }

}
- (IBAction)deleteButtonEvent:(id)sender {
    [[TSqliteManager shareInstance] deleteSqliteDb ];
    NSLog(@"-----------deleteButtonEvent--------");
}
- (IBAction)jsonButtonEvent:(id)sender {
       NSMutableArray * dataArray = [[TSqliteManager shareInstance] seleteSqliteDb];
    NSMutableDictionary * dic  = nil;
 
    NSString * json = [TSqliteManager stringDataJson:dataArray];
    NSLog(@"----json----%@",json);
}
-(void)creatDb
{
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString * dbPath = [docsdir stringByAppendingString:@"/Caches/user.sqlite"];
    NSLog(@"______path_______%@",dbPath);
    db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' INTEGER, '%@' TEXT)",TABLENAME,@"fid",EVENTID,TYPE,TIME];
        BOOL res = [db executeUpdate:sqlCreateTable];
        if (res) {
           NSLog(@"error when creating db table");
        } else {
              NSLog(@"success to creating db table");
        }
    }
    [db close];
}
-(void)insertDb
{
    if ([db open]) {
        NSString *insertSql1= [NSString stringWithFormat:
                               @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
                               TABLENAME, EVENTID, TYPE, TIME, @"0", @"1", @"123456077"];
        BOOL res = [db executeUpdate:insertSql1];
        NSString *insertSql2 = [NSString stringWithFormat:
                                @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
                                TABLENAME, EVENTID, TYPE  , TIME, @"2", @"1", @"61732872385"];
         res = [db executeUpdate:insertSql2];
        if (res) {
                NSLog(@"success to insert db table");
        } else {
                 NSLog(@"error when insert db table");
        }
        [db close];
    }
}
-(void)selectDb {
    if ([db open]) {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM %@",TABLENAME];
         FMResultSet * rs = [db executeQuery:sql ];
        while ([rs next]) {
            NSInteger  Id = [rs intForColumn:@"fid"];
            NSString * eventId = [rs stringForColumn:EVENTID];
            NSString * timestamp = [rs stringForColumn:TIME];
            NSString * type = [rs stringForColumn:TYPE];
            NSLog(@"---%i--%@-----%@---%@---",Id,eventId,timestamp,type);
        }
    }
    [db close];


}
//- (IBAction)deleteButtonEvent:(id)sender {
//    if ([db open]) {
//        NSString * deleteSql = [NSString  stringWithFormat:@"delete from %@ where %@ = '%@'",TABLENAME, EVENTID ,@"0"];
//        BOOL res = [db executeUpdate:deleteSql];
//        if (res) {
//             NSLog(@"success to delete db table");
//        }  else  {
//
//            NSLog(@"error when delete db table");
//        }
//
//    }
//    [db close];
//    
//}

@end
