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
        self = [self initWithPoster: poster
                       title: title
                      imdbID: imdbID
                 releaseDate: self.releaseDate
                  filmRating: self.filmRating
                   imdbScore: self.imdbScore
                     runTime: self.runTime
                       genre: self.genre
                    director: self.director
                      actors: self.actors
                        type: self.type
                        plot: self.plot];
        
//        _title = title;
//        _poster = poster;
//        _imdbID = imdbID;
        
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



@end
