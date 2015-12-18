//
//  LeavesPageHelper.m
//  Leaves
//
//  Created by 涂勇彬 on 15/12/4.
//  Copyright © 2015年 Tom Brow. All rights reserved.
//

#import "LeavesPageHelper.h"
#import "YAScreenShotClass.h"

static LeavesPageHelper *kInstance = nil;

@interface LeavesPageHelper () {

    NSInteger _totalPages;
    UILabel *_textLabel;
//    UITextView *_textView;
    NSRange *_rangeOfPages;

}

@end


@implementation LeavesPageHelper

+ (LeavesPageHelper *)sharedInstance {

    @synchronized(self)
    {
        if (kInstance == nil)
        {
            kInstance = [[LeavesPageHelper alloc] init];
        }
    }
    
    return kInstance;
}

+ (void)releaseInstance {

    @synchronized(self)
    {
        if (kInstance != nil)
        {
            kInstance = nil;
        }
    }
}

- (instancetype)init {

    if (self=[super init]) {
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.backgroundColor = [UIColor whiteColor];
        _textLabel.numberOfLines = 0;
//        _textLabel.adjustsFontSizeToFitWidth = YES;
//        _textLabel.minimumScaleFactor = _pageSize.width;
//        _textView = [[UITextView alloc] initWithFrame:CGRectZero];
//        _textView.backgroundColor = [UIColor whiteColor];
        _content = [NSMutableString string];
        _novelContentArray = [NSMutableArray array];
        _standardLength = 0;
//        [self initData];
    }
    
    return self;
}

- (void)initData {
    _location = 0;
    _currentPage = 0;
//    _length = 100;
}

- (CGSize)sizeOfString:(NSString *)text {

    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending) {
        
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:_fontSize]};
        CGSize size = [text boundingRectWithSize:CGSizeMake(_pageSize.width, CGFLOAT_MAX) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        return size;
        
    }else {
    
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:_fontSize]
             constrainedToSize:CGSizeMake(_pageSize.width, CGFLOAT_MAX)
                 lineBreakMode:UILineBreakModeWordWrap];
        
        return size;
    }
}

