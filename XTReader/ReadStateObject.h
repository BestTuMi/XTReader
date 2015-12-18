//
//  ReadStateObject.h
//  XTReader
//
//  Created by gao7 on 15/12/10.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadStateObject : NSObject

@property (nonatomic, readwrite, copy) NSString *novelCode;
@property (nonatomic, readwrite, copy) NSString *novelContent;
@property (nonatomic, readwrite, assign) NSInteger urlPage;
@property (nonatomic, readwrite, assign) NSInteger currentPage;

- (ReadStateObject *)initWithDictionnary:(NSDictionary *)dic;

@end
