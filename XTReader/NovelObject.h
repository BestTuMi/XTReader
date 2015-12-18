//
//  NovelObject.h
//  XTReader
//
//  Created by gao7 on 15/12/3.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NovelObject : NSObject

@property (nonatomic, readwrite, strong) NSNumber *Id;
@property (nonatomic, readwrite, copy) NSString *title;
@property (nonatomic, readwrite, copy) NSString *code;
//@property (nonatomic, readwrite, strong) NSArray *contentArray;

- (NovelObject *)initWithTitle:(NSString *)title code:(NSString *)code;

- (NovelObject *)initWithDictionnary:(NSDictionary *)dic;

+ (NovelObject *)novelWithTitle:(NSString *)title code:(NSString *)code;
@end
