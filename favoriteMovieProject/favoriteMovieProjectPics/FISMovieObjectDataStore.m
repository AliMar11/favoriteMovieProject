//
//  MovieObjectsDataStore.m
//  favoriteMovieProject
//
//  Created by Flatiron School on 6/14/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import "FISMovieObjectDataStore.h"

@interface FISMovieObjectDataStore ()
@end

@implementation FISMovieObjectDataStore
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+(FISMovieObjectDataStore *)sharedDataStore
{
    static FISMovieObjectDataStore *_aMovieInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        _aMovieInstance = [[FISMovieObjectDataStore alloc] init];
    });
    
    return _aMovieInstance;
}

#pragma mark - Core Data stack

- (NSURL *)applicationDocumentsDirectory
{
    // The directory the application uses to store the Core Data store file. This code uses a directory named "aliApps.favoriteMovieProject" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory: NSDocumentDirectory inDomains: NSUserDomainMask] lastObject];
}

- (NSManagedObjectContext *)managedObjectContext
{
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    
    if (_managedObjectContext != nil)
    {
        //self.managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;

        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator)
    {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType: NSMainQueueConcurrencyType];
    
   // self.managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
    
    [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    
    self.managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
    
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }

    NSURL *modelURL = [[NSBundle mainBundle] URLForResource: @"FavoriteMovieProject" withExtension: @"momd"];
    
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL: modelURL];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    // Create the coordinator and store
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent: @"FavoriteMovieProject.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType: NSSQLiteStoreType configuration: nil URL: storeURL options: nil error: &error])
    {        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain: @"YOUR_ERROR_DOMAIN" code: 9999 userInfo: dict];
        
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

-(void)saveContext
{
    
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;

    if (managedObjectContext != nil)
    {
        NSError *error = nil;
     //   NSError *mergeError = NSErrorMergePolicy;
        BOOL success = [managedObjectContext save:&error];
        if (!success)
        {
            NSLog(@"We have a real saving error if 'success' = NO;");
        }
        if ([managedObjectContext hasChanges] && ![managedObjectContext save: &error])
        {
            NSLog(@"MANAGED OBJ HAS CHANGE OR NOT SAVE &error");
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
           // self.managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
           // abort();
        }

    }
}

-(void)fetchData
{
    NSFetchRequest *favoriteMoviesArray = [NSFetchRequest fetchRequestWithEntityName: @"MovieObject"];
    self.movies = [self.managedObjectContext executeFetchRequest: favoriteMoviesArray error: nil];
}

-(void)deleteAllContext
{
    NSFetchRequest * deleteFetchRequest = [[NSFetchRequest alloc] initWithEntityName: @"MovieObject"];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest: deleteFetchRequest];
    
    NSError *deleteError = nil;
    [self.persistentStoreCoordinator executeRequest: delete
                                        withContext: self.managedObjectContext
                                              error: &deleteError];
    [self fetchData];
}

-(void)deleteOneMovieInstance:(DetailMovieObject*)movieObject
{
    [self.managedObjectContext deleteObject: movieObject];
    NSError *error;
    if (![self.managedObjectContext save: &error])
    {
        // Incorporate real error handling.
        NSLog(@"Could not delete a movieObject - error at managedObject level");
    }
    
    [self saveContext];
    [self fetchData];
}

@end
