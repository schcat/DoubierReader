//
//  MainViewController.h
//  DoubierReader
//
//  Created by Zhixue Li on 12/2/15.
//  Copyright © 2015 Zhixue Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSYViewPagerVC.h"

#import "SettingViewController.h"
#import "LeftSlideViewController.h"
#import "FindingViewController.h"
#import "ReadingNotesViewController.h"
#import "MyReadingViewController.h"

//#import "LeftSlideViewController.h"
#import "SearchingViewController.h"

@interface MainViewController :LSYViewPagerVC

@property (nonatomic, strong) MyReadingViewController *myreadingview;
@property (nonatomic, strong) FindingViewController *findingview;
@property (nonatomic, strong) ReadingNotesViewController *readingnotesview;

//@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;
//@property (nonatomic, strong) MyReadingViewController *myreadingview;
- (void)didClickHeadButtonAction:(UIButton *)button;
//- (void)reload;
@end
