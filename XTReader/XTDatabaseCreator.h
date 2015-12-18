//
//  XTDatabaseCreator.h
//  XTReader
//
//  Created by gao7 on 15/12/5.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XTDatabaseCreator : NSObject

+ (void)initDatabase;

//  小说收藏表
+ (void)createNovelCollectTable;

// 小说最近阅读表
+ (void)createNovelRecentyTable;

// 小说内容缓存
+ (void)createNovelContentTable;

// 小说阅读状态保存
+ (void)createNovelReadStateTable;

@end
