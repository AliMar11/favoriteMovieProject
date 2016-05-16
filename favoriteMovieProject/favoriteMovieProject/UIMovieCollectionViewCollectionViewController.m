//
//  UIMovieCollectionViewCollectionViewController.m
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 5/2/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import "UIMovieCollectionViewCollectionViewController.h"

@interface UIMovieCollectionViewCollectionViewController ()

@property (nonatomic, strong) NSString *keyword;
@end

@implementation UIMovieCollectionViewCollectionViewController

//static NSString * const reuseIdentifier = @"awesomeCell";

- (void)viewDidLoad
{
    [super viewDidLoad];

    [OMDBClient randomContentSearchWithCompletion:^(NSMutableArray *movies)
    
     {
         NSLog(@"OMBD response: %@", movies);
        
         self.movieCVArray = movies;
        
         // [self.movieCVArray arrayByAddingObjectsFromArray: response]; //why doesn't this work?
         NSLog(@"MOVIECVARRAY: %@", self.movieCVArray);
         [self.collectionView reloadData];

     }];
    
   // NSLog(@"NEW MOVIE OBJECT:%@", self.movieCVArray);
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.placeholder = @"enter search keyword(s)";
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
    self.keyword = [self.searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    [OMDBClient getRepositoriesWithKeyword:self.keyword completion:^(NSMutableArray *movies)
     {
         NSLog(@"SEARCH RESPOSE:\n%@", movies);
         NSLog(@"the keyword used with 'search' button tap:%@", self.keyword);
         
//         [self.collectionView registerClass:[UICollectionViewCell class]
//                 forCellWithReuseIdentifier: @"awesomeCell"];
         [self.collectionView reloadData];
     
         [self numberOfSectionsInCollectionView: self.collectionView];
         NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex: movies.count];
         [self collectionView:self.collectionView cellForItemAtIndexPath: indexPath];
     }];
}

////// ITEM SIZE of items inside collection view
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionView*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellLeg = (self.collectionView.frame.size.width/2.5) -2;
    return CGSizeMake(cellLeg, cellLeg*1.5);
}

//// COLLECTION VIEW EDGE INSETS(spacing all around each view in collection)
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//// COLLECTION VIEW MINIMUM LINE SPACING (Horizontal spacing betweet top and bottom)
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}

// COLLECTION VIEW MINIMUM INTERITEM SPACING (between views within collection)
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark <UICollectionViewDataSource>


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    //***THE PLAN: later on, we can create genre arrays, where the num of sections = num of genres
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"(1)NUMBERS ITMS SECTION COUNT:%li", self.movieCVArray.count);
 
    return self.movieCVArray.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"ENTERED CELL FOR ITEM METHOD");
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"awesomeCell"
                                                                           forIndexPath:indexPath];
  
    NSLog(@"(2)CONTENT FOR CELL ITEMS:\n%@",self.movieCVArray);
    
    //movieImageView.image = [UIImage imageNamed: [self.collectionViewTreats objectAtIndex: indexPath.row]];
    //reach into dictionary and grab the image url
    //turn it into NSData
    //turn that into UIImage
 
    UIImageView *movieImageView = [[UIImageView alloc]init];
    
    
    NSDictionary *aMovieCVDictionary= self.movieCVArray[indexPath.row];
    NSURL *movieCVPosterURL = [[NSURL alloc] initWithString: [aMovieCVDictionary valueForKey:@"_posterPic"]];
    NSLog(@"moviePosterURL:]n%@", movieCVPosterURL);
   
    NSData *movieCVData = [[NSData alloc] initWithContentsOfURL: movieCVPosterURL];
    UIImage *movieCVPosterImage = [[UIImage alloc] initWithData: movieCVData];
    
    movieImageView.image = movieCVPosterImage;
    NSLog(@"movieCVPosterImage:\n%@", movieCVPosterImage);
    NSLog(@"movieCVPosterImage:\n%@", movieCVPosterImage);
    
    [cell.contentView addSubview:movieImageView];
 
    movieImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [movieImageView.heightAnchor constraintEqualToAnchor:cell.contentView.heightAnchor].active = YES;
    [movieImageView.widthAnchor constraintEqualToAnchor:cell.contentView.widthAnchor].active = YES;
    [movieImageView.centerXAnchor constraintEqualToAnchor:cell.contentView.centerXAnchor].active =YES;
    [movieImageView.centerYAnchor constraintEqualToAnchor:cell.contentView.centerYAnchor].active =YES;
    [movieImageView setContentMode: UIViewContentModeScaleAspectFill];
    movieImageView.clipsToBounds = YES;
    
    return cell;
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionFooter)
    {
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        
        reusableView = footerView;
    }
    
    return reusableView;
}


#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

@end
