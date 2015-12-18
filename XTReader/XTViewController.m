//
//  XTViewController.m
//  XTReader
//
//  Created by gao7 on 15/12/1.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import "XTViewController.h"

@interface XTViewController ()

@property (nonatomic, readwrite, strong) NSMutableArray *buttonArray;

@end

@implementation XTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _buttonArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - set

- (void)setNavLeftBarButtonItemWithImageName:(NSString *)imageName {
    
    UIButton *leftButton;
    if (!leftButton) {
        leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 28, 30, 30)];
    }
    UIImage *image = [UIImage imageNamed:imageName];
    [leftButton setImage:image forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(navigationLeftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];

    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)setNavRightBarButtonItemWithImageName:(NSString *)imageName {
    
    UIButton *rightButton;
    if (!rightButton) {
//
        rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 28, 30, 30)];
    }
    UIImage *image = [UIImage imageNamed:imageName];
    [rightButton setImage:image forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(navigationRightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(navigationRightBtnAction:)];
//    rightItem.style = UIBarButtonItemStyleBordered;
    
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setNavRightBarButtonItemWithTitleName:(NSString *)titleName {
    
    UIButton *rightButton;
    if (!rightButton) {
        //
        rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 28, 30, 30)];
    }
    [rightButton setTitle:titleName forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(navigationRightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    //    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(navigationRightBtnAction:)];
    //    rightItem.style = UIBarButtonItemStyleBordered;
    
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setNavTitleViewWithTitleNameArray:(NSArray *)titleNameArray {
    NSInteger count = titleNameArray.count;
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(6, 0, 54*count, 28)];
    titleView.layer.cornerRadius = 10;
    titleView.clipsToBounds = YES;
//    titleView.backgroundColor = [UIColor greenColor];
    for (NSInteger i=0; i<count; i++) {
        NSString *titleName = [titleNameArray objectAtIndex:i];
        UIButton *button = [[UIButton alloc] init];
        button.tag = 100+i;
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitle:titleName forState:UIControlStateNormal];
        if (i == 0) {
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor greenColor];
        }else {
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor whiteColor];
//        [button setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
        }
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
        [button setFrame:CGRectMake(54*i, 0, 54, 28)];
        [_buttonArray addObject:button];
    }
    self.navigationItem.titleView = titleView;
}

#pragma mark - action

- (void)navigationLeftBtnAction:(UIButton *)sender {
    
}

- (void)navigationRightBtnAction:(UIButton *)sender {
    
}

- (void)buttonClick:(UIButton *)sender {
    for (UIButton *button in _buttonArray) {
        if (button.tag == sender.tag) {
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor greenColor];
        }else {
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor whiteColor];
        }
    }
}

//

@end
