//
//  movieObjects.m
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 5/6/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import "movieObjects.h"

@implementation movieObjects

//-(instancetype) init{
//    
//    
//    return self;
//}

-(instancetype) initWithTitle: (NSString*)title
                        genre: (NSString*)genre
                         cast: (NSString*)cast
             movieDescription: (NSString*)description
                  releaseDate: (NSDate*)releaseDate
                movieDuration: (int)duration
{
    
    self = [super init];
    
    if (self)
    {
        _title = title;
        _genre = genre;
        _cast = cast;
        _movieDscription = description;
        _releaseDate = releaseDate;
        _movieDuration = duration;
    }
    
    return self;
}

@end
