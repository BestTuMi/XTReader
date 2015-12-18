//
//  NovelModel.h
//  XTReader
//
//  Created by gao7 on 15/12/3.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NovelModel : NSObject

@property (nonatomic, readwrite, copy) void(^completeBlock)(NSDictionary *dic,BOOL isSuccess);

- (void)loadWithUrl:(NSString *)url;
//
//- (NSArray *)getNovelArrayWithAppKey:(NSString *)appKey cat:(NSInteger)cat ranks:(NSInteger)ranks;

//
//- (NSArray *)getNovelArrayWithAppKey:(NSString *)appKey cat:(NSInteger)cat bookname:(NSString *)bookname;

// 返回小说内容
//- (void)getNovelArrayWithNovelCode:(NSString *)code andPage:(NSInteger)page;

@end
