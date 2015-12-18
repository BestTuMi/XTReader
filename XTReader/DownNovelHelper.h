//
//  DownNovelHelper.h
//  XTReader
//
//  Created by gao7 on 15/12/7.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NovelContentObject.h"

@interface DownNovelHelper : NSObject

AS_SINGLETON(DownNovelHelper);

- (void)saveNovel:(NovelContentObject *)novelContentObejct;

- (NSString *)getNovelContentWithNovelCode:(NSString *)code page:(NSInteger)page;



@end
