//
//  MainViewController.h
//  XTReader
//
//  Created by gao7 on 15/12/1.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import "XTViewController.h"


@interface MainViewController : XTViewController

+ (MainViewController *)sharedInstance;

- (void)initWithLeftViewController:(UIViewController *)leftViewController andRightViewController:(UIViewController *)rightViewController;

- (void)goToRightView;

- (void)backLeftView;

@end
