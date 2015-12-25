//
//  MainViewController.m
//  XTReader
//
//  Created by gao7 on 15/12/1.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import "MainViewController.h"
#import "BookstoreViewController.h"
#import "XTNavigationController.h"
#import "BookshelfViewController.h"

@interface MainViewController ()<UIScrollViewDelegate>

@property (nonatomic, readwrite, strong) UIScrollView *mainScrollView;
@property (nonatomic, readwrite, strong) NSMutableArray *viewControllerArray;
@property (nonatomic, readwrite, strong) UIView *contentView;
@property (nonatomic, readwrite, strong) UIViewController *leftViewCon;

@end

@implementation MainViewController
static MainViewController *MainViewCon = nil;

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addView];
}

- (void)initWithLeftViewController:(UINavigationController *)leftViewController andRightViewController:(UINavigationController *)rightViewController {

//    _leftViewCon = leftViewController.topViewController;
    CGFloat width = 2*self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    _contentView = [[UIView alloc] init];

    [_mainScrollView addSubview:_contentView];

    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(_mainScrollView);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
    }];
    
    [_viewControllerArray addObject:leftViewController];
    [_viewControllerArray addObject:rightViewController];
    
    [_contentView addSubview:leftViewController.view];
    [_contentView addSubview:rightViewController.view];
    
    [leftViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.bottom.equalTo(_contentView);
        make.right.equalTo(leftViewController.view.mas_left);
//        make.right.equalTo(_contentView.mas_right);
        make.width.and.height.equalTo(rightViewController.view);
//        make.width.mas_equalTo(width);
//        make.height.mas_equalTo(height);
    }];
    
    [rightViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView.mas_top);
        make.left.equalTo(leftViewController.view.mas_right);
        make.bottom.equalTo(_contentView.mas_bottom);
        make.right.equalTo(_contentView.mas_right);
        make.width.and.height.equalTo(leftViewController.view);
//        make.width.mas_equalTo(width);
//        make.height.mas_equalTo(height);
    }];
    
//    [_mainScrollView addSubview:leftViewController.view];
//    [_mainScrollView addSubview:rightViewController.view];
//    
//    [leftViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.and.bottom.equalTo(_mainScrollView);
//        make.right.equalTo(leftViewController.view.mas_left);
//        //        make.right.equalTo(_contentView.mas_right);
//        make.width.and.height.equalTo(self.view);
//        //        make.width.mas_equalTo(width);
//        //        make.height.mas_equalTo(height);
//    }];
//    
//    [rightViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_mainScrollView.mas_top);
//        make.left.equalTo(leftViewController.view.mas_right);
//        make.bottom.equalTo(_mainScrollView.mas_bottom);
//        make.right.equalTo(_mainScrollView.mas_right);
//        make.width.and.height.equalTo(leftViewController.view);
//        //        make.width.mas_equalTo(width);
//        //        make.height.mas_equalTo(height);
//    }];
}

- (void)addView {
//    CGFloat width = 2*self.view.bounds.size.width;
//    CGFloat height = self.view.bounds.size.height;
    _mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    _mainScrollView.delegate = self;
    _mainScrollView.autoresizesSubviews = NO;
//    _mainScrollView.backgroundColor = [UIColor redColor];
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.bounces = NO;
    _mainScrollView.scrollEnabled = NO;
//    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width*2, self.view.frame.size.height);
    [self.view addSubview:_mainScrollView];
    [_mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(self.view);
    }];
//
//    CGFloat width = 2*self.view.bounds.size.width;
//    CGFloat height = self.view.bounds.size.height;
//    _contentView = [[UIView alloc] init];
//    [_mainScrollView addSubview:_contentView];
//
//    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.bottom.and.right.equalTo(_mainScrollView);
//        make.width.mas_equalTo(width);
//        make.height.mas_equalTo(height);
//    }];
//    
//    
//    // modify by xutong 2015-12-18
//    BookshelfViewController *bookshelfViewCon = [[BookshelfViewController alloc] init];
//    BookstoreViewController *bookstoreViewCon = [[BookstoreViewController alloc] init];
//    XTNavigationController *bookshelfNav = [[XTNavigationController alloc] initWithRootViewController:bookshelfViewCon];
//    XTNavigationController *bookstoreNav = [[XTNavigationController alloc] initWithRootViewController:bookstoreViewCon];
//    
//    _viewControllerArray = [NSMutableArray array];
////    [_viewControllerArray addObject:bookshelfViewCon];
////    [_viewControllerArray addObject:bookstoreViewCon];
//    
//    [_mainScrollView addSubview:bookshelfViewCon.view];
//    [_mainScrollView addSubview:bookstoreViewCon.view];
//
//    [_contentView addSubview:bookshelfNav.view];
//    [_contentView addSubview:bookstoreNav.view];
//    
//    [bookshelfViewCon.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.and.bottom.mas_equalTo(_contentView);
//        make.right.mas_equalTo(bookstoreViewCon.view.mas_left);
//        //        make.right.equalTo(_contentView.mas_right);
//        make.width.and.height.mas_equalTo(bookstoreViewCon.view);
//        //        make.width.mas_equalTo(width);
//        //        make.height.mas_equalTo(height);
//    }];
//    
//    [bookstoreViewCon.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_contentView.mas_top);
//        make.left.mas_equalTo(bookshelfViewCon.view.mas_right);
//        make.bottom.mas_equalTo(_contentView.mas_bottom);
//        make.right.mas_equalTo(_contentView.mas_right);
//        make.width.and.height.mas_equalTo(bookshelfViewCon.view);
//        //        make.width.mas_equalTo(width);
//        //        make.height.mas_equalTo(height);
//    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _viewControllerArray = [NSMutableArray array];
    MainViewCon = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (MainViewController *)sharedInstance {
    @synchronized(self) {
        if (MainViewCon == nil) {
            MainViewCon = [[MainViewController alloc] init];
        }
    }
    return MainViewCon;
}

- (void)goToRightView {
    [_mainScrollView scrollRectToVisible:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height) animated:YES];
}

- (void)backLeftView {
    [_mainScrollView scrollRectToVisible:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) animated:YES];
    [((BookshelfViewController *)_leftViewCon) refresh];
}

//
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.x;
    if (offset < 0)
    {
        return;
    }
    //    CGFloat width = scrollView.frame.size.width;
    
    for (UIViewController *viewController in _viewControllerArray)
    {
        NSInteger index = [_viewControllerArray indexOfObject:viewController];
        CGFloat width = _mainScrollView.frame.size.width;
        CGFloat y = index * width;
        CGFloat value = (offset-y)/width;
        //        CGFloat scale = 1.f-fabs(value);
        CGFloat scale = fabs(cos(fabs(value)*M_PI/5));
        
        //        if (scale > 1.f) scale = 1.f;
        //        if (scale < .9f) scale = .9f;
        
        viewController.view.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    for (UIViewController *viewController in self.childViewControllers)
    {
        CALayer *layer = viewController.view.layer;
        layer.shadowPath = [UIBezierPath bezierPathWithRect:viewController.view.bounds].CGPath;
    }
    
    if (offset > (self.view.bounds.size.width-10)) {
//        [self backLeftView];
        [((BookshelfViewController *)_leftViewCon) refresh];
    }
}

@end
