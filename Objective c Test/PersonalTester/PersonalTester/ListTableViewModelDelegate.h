//
//  ListTableViewModelDelegate.h
//  PersonalTester
//
//  Created by Thongpak on 7/2/2559 BE.
//  Copyright © 2559 Witawat Wanamonthon. All rights reserved.
//

#import "People.h"

@protocol ListTableViewModelDelegate <NSObject>

- (void)onDataDidLoad;
- (void)onDataDidLoadWithError:(NSError *)error;

- (void)showViewForPeople:(People *)people;

@end