//
//  FISMovie.m
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 6/20/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import "FISMovie.h"

@implementation FISMovie : NSObject

-(instancetype) initWithTitle:(NSString *)title
                         Year:(NSString *)year
                       imDBID:(NSString *)ID
                         Type:(NSString *)type
                       Poster:(NSString *)posterPic
{
    self = [super init];
    
    if (self)
    {
        _title = title;
        _year = year;
        _ID = ID;
        _type = type;
        _posterPic = posterPic;
    }
    return self;
}

@end
