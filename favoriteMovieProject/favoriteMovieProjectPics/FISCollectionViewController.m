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
@property (nonatomic, strong) FISMovieObjectDataStore *sharedDatastore;

@end

@implementation FISCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.sharedDatastore = [FISMovieObjectDataStore sharedDataStore];
    
    [FISOMDBClient randomContentSearchWithCompletion: ^(NSMutableArray *movies)
     {
         self.movieCVArray = movies;
         [[NSOperationQueue mainQueue] addOperationWithBlock:^
          {
              [self.collectionView reloadData];
          }];
     }];
    
    [self createSearchBar];
    [self createBlurView];
    
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier: @"awesomeCell"];
}

-(void)searchButtonTapped
{
    [self.movieCVArray removeAllObjects];
    self.keyword = [self.searchBar.text stringByReplacingOccurrencesOfString: @" " withString: @"+"];
    
    [FISOMDBClient getRepositoriesWithKeyword:self.keyword completion: ^(NSMutableArray *movies)
     {
         self.movieCVArray = movies;
         
         [[NSOperationQueue mainQueue] addOperationWithBlock:
          ^{
              [self.collectionView reloadData];
          }];
     }];
}

- (IBAction)moreMoviesButtonTapped:(id)sender
{
    self.buttonClickCounter ++;
    
    if (self.buttonClickCounter == 1)
    {
        self.buttonClickCounter = 2;
    }
    
    [FISOMDBClient getRepositoriesWithKeyword: self.keyword completion: ^(NSMutableArray *movies)
     {
         [self.movieCVArray addObjectsFromArray: movies];
     }];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^
     {
         [self.collectionView reloadData];
     }];
}

#pragma mark <VC visualSetup>
-(void)createSearchBar
{
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.placeholder = @"Find movies, TV shows and more...";
    self.searchBar.tintColor = [UIColor blueColor];
    self.searchBar.barTintColor = [UIColor lightGrayColor];
    self.searchBar.searchResultsButtonSelected = YES;
   
    UIBarButtonItem *searchButton= [[UIBarButtonItem alloc] initWithTitle: nil
                                                                    style: UIBarButtonItemStylePlain
                                                                   target: self
                                                                   action: @selector(searchButtonTapped)];
    
    searchButton.image = [UIImage imageNamed: @"Rectangle Stroked-32"];
    self.navigationItem.rightBarButtonItem = searchButton;
}

-(void)createBlurView
{
    UIView *backgroundViewForCollectionView=[[UIView alloc]init];
    [backgroundViewForCollectionView setBackgroundColor: [UIColor colorWithPatternImage:
                                                          [UIImage imageNamed: @"colorTriangles"]]];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect: blurEffect];
    blurEffectView.frame = self.view.bounds;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [backgroundViewForCollectionView addSubview: blurEffectView];
    [self.collectionView setBackgroundView: backgroundViewForCollectionView];
}

////// ITEM SIZE of items inside collection view
- (CGSize)collectionView: (UICollectionView *)collectionView
                  layout: (UICollectionView*)collectionViewLayout
  sizeForItemAtIndexPath: (NSIndexPath *)indexPath
{
    CGFloat cellLeg = (self.collectionView.frame.size.width/2.5)-2;
    return CGSizeMake(cellLeg, cellLeg*1.5);
}

//// COLLECTION VIEW EDGE INSETS(spacing all around each view in collection)
- (UIEdgeInsets)collectionView: (UICollectionView *)collectionView
                        layout: (UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex: (NSInteger)section
{
    return UIEdgeInsetsMake(20, 25, 20, 25);
}

//// COLLECTION VIEW MINIMUM LINE SPACING (Horizontal spacing betweet top and bottom)
- (CGFloat)collectionView: (UICollectionView *)collectionView
                   layout: (UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex: (NSInteger)section
{
    return 20;
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

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"awesomeCell"
                                                                           forIndexPath: indexPath];
 
    [[[cell contentView] subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];

    UIImageView *movieImageView = [[UIImageView alloc]init];
    NSMutableDictionary *aMovieCVDictionary= self.movieCVArray[indexPath.row];
    
                       if ([[self.movieCVArray[indexPath.row] valueForKey: @"poster"] isKindOfClass: [UIImage class]])
                       {
                           movieImageView.image = [self.movieCVArray[indexPath.row] valueForKey: @"poster"];
                       }
    
                      else
                      {
                        
                       NSURL *movieCVPosterURL = [[NSURL alloc] initWithString: [aMovieCVDictionary valueForKey: @"poster"]];
                       NSData *movieCVData = [[NSData alloc] initWithContentsOfURL: movieCVPosterURL];
                       
                           if (movieCVData)
                           {
                               UIImage *movieCVPosterImage = [[UIImage alloc] initWithData: movieCVData];
                               
                               dispatch_async(dispatch_get_main_queue(),
                                ^{
                                    if (cell)
                                        {
                                            movieImageView.image = movieCVPosterImage;
                                            [self.movieCVArray[indexPath.row] setValue: movieImageView.image forKey: @"poster"];
                                        }
                                });
                           }
                       
                       else
                       {
                           dispatch_async(dispatch_get_main_queue(),
                            ^{
                                movieImageView.image =  [UIImage imageNamed: @"Ios Application Placeholder Filled-100 (2)"];
                                movieImageView.clipsToBounds = YES;
                                
                           [self.movieCVArray[indexPath.row] setValue: movieImageView.image forKey: @"poster"];
                            });
                       }
                    }
    
    [cell.contentView addSubview: movieImageView];
    
    movieImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [movieImageView.heightAnchor constraintEqualToAnchor: cell.contentView.heightAnchor].active = YES;
    [movieImageView.widthAnchor constraintEqualToAnchor: cell.contentView.widthAnchor].active = YES;
    [movieImageView.centerXAnchor constraintEqualToAnchor: cell.contentView.centerXAnchor].active =YES;
    [movieImageView.centerYAnchor constraintEqualToAnchor: cell.contentView.centerYAnchor].active =YES;
    [movieImageView setContentMode: UIViewContentModeScaleToFill];
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
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionFooter
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
    
    movieDataTrain.movieObject = movieObjectToBePassed;
}

@end
