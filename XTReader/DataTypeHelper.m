//
//  DataTypeHelper.m
//  XTReader
//
//  Created by gao7 on 15/12/3.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import "DataTypeHelper.h"
#import "NovelObject.h"


@implementation DataTypeHelper

+ (NSArray *)parseNovelObjectType:(NSDictionary *)dic {
    
    NSMutableArray *array = [NSMutableArray array];
    NSArray *novelArray = [dic objectForKey:@"data"];
    for (NSDictionary *dic in novelArray) {
        NovelObject *novelObject = [[NovelObject alloc] init];
        novelObject.title = [dic objectForKey:@"title"];
        NSNumber *numberCode;
        numberCode = [dic objectForKey:@"code"];
        novelObject.code = [NSString stringWithFormat:@"%d",numberCode.intValue];
        [array addObject:novelObject];
    }
    return array;
    
}


+ (NSString *)parseNovelContent:(NSDictionary *)dic {
    
    NSMutableString *novelStr = [[NSMutableString alloc] init];
    NSArray *array = [dic objectForKey:@"data"];
    for (NSString *line in array) {
        [novelStr appendString:line];
        [novelStr appendString:@"\n"];
    }
    return novelStr;
}


@end
