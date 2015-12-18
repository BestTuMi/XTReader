//
//  SearchViewController.m
//  XTReader
//
//  Created by gao7 on 15/12/3.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchView.h"
#import "BookDetailViewController.h"

@interface SearchViewController ()<SearchViewDelegate>

@end

@implementation SearchViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    SearchView *searchView = [[SearchView alloc] init];
    searchView.translatesAutoresizingMaskIntoConstraints = NO;
    searchView.delegate = self;
    [self.view addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(self.view);
    }];
    
}

#pragma mark
- (void)hideSearchView {
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)showSearchView {

}

- (void)cellDidSelect:(NovelObject *)novelObject {
    BookDetailViewController *bookDetailViewCon = [[BookDetailViewController alloc] initWithNovelObject:novelObject];
//    bookDetailViewCon.novelObject = novelObject;
    [self.navigationController pushViewController:bookDetailViewCon animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
