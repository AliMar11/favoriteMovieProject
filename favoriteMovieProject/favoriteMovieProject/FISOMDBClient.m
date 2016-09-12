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

+(void)randomContentSearchWithCompletion: (void (^)(NSMutableArray * movies))getMethCompletion
{
    NSArray *initialContentRandomizer = @[@"star wars", @"matrix", @"indiana jones", @"Goosebumps", @"back to the future", @"charlie brown", @"mad max", @"lord of the rings", @"the warriors", @"sin city", @"the wild wild west", @"Mulan", @"the great gatsby", @"inception", @"pulp fiction", @"kick ass", @"batman", @"django", @"home alone", @"harry potter", @"kill bill",@"gone girl", @"hunger games", @"toy story", @"the lion king", @"turbo kid"];
    
    NSUInteger arrayRandomizer = arc4random_uniform((u_int32_t)initialContentRandomizer.count);
    NSString *randomContent = [initialContentRandomizer objectAtIndex: arrayRandomizer];
    NSString *randomContentJSONizer = [randomContent stringByReplacingOccurrencesOfString: @" " withString: @"+"];
    
    NSString *OMDBString = [NSString stringWithFormat: @"http://www.omdbapi.com/?s=%@&page=1", randomContentJSONizer];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET: OMDBString parameters: nil progress: nil success:
     ^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject)
     {
         NSMutableArray *movies = [[NSMutableArray alloc]init];
         NSArray *movieDictionaries = responseObject[@"Search"];
         
         for (NSDictionary *movieObject in movieDictionaries)
         {
             FISMovie *movieObjectMeat = [[FISMovie alloc] initWithTitle: movieObject[@"Title"]
                                                                  poster: movieObject[@"Poster"]
                                                                  imdbID: movieObject[@"imdbID"]];
             
             [movies addObject: movieObjectMeat];
         }
         
         getMethCompletion(movies);
         //when the meth is finished, the block with give the data to the class that called the method.
      }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     
        {
         NSLog(@"Error fetching GET request :( \nerror = %@", error.localizedDescription);
         //***incorporate real error handling
        }];
}

+(void)getRepositoriesWithKeyword: (NSString *)keyword completion: (void (^)(NSMutableArray * movies))getMethCompletion
{
    NSString *OMDBString = [NSString stringWithFormat: @"http://www.omdbapi.com/?s=%@&page=1", keyword];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET: OMDBString parameters: nil progress: nil success: ^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject)
    {
        NSMutableArray *movies = [[NSMutableArray alloc]init];
        NSArray *movieArray = responseObject[@"Search"];
        
        for (NSDictionary *movieObject in movieArray)
        {
            FISMovie *movieObjectMeat = [[FISMovie alloc] initWithTitle: movieObject[@"Title"]
                                                                 poster: movieObject[@"Poster"]
                                                                 imdbID: movieObject[@"imdbID"]];
            [movies addObject: movieObjectMeat];
        }
        
        getMethCompletion(movies);
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        NSLog(@"Error fetching GET request :( \nerror = %@", error.localizedDescription);
        //***incorporate real error handling
    }];
}

+(void)getMovieDetailWithMovieID: (NSString *)imdbID completion:(void (^)(NSDictionary *desiredDictionary))getMethCompletion
{
    NSString *OMBDString = [NSString stringWithFormat: @"http://www.omdbapi.com/?i=%@&plot=full&r=json", imdbID];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET: OMBDString parameters: nil progress: nil success: ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSMutableDictionary *responseDictionary = [[NSMutableDictionary alloc]initWithDictionary: [responseObject mutableCopy]];
        
        NSArray *undesiredKeys = [[NSArray alloc]initWithObjects: @"imdbVotes", @"Writer", @"Response", @"totalSeasons", @"Year", @"Metascore", @"Language", @"Country", @"Awards", nil];
        
        [responseDictionary removeObjectsForKeys: undesiredKeys];
        NSDictionary *desiredDictionary = [[NSDictionary alloc] initWithDictionary: responseDictionary];

        getMethCompletion(desiredDictionary);
    }
               failure: ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
               {
                   NSLog(@"\n\nFAILURE IN CLIENT CLASS DURING 'GETMOVIEDETAIL' METHOD\n\n");
                   //***incoorporate real error handling ;)
               }];
}

+(void) moreMoviesSaidTheUser: (NSString*)nextPageKeyword
{
    [FISOMDBClient getRepositoriesWithKeyword: nextPageKeyword completion: ^(NSMutableArray *movies)
    {

    }];
}

@end