- (void)resetWithComplete:(void(^)(BOOL needReload))block {
    
//    dispatch_queue_t queue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
//    
//    dispatch_async(queue, ^{
        NSDate *dateBegin = [NSDate date];
        _totalPages = 0;
        if (_content==nil || [_content isEqualToString:@""] || _pageSize.height <= 0) {
            return;
        }
        
        //    NSInteger wordIndex = 0;
        //    if (_currentPage != 0) {
        //        if (_rangeOfPages != NULL) {
        //            NSRange range = _rangeOfPages[_currentPage];
        //            wordIndex = range.location + range.length/2;
        //        }
        //    }
        
        //包装小说内容
    if (_isFontSizeChange) {
        NSMutableString *content = [NSMutableString string];
        for (NSString *perContent in _novelContentArray) {
            [content appendString:perContent];
        }
        _content = content;
        [_novelContentArray removeAllObjects];
    }else
        if (_novelContentArray.count > 0) {
            NSString *lastPageContent = [_novelContentArray lastObject];
            NSMutableString *content = [NSMutableString string];
            [content appendString:lastPageContent];
            [content appendString:_content];
            _content = content;
            [_novelContentArray removeLastObject];
        }
        // 计算文本串的大小尺寸
        CGSize totalTextSize = [self sizeOfString:_content];
        
        NSLog(@"LeavesPageHelper.time1:%f", [[NSDate date] timeIntervalSinceDate:dateBegin]);
        
        
        // 如果一页就能显示完，直接显示所有文本串即可。
        if (totalTextSize.height < _pageSize.height) {
            _textLabel.text = _content;
            //        _textView.text = _content;
        }
        else {
            // 计算理想状态下的页面数量和每页所显示的字符数量，只是拿来作为参考值用而已！
            NSUInteger textLength = [_content length];
            NSInteger referTotalPages = (NSInteger)totalTextSize.height/(NSInteger)_pageSize.height+1;
            //        NSInteger referTotalPages = (NSInteger)totalTextSize.height/(NSInteger)_pageSize.height;
            NSInteger referCharatersPerPage = textLength/referTotalPages;
            
            // 申请最终保存页面NSRange信息的数组缓冲区
            //        int maxPages = referTotalPages;
            //        _rangeOfPages = (NSRange *)malloc(referTotalPages*sizeof(NSRange));
            //        memset(_rangeOfPages, 0x0, referTotalPages*sizeof(NSRange));
            // 页面索引
            //        NSInteger page = 0;
            
            for (NSUInteger location = 0; location < textLength; ) {
                // 先计算临界点（尺寸刚刚超过UILabel尺寸时的文本串）
                NSRange range = NSMakeRange(location, referCharatersPerPage);
                
                // reach end of text ?
                NSString *pageText;
                CGSize pageTextSize;
//                NSInteger referCharatersAddPage = referCharatersPerPage;
//                if (_standardLength > 0) {
//                    _standardLength = _standardLength + 150;
//                }else {
                    while (range.location + range.length < textLength) {
                        
                        pageText = [_content substringWithRange:range];
                        pageTextSize = [self sizeOfString:pageText];
                        
                        if (pageTextSize.height > _pageSize.height) {
                            
                            break;
                        }
                        else {
//                            range.length += referCharatersAddPage/2;
//                            referCharatersAddPage = referCharatersAddPage/2;
//                            if (referCharatersAddPage < 1) {
//                                break;
//                            }
                            range.length += 10;
                        }
                    }
//                }
                if (range.location + range.length >= textLength) {
                    range.length = textLength - range.location;
                }else {
                    // 然后一个个缩短字符串的长度，当缩短后的字符串尺寸小于textLabel的尺寸时即为满足
                    //                NSLog(@"checkTime:%f", [[NSDate date] timeIntervalSinceDate:dateBegin]);
                    while (range.length > 0) {
                        
                        pageText = [_content substringWithRange:range];
                        pageTextSize = [self sizeOfString:pageText];
                        
                        if (pageTextSize.height <= _pageSize.height) {
                            range.length = [pageText length];
                            break;
                        }
                        else {
                            range.length -= 2;
                        }
                    }
                    //                NSLog(@"checkTime2:%f", [[NSDate date] timeIntervalSinceDate:dateBegin]);
                }
                // 得到一个页面的显示范围
                //            if (page >= maxPages) {
                //                maxPages += 2;
                //                _rangeOfPages = (NSRange *)realloc(_rangeOfPages, maxPages*sizeof(NSRange));
                //            }
                
                //            if (wordIndex>=range.location && wordIndex<=range.location+range.length-1) {
                //                _currentPage = page;
                //            }
//                if (_standardLength <= 0) {
//                    _standardLength = range.length;
//                }
                //            _rangeOfPages[page++] = range;
                if (pageText != nil) {
                    [_novelContentArray addObject:pageText];
                }
                // 更新游标
                location += range.length;
            }
            
            // 获取最终页面数量
            //        _totalPages = page;
            _totalPages = _novelContentArray.count;
        }
        
        //    NSLog(@"LeavesPageHelper.time2:%f", [[NSDate date] timeIntervalSinceDate:dateBegin]);
        
        
        block(YES);
        
        //获取当前页面
        UIImage *image = [self imagePageAtIndex:_currentPage];
        if (self.pageBlock) {
            self.pageBlock(image, _currentPage, _totalPages);
        }
        
        NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:dateBegin];
        
        NSLog(@"LeavesPageHelper3.time:%f", time);
//    });
    

}

