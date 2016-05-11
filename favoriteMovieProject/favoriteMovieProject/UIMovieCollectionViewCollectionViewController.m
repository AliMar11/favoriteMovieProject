//
//  UIMovieCollectionViewCollectionViewController.m
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 5/2/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import "UIMovieCollectionViewCollectionViewController.h"

@interface UIMovieCollectionViewCollectionViewController ()

@end

@implementation UIMovieCollectionViewCollectionViewController

static NSString * const reuseIdentifier = @"awesomeCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *keyword = [[NSString alloc]init];

    if (self.searchBar.text !=nil)
    {
        keyword = self.searchBar.text;

    }
    else if (self.searchBar.text == nil)
    {
        keyword = @"star+wars";
        
    }
    [OMDBClient getRepositoriesWithKeyword: keyword completion:^(NSArray *response)
    {
        

        
    }];
    
    self.collectionViewTreats = [@[@"colorPiant",
                                   @"colorAbstract",
                                   @"google-classic",
                                   @"yoda troubles",
                                   @"colorImplosion",
                                   @"release-the-wee-kraken.jpg",
                                   @"Yellow-Funny-Typography-s",
                                   @"abstract colors",
                                   @"colorPatterns",
                                   @"colorTriangles"] mutableCopy];
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.placeholder = @"enter search keyword(s)";
    self.searchBar.tintColor = [UIColor blueColor];
    self.searchBar.barTintColor = [UIColor lightGrayColor];
    //self.searchBar.searchFieldBackgroundPositionAdjustment =
    self.searchBar.showsSearchResultsButton = YES;
    self.searchBar.searchResultsButtonSelected = YES;

    
    
    //search button time!!
    UIBarButtonItem *searchButton= [[UIBarButtonItem alloc] initWithTitle:@"Search!"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(getRepositoriesWithKeyword:completion:)];
    self.navigationItem.rightBarButtonItem = searchButton;
    
//    [searchButton setTitle:@"Search!" forState:UIControlStateNormal];
//   // [searchButton setTitle:@"Searching..." forState:UIControlEventTouchUpInside];
    
    
    UIView *backgroundViewForCollectionView=[[UIView alloc]init];
    [backgroundViewForCollectionView setBackgroundColor:[UIColor colorWithPatternImage:
                                                         [UIImage imageNamed:@"colorTriangles"]]];
    
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect: blurEffect];
    blurEffectView.frame = self.view.bounds;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [backgroundViewForCollectionView addSubview: blurEffectView];
    [self.collectionView setBackgroundView: backgroundViewForCollectionView];
    //set constraints for backroundCForCollectionV
 

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier: @"awesomeCell"];
        
}

////// ITEM SIZE of items inside collection view
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellLeg = (self.collectionView.frame.size.width/2.5) -2;
    return CGSizeMake(cellLeg, cellLeg*1.5);
}

//// COLLECTION VIEW EDGE INSETS(spacing all around each view in collection)
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 20, 10, 20);
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
    return 1;//THE PLAN: later on, we can create genre arrays, where the num of sections = num of genres
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionViewTreats.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"awesomeCell" forIndexPath:indexPath];
    
    UIImageView *movieImageView = [[UIImageView alloc]init];
    movieImageView.image = [UIImage imageNamed: [self.collectionViewTreats objectAtIndex: indexPath.row]];
    
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

//now finish this later!
-(void)searchQuery
{
    
    
}

//in order to search for a movie from API
/*
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    searchResults = [recipes filteredArrayUsingPredicate:resultPredicate];
}
*/
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
