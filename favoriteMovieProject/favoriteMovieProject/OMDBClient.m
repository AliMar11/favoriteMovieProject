//
//  OMDBClient.m
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 5/9/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import "OMDBClient.h"

@implementation OMDBClient

+ (void)getRepositoriesWithKeyword: (NSString *)keyword
                        completion:(void (^)(NSArray * response))getMethCompletion
{
    
    NSString *OMDBString = [NSString stringWithFormat: @"http://www.omdbapi.com/?s=star+wars&page=1"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    
//    if ([UIMovieCollectionViewCollectionViewController searchBar.textlabel.text != nil]) {
//        
//        OMDBString = [NSString stringWithFormat:@"http://www.omdbapi.com/?s=%@",[UIMovieCollectionViewCollectionViewController searchBar.text];
//                      
    
    [manager GET:OMDBString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSLog(@"Successful in fetching GET request.");
        NSMutableArray *movies = [[NSMutableArray alloc]init];
        
        NSArray *movieDictionaries = responseObject[@"Search"];
        //NSLog(@"MOVIE REPOS!%@", movieDictionaries);
        
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
     
        getMethCompletion(movies);
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        NSLog(@"Error fetching GET request :( \nerror = %@", error.localizedDescription);
        
        
    }];
}

@end