//- (void)reset {
//    
//    NSDate *dateBegin = [NSDate date];
//    _totalPages = 0;
//    if (_content==nil || [_content isEqualToString:@""] || _pageSize.height <= 0) {
//        return;
//    }
//    
////    NSInteger wordIndex = 0;
////    if (_currentPage != 0) {
////        if (_rangeOfPages != NULL) {
////            NSRange range = _rangeOfPages[_currentPage];
////            wordIndex = range.location + range.length/2;
////        }
////    }
//    
//    // 计算文本串的大小尺寸
//    CGSize totalTextSize = [self sizeOfString:_content];
//    
//    NSLog(@"LeavesPageHelper.time1:%f", [[NSDate date] timeIntervalSinceDate:dateBegin]);
//
//    
//    // 如果一页就能显示完，直接显示所有文本串即可。
//    if (totalTextSize.height < _pageSize.height) {
//        _textLabel.text = _content;
////        _textView.text = _content;
//    }
//    else {
//        // 计算理想状态下的页面数量和每页所显示的字符数量，只是拿来作为参考值用而已！
//        NSUInteger textLength = [_content length];
//        NSInteger referTotalPages = (NSInteger)totalTextSize.height/(NSInteger)_pageSize.height+1;
////        NSInteger referTotalPages = (NSInteger)totalTextSize.height/(NSInteger)_pageSize.height;
//        NSInteger referCharatersPerPage = textLength/referTotalPages;
//        
//        // 申请最终保存页面NSRange信息的数组缓冲区
//        int maxPages = referTotalPages;
//        _rangeOfPages = (NSRange *)malloc(referTotalPages*sizeof(NSRange));
//        memset(_rangeOfPages, 0x0, referTotalPages*sizeof(NSRange));
//        // 页面索引
//        NSInteger page = 0;
//        
//        for (NSUInteger location = 0; location < textLength; ) {
//            // 先计算临界点（尺寸刚刚超过UILabel尺寸时的文本串）
//            NSRange range = NSMakeRange(location, referCharatersPerPage);
//            
//            // reach end of text ?
//            NSString *pageText;
//            CGSize pageTextSize;
//            NSInteger referCharatersAddPage = referCharatersPerPage;
//            if (_standardLength > 0) {
//                
//            }else {
//                while (range.location + range.length < textLength) {
//                    
//                    pageText = [_content substringWithRange:range];
//                    pageTextSize = [self sizeOfString:pageText];
//                    
//                    if (pageTextSize.height > _pageSize.height) {
//                        break;
//                    }
//                    else {
//                        range.length += referCharatersAddPage/2;
//                        referCharatersAddPage = referCharatersAddPage/2;
//                        if (referCharatersAddPage < 1) {
//                            break;
//                        }
//                    }
//                }
//            }
//            if (range.location + range.length >= textLength) {
//                range.length = textLength - range.location;
//            }else {
//                // 然后一个个缩短字符串的长度，当缩短后的字符串尺寸小于textLabel的尺寸时即为满足
////                NSLog(@"checkTime:%f", [[NSDate date] timeIntervalSinceDate:dateBegin]);
//                while (range.length > 0) {
//                    
//                    pageText = [_content substringWithRange:range];
//                    pageTextSize = [self sizeOfString:pageText];
//                    
//                    if (pageTextSize.height <= _pageSize.height) {
//                        range.length = [pageText length];
//                        break;
//                    }
//                    else {
//                        range.length -= 2;
//                    }
//                }
////                NSLog(@"checkTime2:%f", [[NSDate date] timeIntervalSinceDate:dateBegin]);
//            }
//            // 得到一个页面的显示范围
//            if (page >= maxPages) {
//                maxPages += 2;
//                _rangeOfPages = (NSRange *)realloc(_rangeOfPages, maxPages*sizeof(NSRange));
//            }
//            
////            if (wordIndex>=range.location && wordIndex<=range.location+range.length-1) {
////                _currentPage = page;
////            }
//            _standardLength = range.length;
//            
//            _rangeOfPages[page++] = range;
//            
//            // 更新游标
//            location += range.length;
//        }
//        
//        // 获取最终页面数量
//        _totalPages = page;
//    }
//    
////    NSLog(@"LeavesPageHelper.time2:%f", [[NSDate date] timeIntervalSinceDate:dateBegin]);
//
//    
//    //获取当前页面
//    UIImage *image = [self imagePageAtIndex:_currentPage];
//    if (self.pageBlock) {
//        self.pageBlock(image, _currentPage, _totalPages);
//    }
//    
//    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:dateBegin];
//    
//    NSLog(@"LeavesPageHelper3.time:%f", time);
//}

