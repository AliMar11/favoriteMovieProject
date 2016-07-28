//  FISDetailViewController.m
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 6/22/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import "FISDetailViewController.h"
#import "FISMovieDetailViewController.h"

@interface FISDetailViewController ()

@property (strong, nonatomic) FISMovieObjectDataStore *sharedDataStore;
@property (weak, nonatomic) IBOutlet UITextField *typeTextfield;
@property (weak, nonatomic) IBOutlet UITextField *genreTextfield;
@property (weak, nonatomic) IBOutlet UITextField *filmRatingTexfield;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextbox;
@property (weak, nonatomic) IBOutlet UIStackView *textStackView;
@property (weak, nonatomic) IBOutlet UIButton *moreInfoButton;

@end

@implementation FISDetailViewController : UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *titleForNavController = [NSString stringWithFormat: @"%@", self.seguedMovie.title];
    self.navigationItem.title = titleForNavController;

    self.sharedDataStore = [FISMovieObjectDataStore sharedDataStore];
    
    UIBarButtonItem *favortiesFolder = [[UIBarButtonItem alloc] initWithTitle: @"Favs"
                                                                        style: UIBarButtonItemStyleDone
                                                                       target: self
                                                                       action: @selector(saveMovieObject)];
    self.navigationItem.rightBarButtonItem = favortiesFolder;
    
    NSString *imdbID = self.seguedMovie.imdbID;
    [FISOMDBClient getMovieDetailWithMovieID: imdbID completion:^(NSDictionary *desiredDictionary)
     {
        NSLog(@"\n\nWE'VE ENTERED THE GETMOVIEDETAIL RESPONSE \n\ndesiredDictionary:\n%@\n\n", desiredDictionary);
        
         [self updateMovieWithDictionary: (NSDictionary*) desiredDictionary];
         
    } ];
    
    [self showboatThePicture];
    [self displayMovieInfo];
}

-(void)showboatThePicture
{
    NSURL *moviePicture = [[NSURL alloc] initWithString: [self.seguedMovie valueForKey: @"poster"]];
    NSData *moviePicData = [[NSData alloc]initWithContentsOfURL: moviePicture];
    UIImage *dataAsImage = [[UIImage alloc] initWithData: moviePicData];
    self.backgroundImageView.image = dataAsImage;
    
    //background Image View setup
    UIImageView *posterPictureView =[[UIImageView alloc]initWithImage: dataAsImage];
    
    UIBlurEffect *backgroundBlurEffect = [UIBlurEffect effectWithStyle: UIBlurEffectStyleExtraLight];
    UIVisualEffectView *visualViewBlur = [[UIVisualEffectView alloc] initWithEffect: backgroundBlurEffect];
    visualViewBlur.frame = self.view.bounds;
    
    [self.backgroundImageView addSubview: visualViewBlur];
    [visualViewBlur addSubview: posterPictureView];

    posterPictureView.translatesAutoresizingMaskIntoConstraints = NO;
    posterPictureView.preservesSuperviewLayoutMargins = NO;
    
    [posterPictureView.topAnchor constraintEqualToAnchor: self.topLayoutGuide.bottomAnchor constant:20].active = YES;
    [posterPictureView.leadingAnchor constraintEqualToAnchor: visualViewBlur.leadingAnchor constant:60].active = YES;
    //[posterPictureView.bottomAnchor constraintEqualToAnchor: visualViewBlur.bottomAnchor constant:20].active = YES;
}

- (void)updateMovieWithDictionary: (NSDictionary *)desiredDictionary
{
    NSLog(@"updating the init method with detail data");
    self.seguedMovie.releaseDate = [desiredDictionary valueForKey: @"Released"];
    self.seguedMovie.actors = [desiredDictionary valueForKey: @"Actors"];
    self.seguedMovie.director = [desiredDictionary valueForKey: @"Director"];
    self.seguedMovie.genre = [desiredDictionary valueForKey: @"Genre"];
    self.seguedMovie.plot = [desiredDictionary valueForKey: @"Plot"];
    self.seguedMovie.filmRating = [desiredDictionary valueForKey: @"Rated"];
    self.seguedMovie.type = [desiredDictionary valueForKey: @"Type"];
    self.seguedMovie.imdbScore = [desiredDictionary valueForKey: @"imdbRating"];
    
    NSLog(@"%@", self.seguedMovie);
    [self displayMovieInfo];
}

-(void)displayMovieInfo
{
    NSLog(@"\n\n\nDISPLAY METHOD CALLED\n\n");
    self.typeTextfield.text = [NSString stringWithFormat: @"  Released:  %@", self.seguedMovie.releaseDate];
    self.genreTextfield.text = [NSString stringWithFormat: @"  Type:  %@", self.seguedMovie.type];
    self.filmRatingTexfield.text = [NSString stringWithFormat:@"  Rating:  %@", self.seguedMovie.filmRating];
    self.descriptionTextbox.text = [NSString stringWithFormat: @"Plot:%@",self.seguedMovie.plot];

    self.typeTextfield.borderStyle = UITextBorderStyleNone;
    self.typeTextfield.font = [UIFont fontWithName:@"Ariel" size:16.0f];//here offerTitle is the instance of `UILabel`
    self.genreTextfield.borderStyle = UITextBorderStyleNone;
    self.genreTextfield.font = [UIFont fontWithName:@"Ariel" size:16.0f];
    self.filmRatingTexfield.borderStyle = UITextBorderStyleNone;
    self.filmRatingTexfield.font = [UIFont fontWithName:@"Ariel" size:16.0f];
    self.descriptionTextbox.font = [UIFont fontWithName:@"Ariel" size:16.0f];
}

-(void)saveMovieObject
{
    NSLog(@"\n\nEntered savingFavMovie Method\n\n");

    DetailMovieObject *newFavoriteMovie = [NSEntityDescription insertNewObjectForEntityForName: @"MovieObject" inManagedObjectContext: self.sharedDataStore.managedObjectContext];
   
    newFavoriteMovie.title = self.navigationItem.title;
    newFavoriteMovie.filmRating = self.filmRatingTexfield.text;
    newFavoriteMovie.genre = self.genreTextfield.text;
    newFavoriteMovie.type = self.typeTextfield.text;
    newFavoriteMovie.plot = self.descriptionTextbox.text;
    
    newFavoriteMovie.actors = self.seguedMovie.actors;
    newFavoriteMovie.director = self.seguedMovie.director;
    newFavoriteMovie.imdbScore = self.seguedMovie.imdbScore;
    newFavoriteMovie.poster = self.seguedMovie.poster;
    newFavoriteMovie.releaseDate = self.seguedMovie.releaseDate;
    newFavoriteMovie.runTime = self.seguedMovie.runTime;
    newFavoriteMovie.type = self.typeTextfield.text;
    
   [[NSOperationQueue mainQueue] addOperationWithBlock:^
    {
         [self.sharedDataStore saveContext];
    }];
  
}

-(void)moreInfoButtonTapped
{
    NSLog(@"More information ButttonTapped!");
    [self performSegueWithIdentifier: @"detailInfoSegue" sender: self];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    FISMovieDetailViewController *movieTrain = segue.destinationViewController;
    FISMovie *passedMovie = self.seguedMovie;
    movieTrain.movie = passedMovie;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
