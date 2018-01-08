//
//  NHResultsController.h
//  HackerNewsReader
//
//  Created by Ivan Magda on 08/01/2018.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNReadPostStore;

@interface NHResultsController : UITableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style NS_UNAVAILABLE;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (instancetype)initWithOriginalController:(UIViewController *)viewController
                          andReadPostStore:(HNReadPostStore *)readPostStore NS_DESIGNATED_INITIALIZER;

- (void)setPosts:(NSArray *)posts;

@end
