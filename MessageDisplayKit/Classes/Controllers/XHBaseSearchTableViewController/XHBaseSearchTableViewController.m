//
//  XHBaseSearchTableViewController.m
//  MessageDisplayExample
//
//  Created by 曾 宪华 on 14-5-22.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHBaseSearchTableViewController.h"

@interface XHBaseSearchTableViewController () <UISearchDisplayDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *aSearchBar;
@property (nonatomic) UISearchDisplayController *searchController;

@end

@implementation XHBaseSearchTableViewController

- (BOOL)enableForSearchTableView:(UITableView *)tableView {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return YES;
    }
    return NO;
}

#pragma mark - Propertys

- (UISearchBar *)aSearchBar {
    if (!_aSearchBar) {
        _aSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44)];
        _aSearchBar.delegate = self;
        
        _searchController = [[UISearchDisplayController alloc] initWithSearchBar:_aSearchBar contentsController:self];
        _searchController.delegate = self;
        _searchController.searchResultsDelegate = self;
        _searchController.searchResultsDataSource = self;
    }
    return _aSearchBar;
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self.tableView respondsToSelector:@selector(setSectionIndexBackgroundColor:)]) {
        self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    }
    
    self.tableView.tableHeaderView = self.aSearchBar;
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self enableForSearchTableView:tableView]) {
        return 1;
    }
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self enableForSearchTableView:tableView]) {
        return self.filteredDataSource.count;
    }
    return [self.dataSource[section] count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionIndexTitles;
}

#pragma mark - UITableView Delegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([self enableForSearchTableView:tableView]) {
        return nil;
    }
    BOOL showSection = [[self.dataSource objectAtIndex:section] count] != 0;
    //only show the section title if there are rows in the section
    return (showSection) ? [[UILocalizedIndexedCollation.currentCollation sectionTitles] objectAtIndex:section] : nil;
    
}

@end
