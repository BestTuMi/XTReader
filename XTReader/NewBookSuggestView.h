//
//  NewBookSuggestView.h
//  XTReader
//
//  Created by gao7 on 15/12/2.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class WeiXing;
@class NovelObject;

@protocol NewBookSuggestViewDelegate <NSObject>

- (void)cellDidSelect:(NovelObject *)novelObject;

@end
@interface NewBookSuggestView : UIView


@property (nonatomic, readwrite, weak) id<NewBookSuggestViewDelegate> delegate;

- (void)refresh;

@end
