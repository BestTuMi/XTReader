//
//  SearchView.m
//  XTReader
//
//  Created by gao7 on 15/12/2.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import "SearchView.h"

#import "NovelModel.h"
#import "NovelObject.h"


@interface SearchView ()
<
    UITextFieldDelegate,
    UITableViewDataSource,
    UITableViewDelegate
>

@property (nonatomic, readwrite, strong) UITextField *searchTextField;
@property (nonatomic, readwrite, strong) UIButton *cancelButton;
@property (nonatomic, readwrite, strong) UITableView *resultTableView;
@property (nonatomic, readwrite, strong) NSArray *resultArray;

@end

@implementation SearchView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addView];
        self.backgroundColor = [UIColor whiteColor];
        _resultArray = [[NSArray alloc] init];
    }
    return self;
}

- (void)addView {
    _searchTextField = [[UITextField alloc] init];
    _searchTextField.delegate = self;
    _searchTextField.backgroundColor = [UIColor whiteColor];
    _searchTextField.placeholder = @"搜索";
//    _searchTextField.translatesAutoresizingMaskIntoConstraints = NO;
    
    _searchTextField.layer.cornerRadius = 5;
    _searchTextField.layer.borderWidth = 0.5f;
    _searchTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _searchTextField.keyboardType = UIKeyboardTypeDefault;
    _searchTextField.returnKeyType = UIReturnKeySearch;
    [self addSubview:_searchTextField];
    
    _cancelButton = [[UIButton alloc] init];
    _cancelButton.layer.cornerRadius = 3;
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _cancelButton.backgroundColor = [UIColor greenColor];
//    _cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelButton];
    
    _resultTableView = [[UITableView alloc] init];
    _resultTableView.dataSource = self;
    _resultTableView.delegate = self;
    
    [self addSubview:_resultTableView];
    
    
}

- (void)updateConstraints {
    [super updateConstraints];
    
    [_searchTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(32);
        make.left.equalTo(self.mas_left).offset(10);
//        make.right.equalTo(_cancelButton.mas_left).offset(20);
        make.height.mas_equalTo(30);
        
    }];
    
    [_cancelButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_searchTextField.mas_right).offset(10);
        make.top.equalTo(_searchTextField.mas_top);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    [_resultTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_searchTextField.mas_bottom).offset(10);
        make.left.bottom.and.right.equalTo(self);
    }];
 
}

- (void)refresh {
//    [self addView];
}

- (void)cancelButtonClick {
    
    [_searchTextField resignFirstResponder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(hideSearchView)]) {
        [self.delegate hideSearchView];
    }
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"search");
    NovelModel *novelModel = [[NovelModel alloc] init];
    
    __weak __typeof(&*self) weakSelf = self;
    [novelModel setCompleteBlock:^(NSDictionary *dic,BOOL isSuccess) {
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        strongSelf.resultArray = [DataTypeHelper parseNovelObjectType:dic];
        [strongSelf.resultTableView reloadData];
    }];
    
    NSString *keyWord = _searchTextField.text;
    NSString *kw = [keyWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSString *url=[NSString stringWithFormat:@"http://japi.juhe.cn/book/bookname.from?bookname=%@&cat=1&key=%@", kw,AppKey];
//    NSString *testurl=[NSString stringWithFormat:@"http://v.juhe.cn/weixin/query?pno=1&ps=20&dtype=&key=7b44f3619becc07a284ad46e158ed08a"];
    
    [novelModel loadWithUrl:url];
    [_searchTextField resignFirstResponder];
    return YES;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _resultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NovelObject *novelObject;
    novelObject = [_resultArray objectAtIndex:indexPath.row];
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
//    cell.textLabel.text = @"test";
    cell.textLabel.text = novelObject.title;
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NovelObject *novelObject;
    novelObject = [_resultArray objectAtIndex:indexPath.row];
    NSLog(@"select me");
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellDidSelect:)]) {
        [self.delegate cellDidSelect:novelObject];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
