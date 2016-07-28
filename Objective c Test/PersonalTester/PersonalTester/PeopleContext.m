//
//  PeopleContext.m
//  PersonalTester
//
//  Created by Thongpak on 7/2/2559 BE.
//  Copyright © 2559 Witawat Wanamonthon. All rights reserved.
//

#import "PeopleContext.h"

static id shared;

@implementation PeopleContext

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!shared){
            shared = [[self alloc] init];
        }
    });
    return shared;
}

@end
