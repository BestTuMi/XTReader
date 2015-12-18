//
//  BookDetailViewController.m
//  XTReader
//
//  Created by gao7 on 15/12/3.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import "BookDetailViewController.h"
#import "BookDetailView.h"

#import "BookReadViewController.h"

@interface BookDetailViewController ()<BookDetailViewDelegate>

@property (nonatomic, readwrite, strong) BookDetailView *bookDetailView;
@property (nonatomic, readwrite, strong) NovelObject *novelObject;

@end

@implementation BookDetailViewController

- (instancetype)initWithNovelObject:(NovelObject *)novelObject {
    self = [super init];
    if (self) {
        _novelObject = novelObject;
//        [self loadView];
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    self.view.backgroundColor = [UIColor greenColor];

    _bookDetailView = [[BookDetailView alloc] initWithNovelObject:_novelObject];
    _bookDetailView.delegate = self;
//    _bookDetailView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_bookDetailView];
    [_bookDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(self.view);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [_bookDetailView refreshWithNovelObject:self.novelObject];
//    [self.view updateConstraintsIfNeeded];
}


#pragma mark BookDetailViewDelegate
- (void)readButtonDidSelected {
    BookReadViewController *bookreadCon = [[BookReadViewController alloc] initWithNovelObject:_novelObject];
    [self.navigationController pushViewController:bookreadCon animated:YES];
}

- (void)addBookshelfButtonDidSelected {
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
