//
//  People+CoreDataProperties.h
//  PersonalTester
//
//  Created by Witawat Wanamonthon on 11/02/2016.
//  Copyright © 2016 Witawat Wanamonthon. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "People.h"

NS_ASSUME_NONNULL_BEGIN

@interface People (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSString *people_name;
@property (nullable, nonatomic, retain) NSDate *people_birth_date;
@property (nullable, nonatomic, retain) NSNumber *people_height;
@property (nullable, nonatomic, retain) NSNumber *people_weight;
@property (nullable, nonatomic, retain) NSSet<Job *> *people_job;
@property (nullable, nonatomic, retain) NSSet<People *> *people_friends;
@property (nullable, nonatomic, retain) NSSet<CreditCard *> *credit_card_own;

@end

@interface People (CoreDataGeneratedAccessors)

- (void)addPeople_jobObject:(Job *)value;
- (void)removePeople_jobObject:(Job *)value;
- (void)addPeople_job:(NSSet<Job *> *)values;
- (void)removePeople_job:(NSSet<Job *> *)values;

- (void)addPeople_friendsObject:(People *)value;
- (void)removePeople_friendsObject:(People *)value;
- (void)addPeople_friends:(NSSet<People *> *)values;
- (void)removePeople_friends:(NSSet<People *> *)values;

- (void)addCredit_card_ownObject:(CreditCard *)value;
- (void)removeCredit_card_ownObject:(CreditCard *)value;
- (void)addCredit_card_own:(NSSet<CreditCard *> *)values;
- (void)removeCredit_card_own:(NSSet<CreditCard *> *)values;

@end

NS_ASSUME_NONNULL_END
