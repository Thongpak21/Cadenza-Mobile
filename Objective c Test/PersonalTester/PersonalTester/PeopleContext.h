//
//  PeopleContext.h
//  PersonalTester
//
//  Created by Thongpak on 7/2/2559 BE.
//  Copyright © 2559 Witawat Wanamonthon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "People.h"

@interface PeopleContext : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) People *selectedPeople;

@end
