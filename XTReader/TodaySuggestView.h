//
//  TodaySuggestView.h
//  XTReader
//
//  Created by gao7 on 15/12/2.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NovelObject.h"

@class NovelObject;

@protocol TodaySuggestViewDelegate <NSObject>

- (void)cellDidSelect:(NovelObject *)novelObject;

@end
@interface TodaySuggestView : UIView

@property (nonatomic, readwrite, weak) id<TodaySuggestViewDelegate> delegate;

- (void)refresh;


@end
