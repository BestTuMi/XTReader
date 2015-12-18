//
//  LeavesPageHelper.h
//  Leaves
//
//  Created by 涂勇彬 on 15/12/4.
//  Copyright © 2015年 Tom Brow. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PageBlock)(UIImage *currentImage, NSInteger currentPage, NSInteger totalPage);

typedef void (^PageWillTurnToEndBlock)(void);

@interface LeavesPageHelper : NSObject

+ (LeavesPageHelper *)sharedInstance;

+ (void)releaseInstance;

@property(nonatomic, readwrite, assign) double fontSize;

@property(nonatomic, readwrite, copy) NSMutableString *content;

@property(nonatomic, readwrite, copy) PageBlock pageBlock;

@property(nonatomic, readwrite, assign) CGSize pageSize;

@property(nonatomic, readwrite, assign) NSInteger currentPage;

@property(nonatomic, readwrite, assign) NSInteger location;

@property(nonatomic, readwrite, assign) NSInteger standardLength;

@property(nonatomic, readwrite, copy) PageWillTurnToEndBlock turnToEndBlock;

@property (nonatomic, readwrite, strong) NSMutableArray *novelContentArray;

@property (nonatomic, readwrite, assign) BOOL isFontSizeChange;

- (void)resetWithComplete:(void(^)(BOOL needReload))block;

- (UIImage *)getPreviousPage;

- (UIImage *)getNextPage;

- (UIImage *)skipToPage:(NSInteger)pageIndex;

//- (instancetype)initWithFontSize:(double)fontSize Content:(NSString *)content pageSize:(CGSize)pageSize;

@end
