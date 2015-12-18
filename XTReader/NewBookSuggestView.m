//
//  NewBookSuggestView.m
//  XTReader
//
//  Created by gao7 on 15/12/2.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import "NewBookSuggestView.h"
#import "NovelModel.h"
#import "NovelObject.h"
#import "BookStoreTableViewCell.h"


@interface NewBookSuggestView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, readwrite, strong) UITableView *tableView;
@property (nonatomic, readwrite, strong) NSArray *novelArray;

@end

@implementation NewBookSuggestView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addView];
    }
    return self;
}

- (void)addView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self addSubview:_tableView];
    //    self.backgroundColor = [UIColor purpleColor];
    [self initData];
}

- (void)updateConstraints {
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(self.mas_top);
        make.top.left.and.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-64);
    }];
    [super updateConstraints];
    
}

- (void)refresh {
}

- (void)initData {
    NovelModel *novelModel = [[NovelModel alloc] init];
    
    __weak __typeof(&*self) weakSelf = self;
    [novelModel setCompleteBlock:^(NSDictionary *dic,BOOL isSuccess) {
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        strongSelf.novelArray = [DataTypeHelper parseNovelObjectType:dic];
        [strongSelf.tableView reloadData];
    }];
        NSString *url=[NSString stringWithFormat:@"http://japi.juhe.cn/book/recommend.from?key=%@&cat=1&ranks=1",AppKey];
//    NSString *testurl=[NSString stringWithFormat:@"http://v.juhe.cn/weixin/query?pno=1&ps=20&dtype=&key=7b44f3619becc07a284ad46e158ed08a"];
    
    [novelModel loadWithUrl:url];
//    _novelArray = [novelModel getNovelArrayWithAppKey:AppKey cat:1 ranks:2];
    
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _novelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NovelObject *novelObject;
    novelObject = [_novelArray objectAtIndex:indexPath.row];
    static NSString *identifier = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
//    }
//    cell.textLabel.text = novelObject.title;
//    return cell;
    BookStoreTableViewCell *bookcell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (bookcell == nil) {
        bookcell = [[BookStoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [bookcell setNovelImage:[UIImage imageNamed:@"test2.png"] title:novelObject.title];
    return bookcell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NovelObject *novelObject;
    novelObject = [_novelArray objectAtIndex:indexPath.row];
    NSLog(@"select me");
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellDidSelect:)]) {
        [self.delegate cellDidSelect:novelObject];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 84;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
