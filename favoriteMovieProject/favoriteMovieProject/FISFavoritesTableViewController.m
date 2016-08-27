//
//  FISFavoritesTableViewController
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 5/2/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import "FISFavoritesTableViewController.h"

@interface FISFavoritesTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) FISMovieObjectDataStore *sharedDatastore;
@end

@implementation FISFavoritesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.sharedDatastore = [FISMovieObjectDataStore sharedDataStore];
    [self.sharedDatastore fetchData];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: @"detailMovieCell"];
    
    [self deleteFavoriteMoviesButton];
    [self setUpTheImage];
    
    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: YES];
    [self.sharedDatastore fetchData];
    [self.tableView reloadData];
}

-(void)deleteAllTheThings
{
    
    UIAlertController *areYouSureController = [UIAlertController alertControllerWithTitle:@"Warning:"
                                                                                  message:@"Are you sure you want to delete your favorites folder?" preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *areYouSureAction = [UIAlertAction actionWithTitle: @"OK"
                                                               style: UIAlertActionStyleDestructive
                                                             handler: ^(UIAlertAction * _Nonnull action)
                                       {
                                           
                                           [self.sharedDatastore deleteAllContext];
                                           
                                           [[NSOperationQueue mainQueue] addOperationWithBlock:^
                                            {
                                                [self.sharedDatastore fetchData];
                                                [self.tableView reloadData];
                                                
                                            }];
                                           
                                       }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle: @"Cancel"
                                                           style: UIAlertActionStyleCancel
                                                         handler: ^(UIAlertAction * _Nonnull action)
                                   {
                                       [self dismissViewControllerAnimated: YES completion: nil];
                                       
                                   }];
    
    [areYouSureController addAction: areYouSureAction];
    [areYouSureController addAction: cancelAction];
    [self presentViewController: areYouSureController animated:YES completion:nil];
}

-(void)DeleteThisOneThing:(DetailMovieObject *)movieObject
{
    [self.sharedDatastore deleteOneMovieInstance: movieObject];
}

-(void)deleteFavoriteMoviesButton
{
    UIBarButtonItem *deleteAllFavorites = [[UIBarButtonItem alloc] initWithTitle: @"Delete All"
                                                                           style:UIBarButtonItemStylePlain
                                                                          target: self
                                                                          action: @selector(deleteAllTheThings)];
    self.navigationItem.leftBarButtonItem = deleteAllFavorites;
}

#pragma mark -leLook
-(void)setUpTheImage
{
    UIImageView *backgroundView = [[UIImageView alloc] init];
    backgroundView.image = [UIImage imageNamed: @"star3"];
    backgroundView.frame = self.view.bounds;
    
    [self.view addSubview: backgroundView];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle: UIBlurEffectStyleLight];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect: blurEffect];
    blurEffectView.frame = self.view.bounds;
    [backgroundView addSubview: blurEffectView];
    backgroundView.layer.zPosition = -5;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sharedDatastore.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"detailMovieCell" forIndexPath: indexPath];
    
    NSArray *favoritedMovies = self.sharedDatastore.movies;
    FISMovie *aFavoritedMovie = favoritedMovies[indexPath.row];
    
    NSLog(@"\n\nFISMOVIE OBJECT:\n%@\n\n", aFavoritedMovie.poster);
    NSURL *NSURLPic = [NSURL URLWithString: aFavoritedMovie.poster];
    NSData *picData = [[NSData alloc] initWithContentsOfURL: NSURLPic];
    UIImage *posterPicImage = [UIImage imageWithData: picData];
    
    cell.imageView.image = posterPicImage;
    cell.imageView.clipsToBounds = YES;
    
    //cell.contentMode = UIViewContentModeScaleAspectFill;
    //self.tableView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    cell.textLabel.text = aFavoritedMovie.title;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

- (BOOL)tableView: (UITableView *)tableView canEditRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return YES;
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        DetailMovieObject *movieObject = self.sharedDatastore.movies[indexPath.row];
        [self DeleteThisOneThing: movieObject];
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
