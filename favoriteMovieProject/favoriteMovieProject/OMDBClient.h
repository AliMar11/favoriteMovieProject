//
//  OMDBClient.h
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 5/9/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "movieObjects.h"
#import "UIMovieCollectionViewCollectionViewController.h"

@interface OMDBClient : NSObject

+ (void)getRepositoriesWithKeyword: (NSString *)keyword completion:(void (^)(NSArray * response))getMethCompletion;

@end
