//
//  XTViewController.h
//  XTReader
//
//  Created by gao7 on 15/12/1.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTViewController : UIViewController
//
- (void)setNavLeftBarButtonItemWithImageName:(NSString *)imageName;
- (void)setNavRightBarButtonItemWithImageName:(NSString *)imageName;
- (void)setNavRightBarButtonItemWithTitleName:(NSString *)titleName;
- (void)setNavTitleViewWithTitleNameArray:(NSArray *)titleNameArray;

- (void)navigationLeftBtnAction:(UIButton *)sender;
- (void)navigationRightBtnAction:(UIButton *)sender;
- (void)buttonClick:(UIButton *)sender;

@end
