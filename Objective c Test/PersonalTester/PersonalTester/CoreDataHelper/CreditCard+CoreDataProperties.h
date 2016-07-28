//
//  CreditCard+CoreDataProperties.h
//  PersonalTester
//
//  Created by Witawat Wanamonthon on 11/02/2016.
//  Copyright © 2016 Witawat Wanamonthon. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CreditCard.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreditCard (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSDecimalNumber *credit_card_minimum_salary;
@property (nullable, nonatomic, retain) NSNumber *credit_card_minimum_work_experience;
@property (nullable, nonatomic, retain) NSString *credit_card_name;
@property (nullable, nonatomic, retain) NSSet<People *> *people_own;

@end

@interface CreditCard (CoreDataGeneratedAccessors)

- (void)addPeople_ownObject:(People *)value;
- (void)removePeople_ownObject:(People *)value;
- (void)addPeople_own:(NSSet<People *> *)values;
- (void)removePeople_own:(NSSet<People *> *)values;

@end

NS_ASSUME_NONNULL_END
