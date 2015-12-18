//
//  BookstoreViewController.m
//  XTReader
//
//  Created by gao7 on 15/12/1.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import "BookstoreViewController.h"
//#import "BookstoreView.h"
#import "MainViewController.h"

#import "TodaySuggestView.h"
#import "ClickRankingView.h"
#import "NewBookSuggestView.h"

#import "SearchViewController.h"
#import "BookDetailViewController.h"

@interface BookstoreViewController ()
<
    TodaySuggestViewDelegate,
    ClickRankingViewDelegate,
    NewBookSuggestViewDelegate
>

@property (nonatomic, readwrite, strong) UIScrollView *bookstoreScrollView;
@property (nonatomic, readwrite, strong) UIView *contentView;
@property (nonatomic, readwrite, strong) TodaySuggestView *todaySuggestView;
@property (nonatomic, readwrite, strong) ClickRankingView *clickRankingView;
@property (nonatomic, readwrite, strong) NewBookSuggestView *bookSuggestView;


@end

@implementation BookstoreViewController

- (void)loadView {
    [super loadView];
    self.view.autoresizesSubviews = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addView];
//    _searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, 100, 200, 200)];
//    loginView.delegate = self;
//    _searchView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.view addSubview:_searchView];
//
//    NSArray *searchViewHconstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_searchView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_searchView)];
//    NSArray *searchViewVconstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_searchView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_searchView)];
//    
//    [self.view addConstraints:searchViewHconstraints];
//    [self.view addConstraints:searchViewVconstraints];
//    
//    [_searchView refresh];
//    _searchView.hidden = YES;
}

- (void)addView {
    
    CGFloat width = 3*self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    _bookstoreScrollView = [[UIScrollView alloc] init];
    _bookstoreScrollView.translatesAutoresizingMaskIntoConstraints = NO;
//    _bookstoreScrollView.autoresizesSubviews = NO;
//    _bookstoreScrollView.autoresizingMask = UIViewAutoresizingNone;
    _bookstoreScrollView.bounces = NO;
    _bookstoreScrollView.pagingEnabled = YES;
    _bookstoreScrollView.scrollEnabled = NO;
//    _bookstoreScrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_bookstoreScrollView];
    
//    NSArray *bookstoreScrollViewHconstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_bookstoreScrollView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bookstoreScrollView)];
//
//    NSArray *bookstoreScrollViewVconstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_bookstoreScrollView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bookstoreScrollView)];
//
//    [self.view addConstraints:bookstoreScrollViewHconstraints];
//    [self.view addConstraints:bookstoreScrollViewVconstraints];
    
    [_bookstoreScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(self.view);
    }];
    
    _contentView = [[UIView alloc] init];
    _contentView.translatesAutoresizingMaskIntoConstraints = NO;
//    _contentView.backgroundColor = [UIColor redColor];
//    _contentView.autoresizesSubviews = NO;
    [_bookstoreScrollView addSubview:_contentView];
    
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bookstoreScrollView).offset(64);
        make.left.and.right.equalTo(_bookstoreScrollView);
        make.bottom.equalTo(_bookstoreScrollView.mas_bottom).offset(0);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
    }];
    
//    NSArray *contentViewHconstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_contentView(960)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentView)];
//    
//    NSArray *contentViewVconstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_contentView(512)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentView)];
//    
//    [_bookstoreScrollView addConstraints:contentViewHconstraints];
//    [_bookstoreScrollView addConstraints:contentViewVconstraints];
    
    
    _todaySuggestView = [[TodaySuggestView alloc] init];
    _todaySuggestView.translatesAutoresizingMaskIntoConstraints = NO;
    _todaySuggestView.delegate = self;
//    _todaySuggestView.backgroundColor = [UIColor greenColor];
    [_contentView addSubview:_todaySuggestView];
    
    _clickRankingView = [[ClickRankingView alloc] init];
    _clickRankingView.delegate = self;
    _clickRankingView.translatesAutoresizingMaskIntoConstraints = NO;
    //    _clickRankingView.backgroundColor = [UIColor redColor];
    [_contentView addSubview:_clickRankingView];
    
    _bookSuggestView = [[NewBookSuggestView alloc] init];
    _bookSuggestView.delegate = self;
    _bookSuggestView.translatesAutoresizingMaskIntoConstraints = NO;
