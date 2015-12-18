//
//  NovelContentObject.h
//  XTReader
//
//  Created by gao7 on 15/12/7.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NovelContentObject : NSObject

@property (nonatomic, readwrite, copy) NSString *code;
@property (nonatomic, readwrite, assign) NSInteger page;
@property (nonatomic, readwrite, copy) NSString *content;


- (NovelContentObject *)initWithDictionnary:(NSDictionary *)dic;

@end
