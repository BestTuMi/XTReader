 //
//  BookReadViewController.m
//  XTReader
//
//  Created by gao7 on 15/12/5.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import "BookReadViewController.h"
#import "GetImageArrayFromTxt.h"
#import "NovelModel.h"
#import "DataTypeHelper.h"
#import "DownNovelHelper.h"
#import "NovelObject.h"
#import "ReadStateObject.h"
#import "XTNovelService.h"

#import "LeavesPageHelper.h"


@interface BookReadViewController ()<UIAlertViewDelegate>{
//    NSInteger _currentIndex;
    double _fontSize;
    BOOL _isTap;
//    NSInteger _page;
}

@property (nonatomic, readwrite, strong) NSMutableArray *images;
@property (nonatomic, readwrite, strong) NSMutableArray *novelImageArray;
@property (nonatomic, readwrite, strong) NSArray *resultArray;
@property (nonatomic, readwrite, strong) UIView *bottomView;
@property (nonatomic, readwrite, strong) NovelObject *novelObject;
@property (nonatomic, readwrite, strong) NovelContentObject *novelContentObject;
@property (nonatomic, readwrite, strong) ReadStateObject *readStateObject;
@property (nonatomic, readwrite, copy) NSString *novelContent;
@property (nonatomic, readwrite, assign) NSInteger page;
@property (nonatomic, readwrite, assign) NSInteger currentImagePage;
@property (nonatomic, readwrite, strong) LeavesPageHelper *pageHelper;

@property (nonatomic, readwrite, assign) BOOL isTurnToEndBlock;

@property (nonatomic, readwrite, strong)  UIButton *rightButton;

@end

@implementation BookReadViewController

CGAffineTransform aspectFit(CGRect innerRect, CGRect outerRect) {
    CGFloat scaleFactor = MIN(outerRect.size.width/innerRect.size.width, outerRect.size.height/innerRect.size.height);
    CGAffineTransform scale = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
    CGRect scaledInnerRect = CGRectApplyAffineTransform(innerRect, scale);
    CGAffineTransform translation =
    CGAffineTransformMakeTranslation((outerRect.size.width - scaledInnerRect.size.width) / 2 - scaledInnerRect.origin.x,
                                     (outerRect.size.height - scaledInnerRect.size.height) / 2 - scaledInnerRect.origin.y);
    return CGAffineTransformConcat(scale, translation);
}

- (id)initWithNovelObject:(NovelObject *)novelObject {
    if (self = [super init]) {
        _novelObject = novelObject;
//        [self initDate];
//        [self addBottomView];
//        [leavesView reloadData];
        [self addNovelToDB];
        self.title = novelObject.title;
    }
    return self;
}

- (void)addNovelToDB {
    NSArray *resultArray = [[XTNovelService sharedInstance] getNovelArrayFromTabel:@"NovelRecenty"];
    BOOL isRead = NO;
    for (NovelObject *novelObj in resultArray) {
        if ([_novelObject.code isEqualToString:novelObj.code]) {
            isRead = YES;
            [[XTNovelService sharedInstance] removeNovelWithNovelCode:novelObj.code withTable:@"NovelRecenty"];
            NSLog(@"already read");
        }
    }
//    if (!isRead) {
        [[XTNovelService sharedInstance] addNovel:_novelObject withTable:@"NovelRecenty"];
//    }
    
}

- (void)addNovelReadState {
    if (_novelContent == nil || [_novelContent isEqualToString:@""]) {
        
    }else {
        _readStateObject = [[XTNovelService sharedInstance] getReadStateObjectWith:_novelObject.code];
        if (_readStateObject) {
            [[XTNovelService sharedInstance] modifyReadState:_novelContentObject urlPage:_novelContentObject.page currentPage:_currentImagePage novelContent:_novelContent];
        }else {
            [[XTNovelService sharedInstance] addReadState:_novelContentObject urlPage:_novelContentObject.page currentPage:_currentImagePage novelContent:_novelContent];
        }
    }
}

