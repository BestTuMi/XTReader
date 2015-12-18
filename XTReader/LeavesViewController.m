//
//  LeavesViewController.m
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright Tom Brow 2010. All rights reserved.
//

#import "LeavesViewController.h"

@interface LeavesViewController () 

@end

@implementation LeavesViewController

//- (void) initialize {
//   _leavesView = [[LeavesView alloc] initWithFrame:CGRectZero];
//}

//- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle
//{
//   if (self = [super initWithNibName:nibName bundle:nibBundle]) {
//      [self initialize];
//   }
//   return self;
//}

//- (id)init {
//   return [self initWithNibName:nil bundle:nil];
//}

//- (void) awakeFromNib {
//	[super awakeFromNib];
//	[self initialize];
//}

#pragma mark LeavesViewDataSource methods

- (NSUInteger) numberOfPagesInLeavesView:(LeavesView*)leavesView {
	return 0;
}

- (void) renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)ctx {
	
}

#pragma mark  UIViewController methods

- (void)loadView {
	[super loadView];
    _leavesView = [[LeavesView alloc] initWithFrame:self.view.bounds];
//	_leavesView.frame = self.view.bounds;
	_leavesView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	[self.view addSubview:_leavesView];
}

- (void) viewDidLoad {
	[super viewDidLoad];
	_leavesView.dataSource = self;
	_leavesView.delegate = self;
	[_leavesView reloadData];
}

@end
