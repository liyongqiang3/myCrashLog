//
//  TSqliteManager.m
//  CrashLog
//
//  Created by 李永强 on 15/1/29.
//  Copyright (c) 2015年 tongbaotu. All rights reserved.
//

#import "TSqliteManager.h"
#define  TABLENAME @"event_table"
#define  EVENTID @"eventId"
#define  TIME @"timestamp"
#define TYPE @"type"

@implementation TSqliteManager
+(TSqliteManager *)shareInstance
{
    static TSqliteManager * manager = nil ;
    static dispatch_once_t token ;
    dispatch_once(&token, ^{
        manager = [[TSqliteManager alloc]initManager];
    });
    return manager ;
}
-(id)initManager{
    self = [super init];
    if (self) {

    }
    return self ;
}
-(id)init
{
    return  [TSqliteManager shareInstance];
}
-(void)creatSqliteDb:(NSString *)dbName
{
     NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString * dbPath = [docsdir stringByAppendingFormat:@"/Caches/%@",dbName];
    NSLog(@"______path_______%@",dbPath);
    baseDbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
     NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' INTEGER, '%@' TEXT)",TABLENAME,@"fid",EVENTID,TYPE,TIME];
    [baseDbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:sqlCreateTable];

    }];
//    if ([baseDb open]) {
//        NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' INTEGER, '%@' TEXT)",TABLENAME,@"fid",EVENTID,TYPE,TIME];
//        BOOL res = [baseDb executeUpdate:sqlCreateTable];
//        if (res) {
//            NSLog(@"error when creating db table");
//        } else {
//            NSLog(@"success to creating db table");
//        }
//    }
//    [baseDb close];
}

-(void)insertSqliteDb:(TEvent *)event {
    NSString *insertSql1= [NSString stringWithFormat:
                           @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
                           TABLENAME, EVENTID, TYPE, TIME, event.eventId,event.type, event.timestamp];


    [baseDbQueue  inDatabase:^(FMDatabase *db) {

        [db executeUpdate:insertSql1];

    }];
}

-(NSMutableArray *)seleteSqliteDb {
    NSString * sql = [NSString stringWithFormat:
                      @"SELECT * FROM %@",TABLENAME];
    NSMutableArray * dataArray = [[NSMutableArray alloc]init];
    [baseDbQueue  inDatabase:^(FMDatabase *db) {
         FMResultSet *rs = [db executeQuery:sql];
        while ([rs  next]) {
            TEvent * myEvent = [[TEvent alloc]init];
            myEvent.eventId = [rs stringForColumn:EVENTID];
            myEvent.timestamp = [rs stringForColumn:TIME];
            myEvent.type = [rs stringForColumn:TYPE];
            [dataArray addObject:myEvent];

        }
        NSLog(@"________inDatabase______");
    }];
    return dataArray ;

}

-(void)deleteSqliteDb{
       NSString * deleteSql = [NSString  stringWithFormat:@"delete from %@",TABLENAME];
    [baseDbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:deleteSql];

    }];
}

+(NSString *)stringDataJson:(NSArray *)dataArray
{
    NSString * allString = @"[";
    BOOL isFrist = NO ;
    for (TEvent * myEvent in dataArray ) {
        if (isFrist == NO) {
            allString = [allString stringByAppendingFormat:@"{\"id\":\"%@\",\"type\":\"%@\",\"time\":\"%@\"}",myEvent.eventId,myEvent.type,myEvent.timestamp];
            isFrist = YES ;
        } else {
            allString = [allString stringByAppendingFormat:@",{\"id\":\"%@\",\"type\":\"%@\",\"time\":\"%@\"}",myEvent.eventId,myEvent.type,myEvent.timestamp];
        }
    }
    allString  = [allString stringByAppendingString:@"]"];
    return allString ;

}

@end
