//
//  MovieObjects+CoreDataProperties.h
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 7/7/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MovieObjects.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieObjects (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *imdbID;
@property (nullable, nonatomic, retain) NSString *posterPic;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *year;

@end

NS_ASSUME_NONNULL_END
