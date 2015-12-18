//
//  XTManager.h
//  XTReader
//
//  Created by gao7 on 15/12/5.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface XTManager : NSObject

AS_SINGLETON(XTManager);

@property (nonatomic) sqlite3 *database;

- (void)openDb:(NSString *)dbname;

- (BOOL)executeNonQuery:(NSString *)sql;

- (NSArray *)executeQuery:(NSString *)sql;


@end
