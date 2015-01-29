//
//  Clas.h
//  CrashLog
//
//  Created by 李永强 on 15/1/9.
//  Copyright (c) 2015年 tongbaotu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
@interface Clas : NSObject
@property (copy,nonatomic)  NSString * classId ;
@property (strong,nonatomic) NSMutableArray * students ;
-(void)setMyStudent:(Student *)student ;
@end
