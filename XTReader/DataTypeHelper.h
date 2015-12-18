//
//  DataTypeHelper.h
//  XTReader
//
//  Created by gao7 on 15/12/3.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NovelContentObject.h"

@interface DataTypeHelper : NSObject

+ (NSArray *)parseNovelObjectType:(NSDictionary *)dic;

+ (NSString *)parseNovelContent:(NSDictionary *)dic;

//+ (NovelContentObject *)parseNovelContentObject:(NSDictionary *)dic;

@end
