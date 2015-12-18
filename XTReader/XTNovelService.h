//
//  XTNovelService.h
//  XTReader
//
//  Created by gao7 on 15/12/5.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NovelObject.h"
#import "NovelContentObject.h"
#import "ReadStateObject.h"

@interface XTNovelService : NSObject

AS_SINGLETON(XTNovelService);

- (BOOL)addNovel:(NovelObject *)novel withTable:(NSString *)tableName;

- (void)removeNovel:(NovelObject *)novel withTable:(NSString *)tableName;

- (void)removeNovelWithNovelCode:(NSString *)code withTable:(NSString *)tableName;

- (NSArray *)getNovelArrayFromTabel:(NSString *)tabelName;

- (BOOL)addNovelContent:(NovelContentObject *)novelContent;

- (NSArray *)getNovelContentArrayFromTabel:(NSString *)tabelName;
//- (NSString *)getNovelContentArrayWith:(NSString *)code page:(NSInteger)page;

- (BOOL)addReadState:(NovelContentObject *)novel urlPage:(NSInteger)urlPage currentPage:(NSInteger)currentPage novelContent:(NSString *)novelContent;

- (BOOL)modifyReadState:(NovelContentObject *)novel urlPage:(NSInteger)urlPage currentPage:(NSInteger)currentPage novelContent:(NSString *)novelContent;

- (ReadStateObject *)getReadStateObjectWith:(NSString *)novelCode;

@end
