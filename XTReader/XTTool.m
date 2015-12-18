//
//  XTTool.m
//  XTReader
//
//  Created by gao7 on 15/12/4.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import "XTTool.h"

@implementation XTTool

+ (NSString *)getNovelContentWithNovelArray:(NSArray *)novelArray {
    NSMutableString *novelStr = [[NSMutableString alloc] init];
    for (NSString *line in novelArray) {
        [novelStr appendString:line];
        [novelStr appendString:@"/n"];
    }
    return novelStr;
}

@end