- (void)addLeavesPageHelper {
    _pageHelper = [[LeavesPageHelper alloc] init];
    _pageHelper.fontSize = _fontSize;
    _pageHelper.pageSize = self.view.frame.size;
    _pageHelper.isFontSizeChange = NO;
    //    _pageHelper = [[LeavesPageHelper alloc] initWithFontSize:_fontSize Content:@"" pageSize:self.view.frame.size];
}

- (void)initDate {
    self.page = 1;
    self.currentImagePage = 0;
    self.novelContent = @"";
    self.isTurnToEndBlock = NO;
    _novelContentObject = [[NovelContentObject alloc] init];
    _novelContentObject.code = _novelObject.code;
    [_novelContentObject setPage:_page];
    _fontSize = 20;
    _isTap = NO;
//    _images = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"search.png"],[UIImage imageNamed:@"bookshelf.png"],nil];
    // 读取readState
    _readStateObject = [[XTNovelService sharedInstance] getReadStateObjectWith:_novelObject.code];
    if (_readStateObject) {
        _page = _readStateObject.urlPage;
        _currentImagePage = _readStateObject.currentPage;
        _novelContentObject.content = _readStateObject.novelContent;
        _leavesView.currentPageIndex = _currentImagePage;
        
        NSMutableString *myStr = [[NSMutableString alloc] init];
//        [myStr appendString:_pageHelper.content];
        [myStr appendString:_novelContent];
        [myStr appendString:self.novelContentObject.content];
        _novelContent = [NSString stringWithString:myStr];
        [_pageHelper setContent:[NSMutableString stringWithString:self.novelContentObject.content]];
        //        [_pageHelper reset];
        
        [self reloadData];
    }else {
        [self getUrlRequset];
    }
}


- (BOOL)getUrlRequset {
    
    NovelModel *novelModel = [[NovelModel alloc] init];
    __block BOOL isSuccess;
    isSuccess = YES;
    __weak __typeof(&*self) weakSelf = self;
    [novelModel setCompleteBlock:^(NSDictionary *dic,BOOL isSuccess) {
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        if (isSuccess) {
        
            strongSelf.novelContentObject.content = [DataTypeHelper parseNovelContent:dic];
            //        strongSelf.novelImageArray = [GetImageArrayFromTxt getImageCount:1 fromIndex:0 andImageSize:self.view.frame.size txtFile:strongSelf.novelContent andFont:[UIFont systemFontOfSize:_fontSize]];
//            strongSelf.novelContent = strongSelf.novelContentObject.content;
            [strongSelf saveContent];
            
            NSMutableString *myStr = [[NSMutableString alloc] init];
//            [myStr appendString:_pageHelper.content];
            [myStr appendString:strongSelf.novelContent];
            [myStr appendString:self.novelContentObject.content];
            strongSelf.novelContent = [NSString stringWithString:myStr];
            
            [_pageHelper setContent:[NSMutableString stringWithString:self.novelContentObject.content]];
            
//            [_pageHelper.content appendString:self.novelContentObject.content];
            //        [_pageHelper reset];
            //        if (_page == 1) {
            [strongSelf reloadData];
//            strongSelf.page ++;
            strongSelf.novelContentObject.page = strongSelf.page;
            strongSelf.isTurnToEndBlock = NO;
            //        }
        }else {
            if (self.isTurnToEndBlock) {
                strongSelf.page --;
                strongSelf.novelContentObject.page = strongSelf.page;
            }
            self.isTurnToEndBlock = NO;
            //  判断内容是否为空
            if (self.novelContent == nil || [self.novelContent isEqualToString:@""]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tip" message:@"书本未上架" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
                alert.delegate = self;
                [alert show];
            }
        }
        isSuccess = isSuccess;
    }];
    
    NSString *result = [[DownNovelHelper sharedInstance] getNovelContentWithNovelCode:_novelContentObject.code page:_page];
    if ([result isEqualToString:@""]) {
        NSString *url=[NSString stringWithFormat:@"http://japi.juhe.cn/book/content.from?code=%@&cat=1&page=%ld&key=%@",_novelObject.code,(long)_page,AppKey];
        //    NSString *testurl=[NSString stringWithFormat:@"http://v.juhe.cn/weixin/query?pno=1&ps=20&dtype=&key=7b44f3619becc07a284ad46e158ed08a"];
        
        [novelModel loadWithUrl:url];
    }else {
        _novelContentObject.content = result;
        NSMutableString *myStr = [[NSMutableString alloc] init];
//        [myStr appendString:_pageHelper.content];
        [myStr appendString:_novelContent];
        [myStr appendString:self.novelContentObject.content];
        _novelContent = [NSString stringWithString:myStr];
        [_pageHelper setContent:[NSMutableString stringWithString:self.novelContentObject.content]];
//            [_pageHelper reset];
//            if (_page == 1) {
            [self reloadData];
//            }
    
        
    }
    return isSuccess;
}


