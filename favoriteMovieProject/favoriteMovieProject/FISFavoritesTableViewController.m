//
//  FISFavoritesTableViewController
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 5/2/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import "FISFavoritesTableViewController.h"

@interface FISFavoritesTableViewController ()

@property (nonatomic, strong) FISMovieObjectDataStore *sharedDatastore;
@end

@implementation FISFavoritesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: @"detailMovieCell"];
    self.sharedDatastore = [FISMovieObjectDataStore sharedDataStore];
    [self.sharedDatastore fetchData];
    NSLog(@"\n\nFAV MOVIES:\n%@\n\n", self.sharedDatastore.movies);

    UIBarButtonItem *deleteAllFavorites = [[UIBarButtonItem alloc] initWithTitle: @"Delete All"
                                                                           style:UIBarButtonItemStylePlain
                                                                          target: self
                                                                          action: @selector(deleteAllTheThingsWithCompletion:)];
    self.navigationItem.leftBarButtonItem = deleteAllFavorites;
    
    
    UIImageView *backgroundView = [[UIImageView alloc] init];
    backgroundView.image = [UIImage imageNamed: @"star3"];
    backgroundView.frame = self.view.bounds;
    
    [self.view addSubview: backgroundView];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle: UIBlurEffectStyleLight];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect: blurEffect];
    blurEffectView.frame = self.view.bounds;
    [backgroundView addSubview: blurEffectView];
    backgroundView.layer.zPosition = -5;
    
    // Uncomment the following line to preserve selection between presentations.
     //self.clearsSelectionOnViewWillAppear = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.sharedDatastore fetchData];
    [self.tableView reloadData];
}


-(void)deleteAllTheThingsWithCompletion:(void(^)(BOOL))completion
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
                                                 [self.tableView reloadData];
                                                 
                                             }];
                                        }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle: @"Cancel"
                                                               style: UIAlertActionStyleCancel
                                                             handler: ^(UIAlertAction * _Nonnull action)
                                       {
                                           [self dismissViewControllerAnimated: YES completion: nil];
                                           
                                       }];
    
    if (completion)
    {
        //[self.sharedDatastore fetchData];
        
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^
//         {
//             [self.tableView reloadData];
//             
//         }];
    }

    [areYouSureController addAction: areYouSureAction];
    [areYouSureController addAction: cancelAction];
    [self presentViewController: areYouSureController animated:YES completion:nil];
}

-(void)DeleteThisOneThing:(DetailMovieObject *)movieObject
{
    NSLog(@"\n\nIs There a Movie Index?\n--->%@\n\n",movieObject);
    [self.sharedDatastore deleteOneEntryWithID: movieObject];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"\n\nNUMBER OF MOVIES: %li\n\n", self.sharedDatastore.movies.count);
    return self.sharedDatastore.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"detailMovieCell" forIndexPath: indexPath];
    
    NSArray *favoritedMovies = self.sharedDatastore.movies;
    NSLog(@"");
    FISMovie *aFavoritedMovie = favoritedMovies[indexPath.row];
    
    NSLog(@"\n\nFISMOVIE OBJECT:\n%@\n\n", aFavoritedMovie.poster);
    NSURL *NSURLPic = [NSURL URLWithString: aFavoritedMovie.poster];
    NSData *picData = [[NSData alloc] initWithContentsOfURL: NSURLPic];
    UIImage *posterPicImage = [UIImage imageWithData: picData];

    cell.imageView.image = posterPicImage;
    cell.textLabel.text = aFavoritedMovie.title;
    cell.backgroundColor = [UIColor clearColor];
//    cell.preservesSuperviewLayoutMargins = NO;
//    cell.autoresizingMask = NO;
//    cell.layoutMargins = UIEdgeInsetsZero;
//    [cell setSeparatorInset: UIEdgeInsetsMake(10, 0, 10, 0)];
    
    // No cell seperators = clean design
    //tableView.separatorColor = [UIColor clearColor];
    return cell;
}

// Change tableview row height:
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return 300;
//}

- (BOOL)tableView: (UITableView *)tableView canEditRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return YES;
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
         {
            DetailMovieObject *movieObject = self.sharedDatastore.movies[indexPath.row];
                // movie = [self.sharedDatastore.movies objectAtIndex: indexPath.row];
               [self DeleteThisOneThing: movieObject];
             [self.tableView reloadData];
         }
}

@end
