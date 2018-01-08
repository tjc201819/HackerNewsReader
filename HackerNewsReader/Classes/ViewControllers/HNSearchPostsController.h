//
//  HNSearchPostsController.h
//  HackerNewsReader
//
//  Created by Ryan Nystrom on 6/6/15.
//  Copyright (c) 2015 Ryan Nystrom. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@class HNReadPostStore;

@interface HNSearchPostsController : UISearchController

- (instancetype)initWithOriginalController:(UIViewController *)viewController
                          andReadPostStore:(HNReadPostStore *)readPostStore NS_DESIGNATED_INITIALIZER;

@property(nonatomic, copy) NSArray *posts;

@end

NS_ASSUME_NONNULL_END
