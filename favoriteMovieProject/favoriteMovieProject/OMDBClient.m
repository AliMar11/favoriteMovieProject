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

+ (void)randomContentSearchWithCompletion:(void (^)(NSMutableArray * movies))getMethCompletion
{
    NSLog(@"inside 'randomContentSearch' method in OMBDClient");
    
    NSArray *initialContentRandomizer = @[@"star wars", @"matrix", @"indiana jones", @"alien", @"back to the future", @"charlie brown", @"mad max", @"lord of the rings", @"the never ending story", @"the warriors", @"studio ghibli", @"the nightmare before christmas", @"sin city", @"the wild wild west", @"scott pilgram",@"Mulan", @"the great gatsby", @"inception", @"pixar", @"pulp fiction", @"kick ass", @"batman", @"django", @"no country for old men", @"home alone", @"harry potter", @"kill bill",@"gone girl", @"hunger games", @"toy story", @"the lion king", @"over the garden wall"];
    
    NSUInteger arrayRandomizer = arc4random_uniform((u_int32_t)initialContentRandomizer.count);
    NSString *randomContent = [initialContentRandomizer objectAtIndex:arrayRandomizer];
    NSString *randomContentJSONizer = [randomContent stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSString *OMDBString = [NSString stringWithFormat: @"http://www.omdbapi.com/?s=%@&page=1", randomContentJSONizer];
    NSLog(@"OMBD 'randCustSearch' GET method URL: %@", OMDBString);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:OMDBString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"Successful in fetching GET request in 'randomContentSearch'.");
         NSMutableArray *movies = [[NSMutableArray alloc]init];
         
         NSArray *movieDictionaries = responseObject[@"Search"];
         //NSLog(@"MOVIE REPOS!\n%@", movieDictionaries);
         
         for (NSDictionary *movieObject in movieDictionaries)
         {
             //NSLog(@"inside 'randCustSearch' for loop!");
             movieObjects *movieObjectMeat = [[movieObjects alloc]initWithTitle:movieObject[@"Title"]
                                Year:movieObject[@"Year"]
                              imDBID:movieObject[@"imdbID"]
                                Type:movieObject[@"Type"]
                              Poster:movieObject[@"Poster"]];
             
            // NSLog(@"\n\n'randCustSearch' Dictionary array are:\n%@",movieObjectMeat);
             [movies addObject:movieObjectMeat];
         }
         NSLog(@"Result from ViewDidLoad movie query:\n%@", movies);
         getMethCompletion(movies); //when the meth is finished, the block with give the data to the class that called the method.
         
     }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"Error fetching GET request :( \nerror = %@", error.localizedDescription);
         //***incorporate error handling
     }];
    
}

+ (void)getRepositoriesWithKeyword: (NSString *)keyword completion:(void (^)(NSMutableArray * movies))getMethCompletion
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
           // UIMovieCollectionViewCollectionViewController *moviesCVObjects = movies;
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
