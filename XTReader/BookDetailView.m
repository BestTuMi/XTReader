
//
//  BookDetailView.m
//  XTReader
//
//  Created by gao7 on 15/12/3.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import "bookDetailView.h"
#import "NovelObject.h"

#import "XTNovelService.h"

@interface BookDetailView ()

@property (nonatomic, readwrite, strong) UILabel *bookLabel;
@property (nonatomic, readwrite, strong) UIButton *readButton;
@property (nonatomic, readwrite, strong) UIButton *addBookshelfButton;
@property (nonatomic, readwrite, strong) NovelObject *novelObject;

@property (nonatomic, readwrite, strong) UILabel *collectTipLabel;

@end

@implementation BookDetailView

- (instancetype)initWithNovelObject:(NovelObject *)novelObject {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _novelObject = novelObject;
        [self addView];
    }
    return self;
}

- (void)addView {
    _bookLabel = [[UILabel alloc] init];
    _bookLabel.textColor = [UIColor greenColor];
    _bookLabel.numberOfLines = 0;
    _bookLabel.text = _novelObject.title;
    [self addSubview:_bookLabel];
    
    _readButton = [[UIButton alloc] init];
    _readButton.backgroundColor = [UIColor greenColor];
    [_readButton setTitle:@"立即阅读" forState:UIControlStateNormal];
    [_readButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_readButton addTarget:self action:@selector(readButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_readButton];
    
    _addBookshelfButton = [[UIButton alloc] init];
    _addBookshelfButton.backgroundColor = [UIColor grayColor];
    [_addBookshelfButton setTitle:@"加入书架" forState:UIControlStateNormal];
    [_addBookshelfButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_addBookshelfButton addTarget:self action:@selector(addBookshelfButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addBookshelfButton];
    
    
    _collectTipLabel = [[UILabel alloc] init];
    _collectTipLabel.text = @"";
    _collectTipLabel.textColor = [UIColor redColor];
    _collectTipLabel.alpha = 0;
    [self addSubview:_collectTipLabel];
    
}

- (void)updateConstraints {
     [super updateConstraints];
    [_bookLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.and.height.mas_equalTo(150);
    }];
    
    [_readButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.width.equalTo(_addBookshelfButton);
    }];
    
    [_addBookshelfButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_readButton.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.right.equalTo(self.mas_right);
    }];
    
    [_collectTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(_addBookshelfButton.mas_top);
        make.width.equalTo(_addBookshelfButton);
        make.height.mas_equalTo(40);
    }];
    
   
    
}

- (void)refreshWithNovelObject:(NovelObject *)novelObject {
    _bookLabel.text = novelObject.title;
}

- (void)readButtonClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(readButtonDidSelected)]) {
        [self.delegate readButtonDidSelected];
    }
}

- (void)addBookshelfButtonClick {
    
    NSArray *resultArray = [[XTNovelService sharedInstance] getNovelArrayFromTabel:@"NovelCollect"];
    BOOL isRead = NO;
    if (resultArray == nil) {
        return;
    }
    for (NovelObject *novelObj in resultArray) {
        if ([_novelObject.code isEqualToString:novelObj.code]) {
            isRead = YES;
            NSLog(@"already read");
        }
    }
    if (!isRead) {
        [[XTNovelService sharedInstance] addNovel:_novelObject withTable:@"NovelCollect"];
        _collectTipLabel.text = @"collect success";
        NSLog(@"cellect success");
    }else {
        _collectTipLabel.text = @"collect fail";
    }
    [UIView animateWithDuration:1.5f animations:^{
        _collectTipLabel.alpha = 1.0;
    } completion:^(BOOL finished) {
        _collectTipLabel.alpha = 0;
    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
