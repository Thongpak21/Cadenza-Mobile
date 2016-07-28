//
//  ProfileDetailViewController.m
//  PersonalTester
//
//  Created by Thongpak on 7/2/2559 BE.
//  Copyright © 2559 Witawat Wanamonthon. All rights reserved.
//

#import "ProfileDetailViewController.h"
#import "PeopleContext.h"
#import "Job.h"
#import "CreditCard.h"

@interface ProfileDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) PeopleContext *context;

@end

@implementation ProfileDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.context = [PeopleContext sharedInstance];
    self.title = self.context.selectedPeople.people_name;
}

- (NSInteger)numberOfCommonCardOfPeople:(People *)people andPeople:(People *)otherPeople {
    __block NSInteger commonCards = 0;
    [people.credit_card_own enumerateObjectsUsingBlock:^(CreditCard * _Nonnull obj, BOOL * _Nonnull stop) {
        if([otherPeople.credit_card_own containsObject:obj]){
            commonCards += 1;
        }
    }];
    return commonCards;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return self.context.selectedPeople.people_friends.count;
    }else if(section == 1){
        return self.context.selectedPeople.people_job.count;
    }else if(section == 2){
        return self.context.selectedPeople.credit_card_own.count;
    }else{
        return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0){
        return @"Friends";
    }else if(section == 1){
        return @"Jobs";
    }else if(section == 2){
        return @"Credit Cards";
    }else{
        return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellType = (indexPath.section == 0) ? @"detail-cell" : @"basic-cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
    if(indexPath.section == 0){
        People *friend = [self.context.selectedPeople.people_friends allObjects][indexPath.row];
        cell.textLabel.text = friend.people_name;
        NSInteger commonCards = [self numberOfCommonCardOfPeople:self.context.selectedPeople andPeople:friend];
        if(commonCards > 0){
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld common cards", (long)commonCards];
        }else{
            cell.detailTextLabel.text = @"";
        }
    }else if(indexPath.section == 1){
        cell.textLabel.text = [self.context.selectedPeople.people_job allObjects][indexPath.row].job_name;
    }else if(indexPath.section == 2){
        cell.textLabel.text = [self.context.selectedPeople.credit_card_own allObjects][indexPath.row].credit_card_name;
    }
    return cell;
}

@end
