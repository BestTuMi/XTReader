//
//  ReadStateObject.m
//  XTReader
//
//  Created by gao7 on 15/12/10.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import "ReadStateObject.h"

@implementation ReadStateObject

- (ReadStateObject *)initWithDictionnary:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end
