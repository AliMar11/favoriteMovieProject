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
@property (assign, nonatomic) int viewTrailing;
@property (assign, nonatomic) int viewLeadingAnchor;
@property (nonatomic) UICollectionView *collectionView;

@end

@implementation UIMovieCollectionViewCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionViewTreats = [[NSMutableArray alloc]initWithObjects:@"8bit hearts", @"colorTriangles", @"google-classic", @"cool cloud", @"trust computer", @"Yellow-Funny-Typography-s", nil];
    
    //int *viewTrailing = self.view.trailingAnchor;
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame: CGRectMake(self.viewTrailing, self.viewLeadingAnchor, 412, 75)];
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.searchBar.delegate = self;
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.placeholder = @"enter search keywords";
    self.searchBar.tintColor = [UIColor blueColor];
    self.searchBar.barTintColor = [UIColor lightGrayColor];
    self.searchBar.showsCancelButton = YES;
    [self.navigationController.navigationBar addSubview: searchBar];
 
//    [self.searchBar.centerYAnchor constraintEqualToAnchor: self.view.centerYAnchor].active = YES;
//    [self.searchBar.centerXAnchor constraintEqualToAnchor: self.view.centerXAnchor].active = YES;
    
    self.collectionView.contentInset = UIEdgeInsetsMake(self.searchBar.frame.size.height, 5, 0, 5);
    self.collectionView.contentOffset = CGPointMake(0, -self.searchBar.frame.size.height);
    
    
    self.view = [[UIView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame: self.view.frame collectionViewLayout:layout];
    [self.collectionView setDataSource: self];
    [self.collectionView setDelegate: self];
    [self.collectionView setBackgroundColor:[UIColor yellowColor]];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
 
    [self.view addSubview: self.collectionView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return self.collectionViewTreats.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                           forIndexPath:indexPath];
    
    UIImageView *testImages = (UIImageView *)[cell viewWithTag:100];
    testImages.image = [UIImage imageNamed:[_collectionViewTreats objectAtIndex:indexPath.row]];
    //cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [self.view addSubview:testImages];
    
   // cell.backgroundView = [UIImage imageNamed:[testImages]];
    cell.backgroundColor=[UIColor colorWithPatternImage: [UIImage imageNamed:[_collectionViewTreats objectAtIndex:indexPath.row]]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellLeg = (self.collectionView.frame.size.width/2) - 5;
    return CGSizeMake(cellLeg,cellLeg);
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
