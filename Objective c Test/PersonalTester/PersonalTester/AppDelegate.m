//
//  AppDelegate.m
//  PersonalTester
//
//  Created by Witawat Wanamonthon on 11/02/2016.
//  Copyright © 2016 Witawat Wanamonthon. All rights reserved.
//

#import "AppDelegate.h"
#import "PrefixHeader.pch"
#import <CommonCrypto/CommonDigest.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CreditCard"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    [fetchRequest setReturnsObjectsAsFaults:false];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects.count > 0) {
        for (CreditCard*card in fetchedObjects){
//            NSLog(@"card --> %@",card);
        }
//        NSLog(@"credit card count = %lu",(unsigned long)fetchedObjects.count);
    }
    
    NSFetchRequest *fetchRequest1 = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Job"
                                              inManagedObjectContext:context];
    [fetchRequest1 setEntity:entity1];
    [fetchRequest1 setReturnsObjectsAsFaults:false];
    NSArray *fetchedObjects1 = [context executeFetchRequest:fetchRequest1 error:&error];
    if (fetchedObjects1.count > 0) {
        for (Job*card in fetchedObjects1){
//            NSLog(@"job --> %@",card);
        }
//        NSLog(@"Job count = %lu",(unsigned long)fetchedObjects1.count);
    }
    
    NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"People"
                                              inManagedObjectContext:context];
    [fetchRequest2 setEntity:entity2];
    [fetchRequest2 setReturnsObjectsAsFaults:false];
    NSArray *fetchedObjects2 = [context executeFetchRequest:fetchRequest2 error:&error];
    if (fetchedObjects2.count > 0) {
        for (People*card in fetchedObjects2){
            NSLog(@"peopl --> %@",card);
            for (CreditCard*cards in card.credit_card_own){
//                NSLog(@"own card --> %@",cards);
            }
        }
//        NSLog(@"People count = %lu",(unsigned long)fetchedObjects2.count);
    }
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "tosz.PersonalTester" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"PersonalTester" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"PersonalTester.sqlite"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:[storeURL path]]) {
        NSError* err = nil;
        NSLog(@"pre load");
        NSArray *urlArray = @[[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"PersonalTester" ofType:@"sqlite"]],[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"PersonalTester" ofType:@"sqlite-wal"]],[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"PersonalTester" ofType:@"sqlite-shm"]]];
        
        
        for (NSURL *url in urlArray){
            if (![[NSFileManager defaultManager] copyItemAtURL:url toURL:storeURL error:&err]) {
                NSLog(@"Oops, could copy preloaded data");
            }
        }
        
    }
    
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Generate ID

- (NSString*) generateSalt{
    int salt = (arc4random() % 100000)+1;
    return [NSString stringWithFormat:@"%d",salt];
}

- (NSString*) generateMD5String:(NSString*) message {
    
    return [self md5:message];
}

- (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}

- (long long) timestamp {
    NSTimeInterval timeInMiliseconds = [[NSDate date] timeIntervalSince1970];
    double timeStamp = timeInMiliseconds*1000;
    long long timeStampLongValue = timeStamp;
    return timeStampLongValue;
}

@end