- (NSString *)getPageTextWithIndex:(NSInteger)index {
    
    NSString *pageText = @"";
    // 计算文本串的大小尺寸
    CGSize totalTextSize = [self sizeOfString:_content];
    NSDate *dateBegin = [NSDate date];
    NSLog(@"LeavesPageHelper.time1:%f", [[NSDate date] timeIntervalSinceDate:dateBegin]);
    
    // 计算理想状态下的页面数量和每页所显示的字符数量，只是拿来作为参考值用而已！
    NSUInteger textLength = [_content length];
    NSInteger referTotalPages;
    if (_pageSize.height == 0) {
        return pageText;
    }else{
        referTotalPages = (NSInteger)totalTextSize.height/(NSInteger)_pageSize.height+1;
    }
    NSInteger referCharatersPerPage = textLength/(referTotalPages-1);
    
    // 如果一页就能显示完，直接显示所有文本串即可。
    if (totalTextSize.height < _pageSize.height) {
        pageText = _content;
        //        _textView.text = _content;
    }else if(index >= _currentPage || index == 0) {
        // 计算理想状态下的页面数量和每页所显示的字符数量，只是拿来作为参考值用而已！
        //        NSUInteger textLength = [_content length];
        //        NSInteger referTotalPages = (NSInteger)totalTextSize.height/(NSInteger)_pageSize.height+1;
        //        NSInteger referCharatersPerPage = textLength/(referTotalPages-1);
        //        NSInteger location = _location;
        if (index == 0) {
            _location = 0;
        }
        NSInteger location = _location;
        NSRange range = NSMakeRange(location, referCharatersPerPage);
        // reach end of text ?
        CGSize pageTextSize;
        
        while (range.location + range.length < textLength) {
            pageText = [_content substringWithRange:range];
            
            pageTextSize = [self sizeOfString:pageText];
            
            if (pageTextSize.height > _pageSize.height) {
                break;
            }
            else {
                range.length += referCharatersPerPage/2;
                referCharatersPerPage = referCharatersPerPage/2;
                if (referCharatersPerPage < 1) {
                    break;
                }
            }
        }
        
        if (range.location + range.length >= textLength) {
            
            range.length = textLength - range.location;
        }else {
            
            // 然后一个个缩短字符串的长度，当缩短后的字符串尺寸小于textLabel的尺寸时即为满足
            while (range.length > 0) {
                
                pageText = [_content substringWithRange:range];
                pageTextSize = [self sizeOfString:pageText];
                
                if (pageTextSize.height <= _pageSize.height) {
                    range.length = [pageText length];
                    break;
                }
                else {
                    range.length -= 2;
                }
            }
        }
        _location += range.length;
        pageText = [_content substringWithRange:range];
        
    }else {
        NSInteger location = _location-referCharatersPerPage;
        if (location<0) {
            return pageText;
        }
        NSRange range = NSMakeRange(location, referCharatersPerPage);
        // reach end of text ?
        CGSize pageTextSize;
        
        while (range.location + range.length < textLength) {
            pageText = [_content substringWithRange:range];
            
            pageTextSize = [self sizeOfString:pageText];
            
            if (pageTextSize.height > _pageSize.height) {
                break;
            }
            else {
                range.length += referCharatersPerPage/2;
                referCharatersPerPage = referCharatersPerPage/2;
                range.location = _location - range.length;
                if (referCharatersPerPage < 1) {
                    break;
                }
            }
        }
        
        if (range.location + range.length >= textLength) {
            range.length = textLength - range.location;
          
        }
        
        // 然后一个个缩短字符串的长度，当缩短后的字符串尺寸小于textLabel的尺寸时即为满足
        while (range.length > 0 && range.location > 0) {
            
            pageText = [_content substringWithRange:range];
            pageTextSize = [self sizeOfString:pageText];
            
            if (pageTextSize.height <= _pageSize.height) {
                range.length = [pageText length];
                range.location = _location - range.length;
                break;
            }
            else {
                range.length -= 2;
                range.location = _location - range.length;
            }
        }
        
        _location = range.location;
        pageText = [_content substringWithRange:range];
        //        pageText = [_content substringWithRange:range];
        //        NSLog(@"LeavesPageHelper.time1:%f", [[NSDate date] timeIntervalSinceDate:dateBegin]);
        
        
    }
    //    NSLog(@"LeavesPageHelper.time1:%f", [[NSDate date] timeIntervalSinceDate:dateBegin]);
//    if (index+10 > referTotalPages) {
//        if (self.turnToEndBlock) {
//            self.turnToEndBlock();
//        }
//    }
    _totalPages = referTotalPages;
    NSLog(@"_location=%ld",_location);
    return pageText;
}

- (UIImage *)getPreviousPage {

    if (_currentPage > 0) {
        _currentPage--;
    }
    
    return [self imagePageAtIndex:_currentPage];
}

- (UIImage *)getNextPage {

    if (_currentPage < _totalPages-1) {
        _currentPage++;
    }
    
    return [self imagePageAtIndex:_currentPage];
}

- (UIImage *)skipToPage:(NSInteger)pageIndex {
    
    return [self imagePageAtIndex:pageIndex];
}

- (UIImage *)imagePageAtIndex:(NSInteger)index {
    _currentPage = index;
    if (_currentPage > _totalPages-1) {
        
        NSLog(@"已经是最后一页了");
        return nil;
    }
    if (_content == nil || [_content isEqualToString:@""]) {
        NSLog(@"content is nil");
        return nil;
    }
//    NSRange range = _rangeOfPages[_currentPage];
    NSString *pageText;
    if (index < _novelContentArray.count) {
        pageText = [_novelContentArray objectAtIndex:index];
    }
//    pageText = [self getPageTextWithIndex:index];
    _textLabel.text = pageText;
//    _textView.text = pageText;
    UIImage *image = [YAScreenShotClass screenShotFrom:_textLabel frame:_textLabel.bounds];
//    UIImage *image = [YAScreenShotClass screenShotFrom:_textView frame:_textView.bounds];
//    
    if (_currentPage >= _totalPages-5) {
        if (self.turnToEndBlock) {
            self.turnToEndBlock();
        }
    }
    return image;
}

- (void)setFontSize:(double)fontSize {

    _fontSize = fontSize;
    _textLabel.font = [UIFont systemFontOfSize:fontSize];
//    _textView.font = [UIFont systemFontOfSize:fontSize];
}

- (void)setPageSize:(CGSize)pageSize {
    
    _pageSize = CGSizeMake(pageSize.width, pageSize.height);
    _textLabel.frame = CGRectMake(0, 0, pageSize.width, pageSize.height);
//    _textView.frame = CGRectMake(20, 0, pageSize.width, pageSize.height);
}

@end
