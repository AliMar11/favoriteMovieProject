//
//  DetailMovieObject+CoreDataProperties.h
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 7/19/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DetailMovieObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailMovieObject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *actors;
@property (nullable, nonatomic, retain) NSString *director;
@property (nullable, nonatomic, retain) NSString *filmRating;
@property (nullable, nonatomic, retain) NSString *genre;
@property (nullable, nonatomic, retain) NSString *imdbScore;
@property (nullable, nonatomic, retain) NSString *plot;
@property (nullable, nonatomic, retain) NSString *poster;
@property (nullable, nonatomic, retain) NSString *releaseDate;
@property (nullable, nonatomic, retain) NSString *runTime;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *type;

@end

NS_ASSUME_NONNULL_END
