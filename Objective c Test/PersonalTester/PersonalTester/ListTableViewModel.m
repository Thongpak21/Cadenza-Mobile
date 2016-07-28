//
//  ListTableViewModel.m
//  PersonalTester
//
//  Created by Thongpak on 7/2/2559 BE.
//  Copyright © 2559 Witawat Wanamonthon. All rights reserved.
//

#import "ListTableViewModel.h"
#import "AppDelegate.h"
#import "PeopleContext.h"

@interface ListTableViewModel ()

@property (nonatomic, weak) id<ListTableViewModelDelegate> delegate;
@property (nonatomic, strong) NSArray<People *> *peoples;
@property (nonatomic, strong) PeopleContext *context;

@end

@implementation ListTableViewModel

- (instancetype)initWithDelegate:(id<ListTableViewModelDelegate>)delegate {
    self = [self init];
    if(self){
        self.delegate = delegate;
        self.context = [PeopleContext sharedInstance];
    }
    return self;
}

- (void)refreshData {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"People"];
    
    NSError *error;
    NSArray<People *> *peoples = [appDelegate.managedObjectContext executeFetchRequest:request error:&error];
    if(error){
        [self.delegate onDataDidLoadWithError:error];
        return;
    }
    self.peoples = peoples;
}

- (NSInteger)numberOfPeoples {
    return self.peoples.count;
}

- (People *)peopleForIndex:(NSInteger)index {
    return self.peoples[index];
}

- (void)selectPeopleAtIndex:(NSInteger)index {
    self.context.selectedPeople = [self peopleForIndex:index];
    [self.delegate showViewForPeople:self.context.selectedPeople];
}

@end
