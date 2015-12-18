//
//  BookshelfViewController.m
//  XTReader
//
//  Created by gao7 on 15/12/1.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import "BookshelfViewController.h"
#import "MainViewController.h"
#import "BookReadViewController.h"
#import "RecentyReadViewController.h"

#import "BookShelfTableViewCell.h"

#import "XTNovelService.h"
#import "XTDatabaseCreator.h"

@interface BookshelfViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (strong, nonatomic) IBOutlet UIButton *lastReadButton;

@property (strong, nonatomic) IBOutlet UIButton *recentlyButton;

@property (strong, nonatomic) IBOutlet UITableView *collectTableView;
@property (nonatomic, readwrite, strong) NSArray *novelCollectArray;
@property (nonatomic, readwrite, strong) NSArray *novelRecentyArray;

@end

@implementation BookshelfViewController

- (IBAction)recentlyButtonClick:(id)sender {
    RecentyReadViewController *recentyreadCon = [[RecentyReadViewController alloc] init];
    [self.navigationController pushViewController:recentyreadCon animated:YES];
}
- (IBAction)lastReadButtonClick:(id)sender {
    NovelObject *novelObject = [_novelRecentyArray lastObject];
    if (novelObject != nil && _novelRecentyArray.count > 0){
        BookReadViewController *bookreadCon = [[BookReadViewController alloc] initWithNovelObject:novelObject];
        [self.navigationController pushViewController:bookreadCon animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"书架";
    [self initData];
    [self setNavRightBarButtonItemWithImageName:@"bookstore.png"];
    self.mainScrollView.delegate = self;
    self.collectTableView.dataSource = self;
    self.collectTableView.delegate = self;
    _lastReadButton.layer.cornerRadius = 8;
    _lastReadButton.layer.borderWidth = 1;
    _lastReadButton.layer.borderColor = [UIColor greenColor].CGColor;
    
    _recentlyButton.layer.cornerRadius = 6;
    _recentlyButton.layer.borderWidth = 1;
    _recentlyButton.layer.borderColor = [UIColor greenColor].CGColor;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self initData];
//    [XTDatabaseCreator createNovelReadStateTable];
//    [[XTNovelService sharedInstance] removeNovelWithNovelCode:@"1696" withTable:@"ReadState"];
    [_collectTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh {
    [self initData];
    [_collectTableView reloadData];
}

- (void)initData {
    self.novelCollectArray = [[XTNovelService sharedInstance] getNovelArrayFromTabel:@"NovelCollect"];
    self.novelRecentyArray = [[XTNovelService sharedInstance] getNovelArrayFromTabel:@"NovelRecenty"];
    if (_novelRecentyArray.count > 0) {
        NovelObject *novelObject = [_novelRecentyArray lastObject];
        [_lastReadButton setTitle:novelObject.title forState:UIControlStateNormal];
    }
}

- (void)navigationRightBtnAction:(UIButton *)sender {
    [[MainViewController sharedInstance] goToRightView];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _novelCollectArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    NovelObject *novelObject = [_novelCollectArray objectAtIndex:indexPath.row];
    BookShelfTableViewCell *bookcell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
//    }
//    cell.textLabel.text = novelObject.title;
    if (bookcell == nil) {
        bookcell = [[BookShelfTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [bookcell setNovelImage:[UIImage imageNamed:@"test2.png"] title:novelObject.title];
//    return cell;
    return bookcell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NovelObject *novelObject = [_novelCollectArray objectAtIndex:indexPath.row];
        [[XTNovelService sharedInstance] removeNovel:novelObject withTable:@"NovelCollect"];
        [self refresh];
    }
}


#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"select");
    NovelObject *novelObject = [_novelCollectArray objectAtIndex:indexPath.row];
    BookReadViewController *bookreadCon = [[BookReadViewController alloc] initWithNovelObject:novelObject];
    [self.navigationController pushViewController:bookreadCon animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 84;
}
//#pragma mark UIGestureRecognizerDelegate
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    
//    if ([otherGestureRecognizer.view isKindOfClass:[UITableView class]]) {
//        return YES;
//    }else {
//        return NO;
//    }
//}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (self.mainScrollView.contentOffset.y == self.view.frame.size.height) {
//        self.collectTableView.scrollEnabled = YES;
//        self.mainScrollView.scrollEnabled = NO;
//        NSLog(@"bottom");
//    }else if (self.collectTableView.contentOffset.x == 95) {
//        self.collectTableView.scrollEnabled = NO;
//        self.mainScrollView.scrollEnabled = YES;
//        NSLog(@"top");
//    }
//    NSLog(@"scroll");
//}

@end
