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
                                                                  poster: movieObject[@"Poster"]
                                                                  imdbID: movieObject[@"imdbID"]];
             
             NSLog(@"\n\nWE HAVE A MOVIE HERE?????\n FISMOVIE:%@\n\n", movieObjectMeat);
             
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
        NSArray *movieArray = responseObject[@"Search"];
        
        for (NSDictionary *movieObject in movieArray)
        {
            NSLog(@"inside For loop!");
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
        //***incorporate error handling
    }];
}

+ (void)getMovieDetailWithMovieID: (NSString *)imdbID completion:(void (^)(NSDictionary *desiredDictionary))getMethCompletion
{
    NSString *OMBDString = [NSString stringWithFormat: @"http://www.omdbapi.com/?i=%@&plot=full&r=json", imdbID];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:OMBDString parameters: nil progress: nil success: ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSLog(@"\n\nSUCCESSSSSSS....in grabbing detail info on a selected movieObject!\n\n");
        NSMutableArray *completeMovieArray = [[NSMutableArray alloc]init];
        
        NSMutableDictionary *responseDictionary = [[NSMutableDictionary alloc]init];
        responseDictionary = [responseObject mutableCopy];
        
        NSArray *undesiredKeys = [[NSArray alloc]initWithObjects:@"imdbVotes", @"Writer", @"Response",@"totalSeasons", @"Year", @"Metascore", @"Language", @"Country", @"Awards", nil];
        
        [responseDictionary removeObjectsForKeys: undesiredKeys];
        NSLog(@"FINITO FOOLS!!\nundesiredKeys-->%@\ndetailArray-->%@\n", undesiredKeys, responseDictionary);
        
        NSDictionary *desiredDictionary = [[NSDictionary alloc] initWithDictionary: responseDictionary];

            NSLog(@"THE DETAILED THING-->%@",completeMovieArray);
            // }
        
        getMethCompletion(desiredDictionary);
    }
               failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
               {
                   NSLog(@"\n\nFAILURE IN CLIENT CLASS DURING 'GETMOVIEDETAIL' METHOD\n\n");
                   //***incoorporate some really real error handling ;)
               }];
}

+ (void) moreMoviesSaidTheUser: (NSString*)nextPageKeyword
{
    [FISOMDBClient getRepositoriesWithKeyword: nextPageKeyword completion:^(NSMutableArray *movies)
    {

    }];
}

@end
