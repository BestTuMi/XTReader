//
//  RecentyReadViewController.m
//  XTReader
//
//  Created by gao7 on 15/12/9.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import "RecentyReadViewController.h"
#import "XTNovelService.h"
#import "NovelObject.h"
#import "BookReadViewController.h"

#import <AssetsLibrary/ALAsset.h>
#import <Photos/Photos.h>

@interface RecentyReadViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, readwrite, strong) UITableView *recentyTableView;

@property (nonatomic, readwrite, strong) NSArray *novelRecentyArray;


@end

@implementation RecentyReadViewController

- (void)loadView {
    [super loadView];
    self.title = @"最近阅读";
    self.view.backgroundColor = [UIColor whiteColor];
    _recentyTableView = [[UITableView alloc] init];
    _recentyTableView.dataSource = self;
    _recentyTableView.delegate = self;
    [self.view addSubview:_recentyTableView];
    
    [_recentyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(self.view);
    }];

}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.novelRecentyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    NovelObject *novelObject = [_novelRecentyArray objectAtIndex:(_novelRecentyArray.count-1-indexPath.row)];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.image = [UIImage imageNamed:@"test1.png"];
    cell.textLabel.text = novelObject.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NovelObject *novelObject = [_novelRecentyArray objectAtIndex:(_novelRecentyArray.count-1-indexPath.row)];
    BookReadViewController *bookreadCon = [[BookReadViewController alloc] initWithNovelObject:novelObject];
    [self.navigationController pushViewController:bookreadCon animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 84;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.novelRecentyArray = [[XTNovelService sharedInstance] getNovelArrayFromTabel:@"NovelRecenty"];
    
//    
//    ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
//    PHPhotoLibrary *phones = [[PHPhotoLibrary alloc] init];
    
//    [[XTNovelService sharedInstance] removeNovelWithNovelCode:@"100" withTable:@"NovelRecenty"];
//    [self.recentyTableView reloadData];
    NSLog(@"%d",self.novelRecentyArray.count);
    // Do any additional setup after loading the view.
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
