//
//  FISCollectionViewController.h
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 5/2/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FISOMDBClient.h"
#import "FISMovieObjectDataStore.h"

@interface FISCollectionViewController : UICollectionViewController <UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *collectionViewTreats;
@property (weak, nonatomic) IBOutlet UIImageView *collectionImageView;
@property (nonatomic, strong) NSMutableArray *movieRepos;
@property (nonatomic, strong) NSMutableArray *movieCVArray;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *movies;

- (void)searchButtonTapped;
- (IBAction)moreMoviesButtonTapped:(id)sender;


@end
