//
//  NovelContentObject.m
//  XTReader
//
//  Created by gao7 on 15/12/7.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import "NovelContentObject.h"

@implementation NovelContentObject

- (NovelContentObject *)initWithDictionnary:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end
