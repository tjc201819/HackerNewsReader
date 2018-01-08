//
//  UIBarButtonItem+HackerNews.m
//  HackerNewsReader
//
//  Created by Ivan Magda on 08/01/2018.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

#import "UIBarButtonItem+HackerNews.h"

#import "UIColor+HackerNews.h"

@implementation UIBarButtonItem (HackerNews)

+ (void)hn_enableAppearance {
    if (@available(iOS 11.0, *)) {
        id appearance = [self appearanceWhenContainedInInstancesOfClasses:@[UISearchBar.class]];
        [appearance setTintColor:[UIColor hn_navigationTintColor]];
    }
}

@end
