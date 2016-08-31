//  FISDetailViewController.m
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 6/22/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import "FISDetailViewController.h"
#import "FISMovieDetailViewController.h"
#import "FISOMDBClient.h"

@interface FISDetailViewController ()

@property (strong, nonatomic) FISMovieObjectDataStore *sharedDataStore;

@property (weak, nonatomic) IBOutlet UIImageView *posterPictureView;
@property (weak, nonatomic) IBOutlet UITextField *typeTextfield;
@property (weak, nonatomic) IBOutlet UITextField *genreTextfield;
@property (weak, nonatomic) IBOutlet UITextField *filmRatingTexfield;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextbox;
@property (weak, nonatomic) IBOutlet UIStackView *textStackView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *moreMovieInfoButton;

@end

@implementation FISDetailViewController : UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *titleForNavController = [NSString stringWithFormat: @"%@", self.movieObject.title];
    self.navigationItem.title = titleForNavController;

    self.sharedDataStore = [FISMovieObjectDataStore sharedDataStore];
    
    [self createFavoritesTab];
    
    NSString *imdbID = self.movieObject.imdbID;
    [FISOMDBClient getMovieDetailWithMovieID: imdbID completion: ^(NSDictionary *desiredDictionary)
     {
        NSLog(@"\n\nWE'VE ENTERED THE GETMOVIEDETAIL RESPONSE \n\ndesiredDictionary:\n%@\n\n", desiredDictionary);
 
         FISMovie *movie = self.movieObject;
         [FISMovie updateMovieWithDictionary: movie : desiredDictionary];
         [self displayMovieInfo];
    } ];
    
    [self showboatThePicture];
    [self displayMovieInfo];
}

-(void)showboatThePicture
{
    NSURL *moviePicture = [[NSURL alloc] initWithString: [self.movieObject valueForKey: @"poster"]];
    NSData *moviePicData = [[NSData alloc]initWithContentsOfURL: moviePicture];
    UIImage *dataAsImage = [[UIImage alloc] initWithData: moviePicData];
    self.backgroundImageView.image = dataAsImage;
    
    
#pragma mark- background and blurEffect setup
  self.posterPictureView.image = dataAsImage;
    
    UIBlurEffect *backgroundBlurEffect = [UIBlurEffect effectWithStyle: UIBlurEffectStyleLight];
    UIVisualEffectView *visualViewBlur = [[UIVisualEffectView alloc] initWithEffect: backgroundBlurEffect];
    visualViewBlur.frame = self.view.bounds;
    
    [self.backgroundImageView addSubview: visualViewBlur];
    [visualViewBlur addSubview: self.posterPictureView];
}

-(void)displayMovieInfo
{
    NSLog(@"\n\n\nDISPLAY METHOD CALLED\n\n");
    self.typeTextfield.text = [NSString stringWithFormat: @"  Released: %@", self.movieObject.releaseDate];
    self.genreTextfield.text = [NSString stringWithFormat: @"  Type:  %@", self.movieObject.type];
    self.filmRatingTexfield.text = [NSString stringWithFormat:@"  Rating: %@", self.movieObject.filmRating];
    self.descriptionTextbox.text = [NSString stringWithFormat: @"Plot: %@",self.movieObject.plot];    
    self.typeTextfield.borderStyle = UITextBorderStyleNone;
    self.typeTextfield.font = [UIFont fontWithName:@"Ariel" size:16.0f];
    [self.typeTextfield setBackgroundColor: [UIColor clearColor]];
    
    self.genreTextfield.borderStyle = UITextBorderStyleNone;
    self.genreTextfield.font = [UIFont fontWithName:@"Ariel" size:16.0f];
    [self.genreTextfield setBackgroundColor: [UIColor clearColor]];
    
    self.filmRatingTexfield.borderStyle = UITextBorderStyleNone;
    self.filmRatingTexfield.font = [UIFont fontWithName:@"System" size: 16.0f];
    [self.filmRatingTexfield setBackgroundColor: [UIColor clearColor]];
    
    [self.descriptionTextbox setBackgroundColor: [UIColor clearColor]];
    self.descriptionTextbox.font = [UIFont fontWithName: @"Verdana" size: 16.0f];
    self.descriptionTextbox.userInteractionEnabled = YES;
    self.descriptionTextbox.scrollEnabled = YES;
    self.descriptionTextbox.showsVerticalScrollIndicator = YES;
    self.descriptionTextbox.textContainerInset = UIEdgeInsetsMake( 0, 15, 5,  0);

}

-(void)saveMovieObject
{
    DetailMovieObject *newFavoriteMovie = [NSEntityDescription insertNewObjectForEntityForName: @"MovieObject" inManagedObjectContext: self.sharedDataStore.managedObjectContext];
    
    newFavoriteMovie.title = self.navigationItem.title;
    newFavoriteMovie.filmRating = self.filmRatingTexfield.text;
    newFavoriteMovie.genre = self.genreTextfield.text;
    newFavoriteMovie.type = self.typeTextfield.text;
    newFavoriteMovie.plot = self.descriptionTextbox.text;
    newFavoriteMovie.type = self.typeTextfield.text;
    
    newFavoriteMovie.actors = self.movieObject.actors;
    newFavoriteMovie.director = self.movieObject.director;
    newFavoriteMovie.imdbScore = self.movieObject.imdbScore;
    newFavoriteMovie.poster = self.movieObject.poster;
    newFavoriteMovie.releaseDate = self.movieObject.releaseDate;
    newFavoriteMovie.runTime = self.movieObject.runTime;
    newFavoriteMovie.imdbID = self.movieObject.imdbID;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^
     {
         [self.sharedDataStore saveContext];
     }];
}
- (IBAction)moreInfoButtonTapped:(id)sender
{
    NSLog(@"More information ButttonTapped!");
    [self performSegueWithIdentifier: @"detailInfoSegue" sender: self];
}


#pragma mark- leLook

-(void)createFavoritesTab
{
    UIBarButtonItem *favortiesTab = [[UIBarButtonItem alloc] initWithTitle: nil
                                                                     style: UIBarButtonItemStyleDone
                                                                    target: self
                                                                    action: @selector(saveMovieObject)];
    
    favortiesTab.image = [UIImage imageNamed: @"Add to Favorites-51"];
    self.navigationItem.rightBarButtonItem = favortiesTab;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    FISMovieDetailViewController *movieTrain = segue.destinationViewController;
    FISMovie *passedMovie = self.movieObject;
    movieTrain.movie = passedMovie;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