- (void)addBottomView {
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 100)];
    _bottomView.backgroundColor = [UIColor lightGrayColor];
    _bottomView.clipsToBounds = YES;
//    _bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    UIButton *reduceFontSizeButton = [[UIButton alloc] init];
    reduceFontSizeButton.tag = 1000;
    [reduceFontSizeButton setImage:[UIImage imageNamed:@"reduce.png"] forState:UIControlStateNormal];
    [reduceFontSizeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    reduceFontSizeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_bottomView addSubview:reduceFontSizeButton];
    
    UIButton *addFontSizeButton = [[UIButton alloc] init];
    addFontSizeButton.tag = 1001;
    [addFontSizeButton setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [addFontSizeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    addFontSizeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_bottomView addSubview:addFontSizeButton];
    
    [reduceFontSizeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomView.mas_top).offset(10);
        make.left.equalTo(_bottomView.mas_left).offset(10);
//        make.bottom.equalTo(_bottomView.mas_bottom).offset(60);
        make.right.equalTo(addFontSizeButton.mas_left).offset(-10);
        make.width.equalTo(addFontSizeButton);
        make.height.equalTo(addFontSizeButton);
    }];
    
    [addFontSizeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomView.mas_top).offset(10);
        make.left.equalTo(reduceFontSizeButton.mas_right).offset(10);
//        make.bottom.equalTo(_bottomView.mas_bottom).offset(60);
        make.right.equalTo(_bottomView.mas_right).offset(-10);
        make.width.equalTo(addFontSizeButton);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *redBackgounndButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 70, 24, 24)];
    redBackgounndButton.tag = 101;
    redBackgounndButton.layer.cornerRadius = 12;
    redBackgounndButton.backgroundColor = [UIColor redColor];
    [redBackgounndButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:redBackgounndButton];
    
    UIButton *greenBackgounndButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/3, 70, 24, 24)];
    greenBackgounndButton.tag = 102;
    greenBackgounndButton.layer.cornerRadius = 12;
    greenBackgounndButton.backgroundColor = [UIColor greenColor];
    [greenBackgounndButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:greenBackgounndButton];
    
    UIButton *whiteBackgounndButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/3*2, 70, 24, 24)];
    whiteBackgounndButton.tag = 103;
    whiteBackgounndButton.layer.cornerRadius = 12;
    whiteBackgounndButton.backgroundColor = [UIColor whiteColor];
    [whiteBackgounndButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:whiteBackgounndButton];
    
    [self.view addSubview:_bottomView];
    
}

