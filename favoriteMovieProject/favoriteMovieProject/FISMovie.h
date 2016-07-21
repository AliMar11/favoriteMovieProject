//
//  FISMovie.h
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 6/20/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISMovie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *poster;
@property (nonatomic, strong) NSString *imdbID;
@property (nonatomic, strong) NSString *imdbScore;
@property (nonatomic, strong) NSString *releaseDate;
@property (nonatomic, strong) NSString *filmRating;
@property (nonatomic, strong) NSString *runTime;
@property (nonatomic, strong) NSString *genre;
@property (nonatomic, strong) NSString *director;
@property (nonatomic, strong) NSString *actors;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *plot;

-(instancetype) initWithTitle: (NSString*) title
                       poster: (NSString*) poster
                       imdbID: (NSString*) imdbID;

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

@end
