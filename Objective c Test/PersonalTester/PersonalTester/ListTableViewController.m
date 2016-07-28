//
//  ListTableViewController.m
//  PersonalTester
//
//  Created by Thongpak on 7/2/2559 BE.
//  Copyright © 2559 Witawat Wanamonthon. All rights reserved.
//

#import "ListTableViewController.h"
#import "ListTableViewModel.h"

@interface ListTableViewController ()

@property (nonatomic, strong) ListTableViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [[ListTableViewModel alloc] initWithDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.viewModel refreshData];
}

- (void)onDataDidLoad {
    [self.tableView reloadData];
}

- (void)onDataDidLoadWithError:(NSError *)error {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error!"
                                                                             message:error.description
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showViewForPeople:(People *)people {
    [self performSegueWithIdentifier:@"view-profile" sender:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfPeoples];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basic-cell"];
    cell.textLabel.text = [self.viewModel peopleForIndex:indexPath.row].people_name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel selectPeopleAtIndex:indexPath.row];
}

@end
