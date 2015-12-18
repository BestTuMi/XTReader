//
//  XTManager.m
//  XTReader
//
//  Created by gao7 on 15/12/5.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import "XTManager.h"

#define XTDatabaseName @"myDatabase.db"

@interface XTManager ()

@end

@implementation XTManager

DEF_SINGLETON(XTManager);

- (instancetype)init {
    XTManager *manager;
    if ((manager = [super init])) {
        [manager openDb:XTDatabaseName];
    }
    return manager;
}

- (void)openDb:(NSString *)dbname {
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"main path = %@",directory);
    NSString *filePath = [directory stringByAppendingPathComponent:dbname];
    if (SQLITE_OK == sqlite3_open(filePath.UTF8String, &_database)) {
        NSLog(@"open database success");
    }else {
        NSLog(@"open database fail");
    }
}

- (BOOL)executeNonQuery:(NSString *)sql {
    char *error;
    if (SQLITE_OK == sqlite3_exec(_database, sql.UTF8String, NULL, NULL, &error)) {
        NSLog(@"execute fail ,error message is %s",error);
        if (error) {
            return NO;
        }else {
            return YES;
        }
    }
    return NO;
}

- (NSArray *)executeQuery:(NSString *)sql {
    NSMutableArray *rows = [NSMutableArray array];
    
    sqlite3_stmt *stmt;
    if (SQLITE_OK == sqlite3_prepare_v2(_database, sql.UTF8String, -1, &stmt, NULL)) {
        
        while (SQLITE_ROW == sqlite3_step(stmt)) {      //行
            int columnCount = sqlite3_column_count(stmt);
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            for (int i=0; i<columnCount; i++) {
                const char *name = sqlite3_column_name(stmt, i); //列名
                const unsigned char *value = sqlite3_column_text(stmt, i); //列值
                dic[[NSString stringWithUTF8String:name]] = [NSString stringWithUTF8String:(const char *)value];
            }
            [rows addObject:dic];
        }
    }
    sqlite3_finalize(stmt);
    return rows;
}

@end
