//
//  OMDBClient.m
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 5/9/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import "OMDBClient.h"
#import "UIMovieCollectionViewCollectionViewController.h"

@interface OMDBClient ()

@end

@implementation OMDBClient

+ (void)getRepositoriesWithKeyword: (NSString *)keyword
                        completion:(void (^)(NSArray * response))getMethCompletion
{
    NSString *OMDBString = [NSString stringWithFormat: @"http://www.omdbapi.com/?s=%@&page=1", keyword];
    NSLog(@"OMBD GET method URL: %@", OMDBString);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:OMDBString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSLog(@"Successful in fetching GET request.");
        NSMutableArray *movies = [[NSMutableArray alloc]init];
        
        NSArray *movieDictionaries = responseObject[@"Search"];
        //NSLog(@"MOVIE REPOS!\n%@", movieDictionaries);
        
        for (NSDictionary *movieObject in movieDictionaries)
        {
            NSLog(@"inside For loop!");
            movieObjects *movieObjectMeat = [[movieObjects alloc]initWithTitle:movieObject[@"Title"]
                                                                          Year:movieObject[@"Year"]
                                                                        imDBID:movieObject[@"imdbID"]
                                                                          Type:movieObject[@"Type"]
                                                                        Poster:movieObject[@"Poster"]];
            
            NSLog(@"\n\nMoViE rEpOs Dictionary array are:\n%@",movieObjectMeat);
            [movies addObject:movieObjectMeat];
        }
        NSLog(@"Result from ViewDidLoad movie query:%@", movies);
        getMethCompletion(movies);
        
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        NSLog(@"Error fetching GET request :( \nerror = %@", error.localizedDescription);
        //***incorporate error handling
    }];
}

@end
