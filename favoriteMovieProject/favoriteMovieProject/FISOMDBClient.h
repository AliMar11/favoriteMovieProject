//
//  OMDBClient.h
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 5/9/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "MovieObjects+CoreDataProperties.h"
#import "FISmovie.h"

@interface FISOMDBClient : NSObject

@property (nonatomic, strong) NSMutableArray *movies;
@property (nonatomic, strong) NSMutableArray *movieObjectMeat;
@property (nonatomic, strong) NSString *OMDBString;

+ (void)getRepositoriesWithKeyword: (NSString *)keyword completion:(void (^)(NSMutableArray * movies))getMethCompletion;
+ (void)randomContentSearchWithCompletion:(void (^)(NSMutableArray * movies))getMethCompletion;

@end
