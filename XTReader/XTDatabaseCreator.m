//
//  XTDatabaseCreator.m
//  XTReader
//
//  Created by gao7 on 15/12/5.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import "XTDatabaseCreator.h"
#import "XTManager.h"

@implementation XTDatabaseCreator

// 利用了偏好设置进行保存当前创建状态（其实这也是数据存储的一部分），如果创建过了数据库则不再创建，否则创建数据库和表
+ (void)initDatabase {
    
    NSString *key=@"IsCreatedDb";
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    if ([[defaults valueForKey:key] integerValue] != 1) {
        [self createNovelCollectTable];
        [self createNovelRecentyTable];
        [self createNovelContentTable];
        [self createNovelReadStateTable];
        [defaults setValue:@1 forKey:key];
    }
    
}

+ (void)createNovelCollectTable {
    NSString *CreateTableSql = @"CREATE TABLE NovelCollect (Id integer PRIMARY KEY AUTOINCREMENT,title text,code text)";
    [[XTManager sharedInstance] executeNonQuery:CreateTableSql];
}

+ (void)createNovelRecentyTable {
    NSString *CreateTableSql = @"CREATE TABLE NovelRecenty (Id integer PRIMARY KEY AUTOINCREMENT,title text,code text)";
    [[XTManager sharedInstance] executeNonQuery:CreateTableSql];
}

+ (void)createNovelContentTable {
    NSString *CreateTableSql = @"CREATE TABLE NovelContent (code text,page int,content text)";
    [[XTManager sharedInstance] executeNonQuery:CreateTableSql];
}

+ (void)createNovelReadStateTable {
    NSString *CreateTableSql = @"CREATE TABLE ReadState (novelCode text,urlPage int,currentPage int,novelContent text)";
    [[XTManager sharedInstance] executeNonQuery:CreateTableSql];
}

@end
