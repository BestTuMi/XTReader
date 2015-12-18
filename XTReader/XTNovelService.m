//
//  XTNovelService.m
//  XTReader
//
//  Created by gao7 on 15/12/5.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import "XTNovelService.h"
#import "XTManager.h"

@interface XTNovelService ()

@end
@implementation XTNovelService

DEF_SINGLETON(XTNovelService);

- (BOOL)addNovel:(NovelObject *)novel withTable:(NSString *)tableName {
    NSString *addSql = [NSString stringWithFormat:@"INSERT INTO %@ (title,code) VALUES('%@','%@')",tableName,novel.title,novel.code];
    return [[XTManager sharedInstance] executeNonQuery:addSql];
}

- (void)removeNovel:(NovelObject *)novel withTable:(NSString *)tableName {
    NSString *removeSql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE Id = '%@'",tableName,novel.Id];
    [[XTManager sharedInstance] executeNonQuery:removeSql];
}

- (void)removeNovelWithNovelCode:(NSString *)code withTable:(NSString *)tableName {
    NSString *removeSql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE code = '%@'",tableName,code];
    [[XTManager sharedInstance] executeNonQuery:removeSql];

}

- (NSArray *)getNovelArrayFromTabel:(NSString *)tabelName {
    NSMutableArray *novelArray = [NSMutableArray array];
    NSArray *getArray;
    NSString *getSql = [NSString stringWithFormat:@"SELECT * FROM %@",tabelName];
    getArray = [[XTManager sharedInstance] executeQuery:getSql];
    for (NSDictionary *dic in getArray) {
        NovelObject *novel = [[NovelObject alloc] initWithDictionnary:dic];
        [novelArray addObject:novel];
    }
    return novelArray;
}

- (BOOL)addNovelContent:(NovelContentObject *)novelContent {
    NSString *addSql = [NSString stringWithFormat:@"INSERT INTO NovelContent(code,page,content) VALUES('%@','%ld','%@')",novelContent.code,(long)novelContent.page,novelContent.content];
    return [[XTManager sharedInstance] executeNonQuery:addSql];
}

- (NSArray *)getNovelContentArrayFromTabel:(NSString *)tabelName {
    NSMutableArray *novelArray = [NSMutableArray array];
    NSArray *getArray;
    NSString *getSql = [NSString stringWithFormat:@"SELECT * FROM %@",tabelName];
    getArray = [[XTManager sharedInstance] executeQuery:getSql];
    for (NSDictionary *dic in getArray) {
        NovelContentObject *novel = [[NovelContentObject alloc] initWithDictionnary:dic];
        [novelArray addObject:novel];
    }
    return novelArray;
}

- (BOOL)addReadState:(NovelContentObject *)novel urlPage:(NSInteger)urlPage currentPage:(NSInteger)currentPage novelContent:(NSString *)novelContent{
    NSString *addSql = [NSString stringWithFormat:@"INSERT INTO ReadState (novelCode,novelContent,urlPage,currentPage) VALUES('%@','%@','%ld','%ld')",novel.code,novelContent,(long)urlPage,(long)currentPage];
    return [[XTManager sharedInstance] executeNonQuery:addSql];
}

- (BOOL)modifyReadState:(NovelContentObject *)novel urlPage:(NSInteger)urlPage currentPage:(NSInteger)currentPage novelContent:(NSString *)novelContent{
    NSString *addSql = [NSString stringWithFormat:@"UPDATE ReadState SET novelContent='%@',urlPage='%ld',currentPage='%ld' WHERE novelCode='%@'",novelContent,(long)urlPage,(long)currentPage,novel.code];
    return [[XTManager sharedInstance] executeNonQuery:addSql];
}

- (ReadStateObject *)getReadStateObjectWith:(NSString *)novelCode {

    ReadStateObject *readStateObject;
    NSArray *getArray;
    NSString *getSql = [NSString stringWithFormat:@"SELECT * FROM ReadState where novelCode=%@",novelCode];
    getArray = [[XTManager sharedInstance] executeQuery:getSql];
    for (NSDictionary *dic in getArray) {
        readStateObject = [[ReadStateObject alloc] initWithDictionnary:dic];
    }
    return readStateObject;
}

@end
