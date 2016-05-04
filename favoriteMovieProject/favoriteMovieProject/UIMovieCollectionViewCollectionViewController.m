//
//  UIMovieCollectionViewCollectionViewController.m
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 5/2/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import "UIMovieCollectionViewCollectionViewController.h"

@interface UIMovieCollectionViewCollectionViewController () <UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *collectionViewTreats;
@property (weak, nonatomic) IBOutlet UIImageView *collectionImageView;

@end

@implementation UIMovieCollectionViewCollectionViewController

static NSString * const reuseIdentifier = @"awesomeCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionViewTreats = [@[@"8bit hearts", @"colorTriangles", @"google-classic", @"cool cloud", @"trust computer", @"Yellow-Funny-Typography-s"] mutableCopy];
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.autoresizingMask = YES;  //idk if this is what I want.
    
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
    
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.placeholder = @"enter search keyword(s)";
    self.searchBar.tintColor = [UIColor blueColor];
    self.searchBar.barTintColor = [UIColor lightGrayColor];
    self.searchBar.showsCancelButton = YES;
    
 
 
    //self.collectionView.contentInset = UIEdgeInsetsMake(self.searchBar.frame.size.height, 5, 0, 5);
    //self.collectionView.contentOffset = CGPointMake(0, -self.searchBar.frame.size.height);
    
    
    [self.collectionView setDataSource: self];
    [self.collectionView setDelegate: self];
    [self.collectionView setBackgroundColor:[UIColor yellowColor]];

    
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
    CGFloat cellLeg = (self.collectionView.frame.size.width/3) -2;
    return CGSizeMake(cellLeg, cellLeg);
}

//// COLLECTION VIEW EDGE INSETS(spacing all around each view in collection)
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(30, 30, 30, 30);
}

//// COLLECTION VIEW MINIMUM LINE SPACING (Horizontal spacing betweet top and bottom)
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 30;
}

// COLLECTION VIEW MINIMUM INTERITEM SPACING
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 30;
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
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"awesomeCell" forIndexPath:indexPath];
    
    //Why doesn't this work?
   // cell.bounds.size.height =CGRectGetWidth(40);
    
    cell.backgroundColor= [UIColor colorWithPatternImage: [UIImage imageNamed:[self.collectionViewTreats objectAtIndex:indexPath.row]]];
    
    return cell;
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
