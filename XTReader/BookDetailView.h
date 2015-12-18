//
//  BookDetailView.h
//  XTReader
//
//  Created by gao7 on 15/12/3.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class WeiXing;
@protocol BookDetailViewDelegate <NSObject>

- (void)readButtonDidSelected;

- (void)addBookshelfButtonDidSelected;

@end
@class NovelObject;
@interface BookDetailView : UIView

@property (nonatomic, readwrite, weak) id<BookDetailViewDelegate> delegate;

- (instancetype)initWithNovelObject:(NovelObject *)novelObject;

- (void)refreshWithNovelObject:(NovelObject *)novelObject;

@end