//        _bookSuggestView.backgroundColor = [UIColor yellowColor];
    [_contentView addSubview:_bookSuggestView];
    
    [_todaySuggestView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.bottom.equalTo(_contentView);
        make.right.equalTo(_clickRankingView.mas_left);
        make.width.and.height.equalTo(_bookstoreScrollView);
        //        make.width.mas_equalTo(width);
        //        make.height.mas_equalTo(height);
    }];
    
    
    [_clickRankingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView.mas_top);
        make.left.equalTo(_todaySuggestView.mas_right);
        make.bottom.equalTo(_contentView.mas_bottom);
        make.right.equalTo(_todaySuggestView.mas_left);
        make.width.and.height.equalTo(_bookstoreScrollView);
        //        make.width.mas_equalTo(width);
        //        make.height.mas_equalTo(height);
    }];
    
    [_bookSuggestView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView.mas_top);
        make.left.equalTo(_clickRankingView.mas_right);
        make.bottom.equalTo(_contentView.mas_bottom);
        make.right.equalTo(_contentView.mas_right);
        make.width.and.height.equalTo(_bookstoreScrollView);
        //        make.width.mas_equalTo(width);
        //        make.height.mas_equalTo(height);
    }];
    
//    NSArray *todaySuggestViewHconstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_todaySuggestView(320)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_todaySuggestView)];
//    
//    NSArray *todaySuggestViewVconstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_todaySuggestView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_todaySuggestView)];
//    
//    [_contentView addConstraints:todaySuggestViewHconstraints];
//    [_contentView addConstraints:todaySuggestViewVconstraints];
//    [_todaySuggestView refresh];
    
//    NSArray *clickRankingViewHconstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_todaySuggestView]-0-[_clickRankingView(320)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_clickRankingView,_todaySuggestView)];
//    NSArray *clickRankingViewVconstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_clickRankingView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_clickRankingView)];
//    
//    [_contentView addConstraints:clickRankingViewHconstraints];
//    [_contentView addConstraints:clickRankingViewVconstraints];
//    [_clickRankingView refresh];
    
//    NSArray *bookSuggestViewHconstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_clickRankingView]-0-[_bookSuggestView(320)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bookSuggestView,_clickRankingView)];
//    NSArray *bookSuggestViewVconstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_bookSuggestView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bookSuggestView)];
//    
//    [_contentView addConstraints:bookSuggestViewHconstraints];
//    [_contentView addConstraints:bookSuggestViewVconstraints];
//    [_bookSuggestView refresh];
    
//    
//    _searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, 100, 200, 200)];
//    [self.view addSubview:_searchView];
//    [_searchView refresh];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self addView];
    [self setNavLeftBarButtonItemWithImageName:@"bookshelf.png"];
    [self setNavTitleViewWithTitleNameArray:@[@"今日推荐",@"点击排行",@"新书推荐"]];
    [self setNavRightBarButtonItemWithImageName:@"search.png"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
- (void)navigationLeftBtnAction:(UIButton *)sender {
    [[MainViewController sharedInstance] backLeftView];
}

- (void)buttonClick:(UIButton *)sender {
    [super buttonClick:sender];
    if (sender.tag == 100) {
        [_bookstoreScrollView scrollRectToVisible:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) animated:YES];
        NSLog(@"100");
        
    }else if (sender.tag == 101) {
        [_bookstoreScrollView scrollRectToVisible:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height) animated:YES];
        NSLog(@"101");
        
    }else {
        [_bookstoreScrollView scrollRectToVisible:CGRectMake(self.view.frame.size.width*2, 0, self.view.frame.size.width, self.view.frame.size.height) animated:YES];
        NSLog(@"102");
    }
    
}

- (void)navigationRightBtnAction:(UIButton *)sender {
    SearchViewController *searchViewCon = [[SearchViewController alloc] init];
//    searchViewCon.hidesBottomBarWhenPushed = YES;
//    searchViewCon.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:searchViewCon animated:NO];
}

#pragma mark TodaySuggestView
- (void)cellDidSelect:(NovelObject *)novelObject {
    BookDetailViewController *bookDetailViewCon = [[BookDetailViewController alloc] initWithNovelObject:novelObject];
//    bookDetailViewCon.novelObject = novelObject;
    [self.navigationController pushViewController:bookDetailViewCon animated:YES];
}

@end