- (void)loadView {
    [super loadView];
    [self addLeavesPageHelper];
    [self initDate];
    [self addTapEvent];
    [self addBottomView];
    
    __weak __typeof(&*self) weakSelf = self;
    [_pageHelper setTurnToEndBlock:^(void){
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        //        strongSelf.currentImagePage = index;
        strongSelf.isTurnToEndBlock = YES;
        strongSelf.page++;
        [strongSelf getUrlRequset];
//        if ([strongSelf getUrlRequset]) {
//            strongSelf.novelContentObject.page = strongSelf.page;
//        }else {
//            strongSelf.page --;
//            strongSelf.novelContentObject.page = strongSelf.page;
//        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavRightBarButtonItemWithTitleName:@"加入书架"];
    if ([self isCollect]) {
        [_rightButton setEnabled:NO];
        NSLog(@"已收藏");
        [_rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }else {
        [_rightButton setEnabled:YES];
    }
//    [[UIApplication sharedApplication] setStatusBarHidden:TRUE withAnimation:UIStatusBarAnimationSlide];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
//    // 系统会多加1。
//    _currentImagePage --;
    [self addNovelReadState];
    _pageHelper.novelContentArray = nil;
}

// rightButton
- (void)setNavRightBarButtonItemWithTitleName:(NSString *)titleName {
    

    if (!_rightButton) {
        //
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 27, 80, 30)];
    }
    [_rightButton setTitle:titleName forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:_rightButton];
    //    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(navigationRightBtnAction:)];
    //    rightItem.style = UIBarButtonItemStyleBordered;
    
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightButtonClick {

    if ([self isCollect]) {
        NSLog(@"已收藏");
    }else {
        [_rightButton setEnabled:NO];
//        [_rightButton setTitle:@"加入收藏" forState:UIControlStateNormal];
//        _collectTipLabel.text = @"collect fail";
        [_rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [[XTNovelService sharedInstance] addNovel:_novelObject withTable:@"NovelCollect"];
    }

}

- (BOOL)isCollect {
    NSArray *resultArray = [[XTNovelService sharedInstance] getNovelArrayFromTabel:@"NovelCollect"];
    BOOL isRead = NO;
    if (resultArray == nil) {
        return NO;
    }
    for (NovelObject *novelObj in resultArray) {
        if ([_novelObject.code isEqualToString:novelObj.code]) {
            isRead = YES;
            NSLog(@"already read");
        }
    }
    if (!isRead) {
//        [[XTNovelService sharedInstance] addNovel:_novelObject withTable:@"NovelCollect"];
//        [_rightButton setTitle:@"取消收藏" forState:UIControlStateNormal];
//        NSLog(@"cellect success");
        return NO;
    }else {
//        [_rightButton setTitle:@"加入收藏" forState:UIControlStateNormal];
//        //        _collectTipLabel.text = @"collect fail";
//        [[XTNovelService sharedInstance] removeNovel:_novelObject withTable:@"NovelCollect"];
        return YES;
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark leavesDelegate
- (NSUInteger) numberOfPagesInLeavesView:(LeavesView*)leavesView {
    NSLog(@"%ld",(long)_images.count);
    return 1000;
}


- (void) renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)ctx {
    
    NSLog(@"!!%ld",(long)index);
//    UIImage *image = [[GetImageArrayFromTxt getImageCount:1 fromIndex:index andImageSize:self.view.frame.size txtFile:@"dsafdsfdsafdsaf" andFont:[UIFont systemFontOfSize:_fontSize]] objectAtIndex:0];
//    UIImage *image = [_novelImageArray firstObject];
//    [_pageHelper setPageBlock: ^(UIImage *currentImage, NSInteger currentPage, NSInteger totalPage) {
//        
//    }];
    UIImage *image = [_pageHelper skipToPage:index];
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGAffineTransform transform = aspectFit(imageRect,CGContextGetClipBoundingBox(ctx));
    CGContextConcatCTM(ctx, transform);
    CGContextDrawImage(ctx, imageRect, [image CGImage]);
    
}

-(void)leavesView:(LeavesView *)leavesView willTurnToPageAtIndex:(NSUInteger)pageIndex
{
    [self hideTapView];
//    NSLog(@"%d",pageIndex);
    
}
-(void)leavesView:(LeavesView *)leavesView didTurnToPageAtIndex:(NSUInteger)pageIndex
{
    NSLog(@"~%d",pageIndex);
//    NSLog(@"Page   location=%ld",_pageHelper.location);
//    [_pageHelper setCurrentPage:pageIndex];
//    [_leavesView reloadData];
    _currentImagePage = pageIndex;
}

- (void)addTapEvent {
    UIGestureRecognizer *recognozer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:recognozer];
}

- (void)tap {
    if (_isTap) {
//        _isTap = NO;
        [self hideTapView];
    }else {
//        _isTap = YES;
        [self showTapView];
    }
}

- (void)showTapView {
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
//    self.prefersStatusBarHidden = NO;
    _isTap = YES;
    self.navigationController.navigationBarHidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        [self.bottomView setFrame:CGRectMake(0, self.view.bounds.size.height-100, self.view.bounds.size.width, 100)];
    }];
//    [self prefersStatusBarHidden];
}

- (void)hideTapView {
    _isTap = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.navigationController.navigationBarHidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        [self.bottomView setFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 100)];
    }];
