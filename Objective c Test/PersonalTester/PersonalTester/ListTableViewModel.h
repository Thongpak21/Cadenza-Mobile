//
//  ListTableViewModel.h
//  PersonalTester
//
//  Created by Thongpak on 7/2/2559 BE.
//  Copyright © 2559 Witawat Wanamonthon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListTableViewModelDelegate.h"
#import "People.h"

@interface ListTableViewModel : NSObject

- (instancetype)initWithDelegate:(id<ListTableViewModelDelegate>)delegate;

- (void)refreshData;

- (NSInteger)numberOfPeoples;
- (People *)peopleForIndex:(NSInteger)index;

- (void)selectPeopleAtIndex:(NSInteger)index;

@end
