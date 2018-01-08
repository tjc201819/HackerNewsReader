//
//  NHResultsController.m
//  HackerNewsReader
//
//  Created by Ivan Magda on 08/01/2018.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

#import "NHResultsController.h"

#import "HNPost.h"

#import "HNFeedDataSource.h"
#import "HNReadPostStore.h"
#import "HNPostCell.h"
#import "HNPostControllerHandling.h"
#import "UIViewController+UISplitViewController.h"
#import "HNCommentViewController.h"

@interface NHResultsController () <HNPostCellDelegate>

- (instancetype)initWithStyle:(UITableViewStyle)style NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@property(nonatomic, strong) HNFeedDataSource *feedDataSource;
@property(nonatomic, strong) HNReadPostStore *readPostStore;
@property(nonatomic, weak) UIViewController *originalController;

@end

@implementation NHResultsController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    @throw nil;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    @throw nil;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    @throw nil;
}

- (instancetype)initWithOriginalController:(UIViewController *)viewController andReadPostStore:(HNReadPostStore *)readPostStore {
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        _originalController = viewController;
        _readPostStore = readPostStore;
        _feedDataSource = [[HNFeedDataSource alloc] initWithTableView:self.tableView readPostStore:nil];
    }

    return self;
}

- (void)setPosts:(NSArray *)posts {
    self.feedDataSource.posts = posts;
    [self.tableView reloadData];
}

#pragma mark - Actions

- (void)didSelectPostAtIndexPath:(NSIndexPath *)indexPath {
    HNPost *post = self.feedDataSource.posts[(NSUInteger) indexPath.row];
    [self.readPostStore readPK:post.pk];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    UIViewController *controller = viewControllerForPost(post);
    [self.originalController hn_showDetailViewControllerWithFallback:controller];
}

- (void)didSelectPostCommentAtIndexPath:(NSIndexPath *)indexPath {
    HNPost *post = self.feedDataSource.posts[(NSUInteger) indexPath.row];
    HNCommentViewController *commentController = [[HNCommentViewController alloc] initWithPostID:post.pk];
    [self.originalController hn_showDetailViewControllerWithFallback:commentController];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.feedDataSource.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HNPostCell *cell = [self.feedDataSource cellForPostAtIndexPath:indexPath];
    cell.delegate = self;

    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.feedDataSource heightForPostAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self didSelectPostAtIndexPath:indexPath];
}

#pragma mark - HNPostCellDelegate

- (void)postCellDidTapCommentButton:(HNPostCell *)postCell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:postCell];
    [self didSelectPostCommentAtIndexPath:indexPath];
}

@end
