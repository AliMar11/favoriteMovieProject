//
//  movieObjects.m
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 5/6/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import "movieObjects.h"

@implementation movieObjects

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
