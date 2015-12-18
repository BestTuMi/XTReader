//
//  DownNovelHelper.m
//  XTReader
//
//  Created by gao7 on 15/12/7.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import "DownNovelHelper.h"
#import "XTNovelService.h"

@implementation DownNovelHelper

DEF_SINGLETON(DownNovelHelper);

- (void)saveNovel:(NovelContentObject *)novelContentObejct {
    [[XTNovelService sharedInstance] addNovelContent:novelContentObejct];
}

- (NSString *)getNovelContentWithNovelCode:(NSString *)code page:(NSInteger)page {
    NSArray *contentArray = [[XTNovelService sharedInstance] getNovelContentArrayFromTabel:@"NovelContent"];
    for (NovelContentObject *contentObject in contentArray) {
        if ([contentObject.code isEqualToString:code] && (contentObject.page == page)) {
            return contentObject.content;
        }
    }
    return @"";
}

@end
