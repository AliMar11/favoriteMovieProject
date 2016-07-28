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
    
    self.sharedDatastore = [FISMovieObjectDataStore sharedDataStore];
    [self.sharedDatastore fetchData];
    //[self.tableView reloadData];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: @"detailMovieCell"];

    UIBarButtonItem *deleteAllFavorites = [[UIBarButtonItem alloc] initWithTitle: @"Delete All" style:UIBarButtonItemStylePlain target: self action: @selector(deleteAllTheThingsWithCompletion:)];
    
    self.navigationItem.leftBarButtonItem = deleteAllFavorites;
    
    NSLog(@"\n\nFAV MOVIES:\n%@\n\n", self.sharedDatastore.movies);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
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

    // No cell seperators = clean design
    //tableView.separatorColor = [UIColor clearColor];
    
    return cell;
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end
