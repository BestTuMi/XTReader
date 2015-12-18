//
//  SearchView.h
//  XTReader
//
//  Created by gao7 on 15/12/2.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class WeiXing;
@class NovelObject;
@protocol SearchViewDelegate <NSObject>

- (void)showSearchView;

- (void)hideSearchView;

- (void)cellDidSelect:(NovelObject *)novelObject;

@end

@interface SearchView : UIView

@property (nonatomic, readwrite, weak) id<SearchViewDelegate> delegate;

- (void)refresh;


@end
