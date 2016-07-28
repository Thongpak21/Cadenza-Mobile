//
//  Job+CoreDataProperties.h
//  PersonalTester
//
//  Created by Witawat Wanamonthon on 11/02/2016.
//  Copyright © 2016 Witawat Wanamonthon. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Job.h"

NS_ASSUME_NONNULL_BEGIN

@interface Job (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSString *job_name;
@property (nullable, nonatomic, retain) NSDecimalNumber *job_salary;
@property (nullable, nonatomic, retain) NSDate *job_start_date;
@property (nullable, nonatomic, retain) NSString *job_position;
@property (nullable, nonatomic, retain) NSSet<People *> *people;

@end

@interface Job (CoreDataGeneratedAccessors)

- (void)addPeopleObject:(People *)value;
- (void)removePeopleObject:(People *)value;
- (void)addPeople:(NSSet<People *> *)values;
- (void)removePeople:(NSSet<People *> *)values;

@end

NS_ASSUME_NONNULL_END
