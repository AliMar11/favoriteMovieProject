//
//  OMDBClient.m
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 5/9/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//
#import "FISOMDBClient.h"

@interface FISOMDBClient ()
@end

@implementation FISOMDBClient
+ (void)randomContentSearchWithCompletion:(void (^)(NSMutableArray * movies))getMethCompletion
{
    NSLog(@"inside 'randomContentSearch' method in OMBDClient");
    
    NSArray *initialContentRandomizer = @[@"star wars", @"matrix", @"indiana jones", @"Goosebumps", @"back to the future", @"charlie brown", @"mad max", @"lord of the rings", @"animaniacs", @"the warriors", @"the nightmare before christmas", @"sin city", @"the wild wild west", @"Mulan", @"the great gatsby", @"inception", @"pulp fiction", @"kick ass", @"batman", @"django", @"no country for old men", @"home alone", @"harry potter", @"kill bill",@"gone girl", @"hunger games", @"toy story", @"the lion king", @"over the garden wall", @"turbo kid"];
    
    NSUInteger arrayRandomizer = arc4random_uniform((u_int32_t)initialContentRandomizer.count);
    NSString *randomContent = [initialContentRandomizer objectAtIndex: arrayRandomizer];
    NSString *randomContentJSONizer = [randomContent stringByReplacingOccurrencesOfString: @" " withString: @"+"];
    
    NSString *OMDBString = [NSString stringWithFormat: @"http://www.omdbapi.com/?s=%@&page=1", randomContentJSONizer];
    NSLog(@"OMBD 'randCustSearch' GET method URL: %@", OMDBString);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET: OMDBString parameters: nil progress: nil success:
     ^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject)
     {
         NSLog(@"Successful in fetching GET request in 'randomContentSearch'.");
         NSMutableArray *movies = [[NSMutableArray alloc]init];
         NSArray *movieDictionaries = responseObject[@"Search"];
         
         for (NSDictionary *movieObject in movieDictionaries)
         {
             FISMovie *movieObjectMeat = [[FISMovie alloc] initWithTitle: movieObject[@"Title"]
                                Year: movieObject[@"Year"]
                              imDBID: movieObject[@"imdbID"]
                                Type: movieObject[@"Type"]
                              Poster: movieObject[@"Poster"]];
             
             [movies addObject: movieObjectMeat];
         }
         
         getMethCompletion(movies);
         //when the meth is finished, the block with give the data to the class that called the method.
     }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     
        {
         NSLog(@"Error fetching GET request :( \nerror = %@", error.localizedDescription);
         //***incorporate error handling
        }];
}

+ (void)getRepositoriesWithKeyword: (NSString *)keyword completion: (void (^)(NSMutableArray * movies))getMethCompletion
{
    NSString *OMDBString = [NSString stringWithFormat: @"http://www.omdbapi.com/?s=%@&page=1", keyword];
    NSLog(@"OMBD GET method URL: %@", OMDBString);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET: OMDBString parameters: nil progress: nil success: ^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject)
    {
        NSLog(@"Successful in fetching GET request.");
        NSMutableArray *movies = [[NSMutableArray alloc]init];
        
        NSArray *movieDictionaries = responseObject[@"Search"];
        //NSLog(@"MOVIE REPOS!\n%@", movieDictionaries);
        
        for (NSDictionary *movieObject in movieDictionaries)
        {
            NSLog(@"inside For loop!");
            FISMovie *movieObjectMeat = [[FISMovie alloc]initWithTitle: movieObject[@"Title"]
                                                                          Year: movieObject[@"Year"]
                                                                        imDBID: movieObject[@"imdbID"]
                                                                          Type: movieObject[@"Type"]
                                                                        Poster: movieObject[@"Poster"]];
            
            [movies addObject: movieObjectMeat];
        }
        
        getMethCompletion(movies);
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        NSLog(@"Error fetching GET request :( \nerror = %@", error.localizedDescription);
        //***incorporate error handling
    }];
}

+ (void) moreMoviesSaidTheUser: (NSString*)nextPageKeyword
{
    [FISOMDBClient getRepositoriesWithKeyword: nextPageKeyword completion:^(NSMutableArray *movies)
    {

    }];
}

@end
