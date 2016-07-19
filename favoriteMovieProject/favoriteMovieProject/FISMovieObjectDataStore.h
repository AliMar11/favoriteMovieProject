//
//  FISMovieObjectDataStore.h
//  favoriteMovieProject
//
//  Created by Flatiron School on 6/14/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailMovieObject.h"
#import "FISDetailViewController.h"

@interface FISMovieObjectDataStore : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) NSArray *movies;

+(instancetype) sharedDataStore;
- (NSURL *)applicationDocumentsDirectory;
-(void)saveContext;
-(void)fetchData;
-(void)deleteAllContext;


@end
