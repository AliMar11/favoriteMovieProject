//
//  FISMovie.m
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 6/20/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import "FISMovie.h"

@implementation FISMovie : NSObject

-(instancetype) initWithTitle:(NSString*) title
                       poster:(NSString*) poster
                       imdbID:(NSString*) imdbID
{
    self = [super init];
    
    if (self)
    {
    _poster = poster;
    _title = title;
    _imdbID = imdbID;
        
    }
    return self;
}

-(instancetype) initWithPoster: (NSString *) poster
                         title: (NSString *) title
                        imdbID: (NSString *) imdbID
                   releaseDate: (NSString *) releaseDate
                    filmRating: (NSString *) filmRating
                     imdbScore: (NSString *) imdbScore
                       runTime: (NSString *) runTime
                         genre: (NSString *) genre
                      director: (NSString *) director
                        actors: (NSString *) actors
                          type: (NSString *) type
                          plot: (NSString *) plot;
{
    self = [super init];
    
    if (self)
    {
        _poster = poster;
        _imdbID = imdbID;
        _title = title;
        _releaseDate = releaseDate;
        _filmRating = filmRating;
        _imdbScore = imdbScore;
        _releaseDate = releaseDate;
        _runTime = runTime;
        _genre = genre;
        _director = director;
        _actors = actors;
        _type = type;
        _plot = plot;
    }
    return self;
}

+(void)updateMovieWithDictionary: (FISMovie*)movie :(NSDictionary *)desiredDictionary
{
    NSLog(@"updating the movieObject with detail data");
    movie.releaseDate = [desiredDictionary valueForKey: @"Released"];
    movie.actors = [desiredDictionary valueForKey: @"Actors"];
    movie.director = [desiredDictionary valueForKey: @"Director"];
    movie.genre = [desiredDictionary valueForKey: @"Genre"];
    movie.plot = [desiredDictionary valueForKey: @"Plot"];
    movie.filmRating = [desiredDictionary valueForKey: @"Rated"];
    movie.type = [desiredDictionary valueForKey: @"Type"];
    movie.imdbScore = [desiredDictionary valueForKey: @"imdbRating"];
    movie.imdbID = [desiredDictionary valueForKey: @"imdbID"];
    movie.runTime = [desiredDictionary valueForKey: @"Runtime"];
    
}


@end
