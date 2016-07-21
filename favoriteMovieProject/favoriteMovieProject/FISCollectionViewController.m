//
//  FISCollectionViewController.m
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 5/2/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import "FISCollectionViewController.h"
#import "FISDetailViewController.h"
#import "FISMovie.h"


@interface FISCollectionViewController ()

@property (nonatomic, strong) NSString *keyword;
@property (assign) int buttonClickCounter;
@property (nonatomic, strong) UIStoryboardSegue *detailCellSegue;

@end

@implementation FISCollectionViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [FISOMDBClient randomContentSearchWithCompletion: ^(NSMutableArray *movies)
     {
         self.movieCVArray = movies;
        //NSLog(@"MOVIECVARRAY: %@", self.movieCVArray);
         
         [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
               [self.collectionView reloadData];
         }];
     }];
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.placeholder = @"Find movies, TV shows and more...";
    self.searchBar.tintColor = [UIColor blueColor];
    self.searchBar.barTintColor = [UIColor lightGrayColor];
    self.searchBar.showsSearchResultsButton = YES;
    self.searchBar.searchResultsButtonSelected = YES;
    
    //search button time!!
    UIBarButtonItem *searchButton= [[UIBarButtonItem alloc] initWithTitle:@"Search!"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(searchButtonTapped)];
    self.navigationItem.rightBarButtonItem = searchButton;
    
    UIView *backgroundViewForCollectionView=[[UIView alloc]init];
    [backgroundViewForCollectionView setBackgroundColor:[UIColor colorWithPatternImage:
                                                         [UIImage imageNamed:@"colorTriangles"]]];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect: blurEffect];
    blurEffectView.frame = self.view.bounds;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [backgroundViewForCollectionView addSubview: blurEffectView];
    [self.collectionView setBackgroundView: backgroundViewForCollectionView];
    //***set constraints for backroundVC For CollectionVC image
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    //***get more info on how this works
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier: @"awesomeCell"];
}

-(void)searchButtonTapped
{
    NSLog(@"THE SEARCH BUTTON WAS TAPPED");
    
    [self.movieCVArray removeAllObjects];
    self.keyword = [self.searchBar.text stringByReplacingOccurrencesOfString: @" " withString: @"+"];
    
    [FISOMDBClient getRepositoriesWithKeyword:self.keyword completion: ^(NSMutableArray *movies)
     {
         NSLog(@"SEARCH RESPOSE:\n%@", movies);
         NSLog(@"the keyword used with 'search' button tap:%@", self.keyword);
         self.movieCVArray = movies;
         
         [[NSOperationQueue mainQueue] addOperationWithBlock:
         ^{
             [self.collectionView reloadData];
         }];
     }];
}

- (IBAction)moreMoviesButtonTapped:(id)sender
{
   NSString *titleForSearch = [[self.movieCVArray[1] valueForKey: @"title"] stringByReplacingOccurrencesOfString: @" " withString:@"+"];
    NSLog(@"\n\nMOVIEARRAY:%@\n\n", titleForSearch);

    self.buttonClickCounter ++;
    
    if (self.buttonClickCounter == 1)
    {
        self.buttonClickCounter = 2;
    }
    
    NSString *nextPage = [NSString stringWithFormat: @"http://www.omdbapi.com/?s=%@&page=%d", titleForSearch, self.buttonClickCounter];

    [FISOMDBClient getRepositoriesWithKeyword: self.keyword
                                completion:^(NSMutableArray *movies)
    {
        NSLog(@"\n\nSUCCESSFUL PAGE 2??:\n%@\n\n", nextPage);
        [self.movieCVArray addObjectsFromArray: movies];
    }];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^
    {
        [self.collectionView reloadData];
    }];
}

////// ITEM SIZE of items inside collection view
- (CGSize)collectionView: (UICollectionView *)collectionView
                  layout: (UICollectionView*)collectionViewLayout
  sizeForItemAtIndexPath: (NSIndexPath *)indexPath
{
    CGFloat cellLeg = (self.collectionView.frame.size.width/2.5) -2;
    return CGSizeMake(cellLeg, cellLeg*1.5);
}

//// COLLECTION VIEW EDGE INSETS(spacing all around each view in collection)
- (UIEdgeInsets)collectionView: (UICollectionView *)collectionView
                        layout: (UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex: (NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//// COLLECTION VIEW MINIMUM LINE SPACING (Horizontal spacing betweet top and bottom)
- (CGFloat)collectionView: (UICollectionView *)collectionView
                   layout: (UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex: (NSInteger)section
{
    return 15;
}

// COLLECTION VIEW MINIMUM INTERITEM SPACING (between views within collection)
- (CGFloat)collectionView: (UICollectionView *)collectionView
                   layout: (UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex: (NSInteger)section
{
    return 5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.movieCVArray.count;
}

- (UICollectionViewCell *)collectionView: (UICollectionView *)collectionView cellForItemAtIndexPath: (NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"awesomeCell"
                                  forIndexPath: indexPath];
 
    UIImageView *movieImageView = [[UIImageView alloc]init];
    NSDictionary *aMovieCVDictionary= self.movieCVArray[indexPath.row];
    NSURL *movieCVPosterURL = [[NSURL alloc] initWithString: [aMovieCVDictionary valueForKey: @"_poster"]];
    NSData *movieCVData = [[NSData alloc] initWithContentsOfURL: movieCVPosterURL];
    UIImage *movieCVPosterImage = [[UIImage alloc] initWithData: movieCVData];
    movieImageView.image = movieCVPosterImage;
    
    if (!movieImageView.image)
    {
       movieImageView.image = [UIImage imageNamed: @"missingMilk"];
    }
    
    [cell.contentView addSubview: movieImageView];
 
    movieImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [movieImageView.heightAnchor constraintEqualToAnchor: cell.contentView.heightAnchor].active = YES;
    [movieImageView.widthAnchor constraintEqualToAnchor: cell.contentView.widthAnchor].active = YES;
    [movieImageView.centerXAnchor constraintEqualToAnchor: cell.contentView.centerXAnchor].active =YES;
    [movieImageView.centerYAnchor constraintEqualToAnchor: cell.contentView.centerYAnchor].active =YES;
    [movieImageView setContentMode: UIViewContentModeScaleAspectFill];
    movieImageView.clipsToBounds = YES;
    
    return cell;
}

-(UICollectionReusableView *)collectionView: (UICollectionView *)collectionView
          viewForSupplementaryElementOfKind: (NSString *)kind
                                atIndexPath: (NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionFooter)
    {
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                               withReuseIdentifier: @"footerView"
                                      forIndexPath: indexPath];
        reusableView = footerView;
    }
    
    return reusableView;
}

- (void)collectionView: (UICollectionView *)collectionView didSelectItemAtIndexPath: (NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier: @"selectedCellSegue" sender: self];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender: (id)sender
{
    FISDetailViewController *movieDataTrain = segue.destinationViewController;
    NSIndexPath *indexSelected = self.collectionView.indexPathsForSelectedItems.firstObject;
    FISMovie *movieObjectToBePassed = self.movieCVArray[indexSelected.row];
    
    movieDataTrain.seguedMovie = movieObjectToBePassed;
    
}
#pragma \mark <UICollectionViewDelegate>
/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

 // Uncomment this method to specify if the specified item should be selected
/*
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
 return YES;
}
*/

@end
