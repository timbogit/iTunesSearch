//
//  iTunesTableViewController.m
//  iTunesSearch
//
//  Created by Daniel Steinberg on 10/1/14.
//  Copyright (c) 2014 Dim Sum Thinking. All rights reserved.
//

#import "iTunesTableViewController.h"
#import "iTunesSearchController.h"
#import "iTunesItem.h"
#import "iTunesItemCell.h"
#import "iTunesDetailViewController.h"
#import "iTunesItemCell.h"

static NSString *const kCellID = @"iTunesCell";


@interface iTunesTableViewController ()<UISearchBarDelegate>
@property (strong, nonatomic) iTunesSearchController *search;
@end

@implementation iTunesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.search = [[iTunesSearchController alloc] init];
    self.title = NSLocalizedString(@"Search iTunes AppStore", @"title for the root view controller");
    [self.search addObserver:self
                  forKeyPath:@"count"
                     options:NSKeyValueObservingOptionNew
                     context:NULL];
    
    // adding a search bar
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, 40.f)];
    searchBar.delegate = self;
    self.tableView.tableHeaderView = searchBar;
    [self.tableView registerClass: [iTunesItemCell class] forCellReuseIdentifier: kCellID];
    self.tableView.estimatedRowHeight = 106.f;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    if (self.search) {
        [self.search removeObserver:self
                         forKeyPath:@"count"];
    }
    self.search = [[iTunesSearchController alloc] init];
    [self.search addObserver:self
                  forKeyPath:@"count"
                     options:NSKeyValueObservingOptionNew
                     context:NULL];
    [self.search performSearchWithTerm:searchBar.text];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.search count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    iTunesItemCell *cell = [tableView dequeueReusableCellWithIdentifier: kCellID
                                                           forIndexPath: indexPath];
    iTunesItem *item = [self.search itemAtIndex:indexPath.row];
    [cell displayContentForItem:item];
    cell.backgroundColor = (indexPath.row % 2 == 0) ? [UIColor colorWithWhite:.85f alpha:.75f] : [UIColor colorWithWhite:.95f alpha:.75f];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    iTunesDetailViewController *detailVC = [[iTunesDetailViewController alloc] init];
    detailVC.item = [self.search itemAtIndex:indexPath.row];
    
    // Show the new view controller
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
