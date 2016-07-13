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
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *posterPic;

-(instancetype) initWithTitle:(NSString*)title
                         Year:(NSString *)year
                       imDBID:(NSString *)ID
                         Type:(NSString*)type
                       Poster:(NSString*)posterPic;

@end
