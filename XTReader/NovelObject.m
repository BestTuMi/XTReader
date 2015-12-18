//
//  NovelObject.m
//  XTReader
//
//  Created by gao7 on 15/12/3.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import "NovelObject.h"

@implementation NovelObject

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    if ([aCoder allowsKeyedCoding]) {
        [aCoder encodeObject:self.title forKey:@"title"];
        [aCoder encodeObject:self.code forKey:@"code"];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
    }
    return self;
}

- (NovelObject *)initWithTitle:(NSString *)title code:(NSString *)code {
    self = [super init];
    if (self) {
        self.title = title;
        self.code = code;
    }
    return self;
}

- (NovelObject *)initWithDictionnary:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (NovelObject *)novelWithTitle:(NSString *)title code:(NSString *)code {
    NovelObject *novel = [[NovelObject alloc] initWithTitle:title code:code];
    return novel;
}

@end