//    [self prefersStatusBarHidden];
}

- (BOOL)prefersStatusBarHidden {
//    [super prefersStatusBarHidden];
    if (_isTap) {
        return NO;
    }else {
        return YES;
    }
}

- (void)buttonClick:(UIButton *)button {
    switch (button.tag) {
        case 101:
            _leavesView.backgroundColor = [UIColor redColor];
            break;
         
        case 102:
            _leavesView.backgroundColor = [UIColor greenColor];
            break;
            
        case 103:
            _leavesView.backgroundColor = [UIColor whiteColor];
            break;
            
        case 1000:
            if (_fontSize >= 15) {
                _fontSize--;
            }
            [_pageHelper setIsFontSizeChange:YES];
            [self reloadData];
            [_leavesView reloadData];
            break;
            
        case 1001:
            if (_fontSize <=25) {
                _fontSize++;
            }
             [_pageHelper setIsFontSizeChange:YES];
            [self reloadData];
            [_leavesView reloadData];
            break;
        default:
            break;
    }
}

- (void)reloadData {
//    NSString *testStr = @" 学术专著：学术专著主要是看学者的思路和见解，做学术专著的笔记时，我一般都会写的很细致，从目录到具体展开的章节目，我都会做相应笔记，有时还会具体到例举了哪些案例。长期下来，一方面锻炼了自己的思路逻辑，另一方面在之后的学习中，想要找相应资料也可以很快速度翻到笔记，找到自己想要的答案。\n硬货：当然看的不如闲书轻松爽快，总是强迫自己阅读，会逼着自己做一个阅读计划，每天读一";
//    _novelImageArray = [GetImageArrayFromTxt getImageCount:1 fromIndex:0 andImageSize:self.view.frame.size txtFile:self.novelContent andFont:[UIFont systemFontOfSize:_fontSize]];
//    [_pageHelper.content appendString:self.novelContentObject.content];
//    [_pageHelper reset];
//    [_pageHelper setFontSize:_fontSize];
//    [_pageHelper setContent:[NSMutableString stringWithString:_novelContent]];
//    [_pageHelper setPageSize:self.view.bounds.size];
   
//    __weak __typeof(&*self) weakSelf = self;
//    dispatch_queue_t queue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
//
//    dispatch_async(queue, ^{
//
//        __strong __typeof(&*weakSelf) strongSelf = weakSelf;
        [_pageHelper setFontSize:_fontSize];
//        [_pageHelper setContent:[NSMutableString stringWithString:_novelContent]];
        [_pageHelper resetWithComplete:^(BOOL needReload) {
//
//            if (needReload) {
//                [_leavesView reloadData];
//            }
        }];
    if (_page == 1 || _page == 2) {
        [_leavesView reloadData];
    }
//    });
//
//    [_pageHelper setPageBlock:^(UIImage *currentImage, NSInteger currentPage, NSInteger totalPage) {
//        
//    
//        
//    }];
    [_pageHelper setIsFontSizeChange:NO];
}

// 小说缓存
- (void)saveContent {
    NSString *result = [[DownNovelHelper sharedInstance] getNovelContentWithNovelCode:self.novelContentObject.code page:_page];
    if ([result isEqualToString:@""]) {
        [[DownNovelHelper sharedInstance] saveNovel:self.novelContentObject];
    }else {
        
    }
}

@end
