//
//  movieObjects.h
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 5/6/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface movieObjects : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *genre;
@property (nonatomic, strong) NSString *cast;
@property (nonatomic, strong) NSString *movieDscription;
@property (assign) NSDate *releaseDate;
@property (assign) int movieDuration; //NSNumber??

//-(instancetype) init;
-(instancetype) initWithTitle: (NSString*)title
                        genre: (NSString*)genre
                         cast: (NSString*)cast
             movieDescription: (NSString*)description
                  releaseDate: (NSDate*)releaseDate
                movieDuration: (int)duration;

@end
