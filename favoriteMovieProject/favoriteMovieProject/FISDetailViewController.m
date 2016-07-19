//  FISDetailViewController.m
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 6/22/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import "FISDetailViewController.h"

@interface FISDetailViewController ()

@property (strong, nonatomic) FISMovieObjectDataStore *sharedDataStore;
@property (weak, nonatomic) IBOutlet UITextField *titleTextfield;
@property (weak, nonatomic) IBOutlet UITextField *yearTextfield;
@property (weak, nonatomic) IBOutlet UITextField *typeTexfield;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextbox;
@property (weak, nonatomic) IBOutlet UIStackView *textStackView;

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
    
    //poster Image View setup
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

- (void)updateMovieWithDictionary:(NSDictionary *)desiredDictionary
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
    self.yearTextfield.text = [NSString stringWithFormat: @"  Released:  %@", self.seguedMovie.releaseDate];
    self.typeTexfield.text = [NSString stringWithFormat: @"  Type:  %@", self.seguedMovie.type];
    self.descriptionTextbox.text = self.seguedMovie.plot;

    self.titleTextfield.borderStyle = UITextBorderStyleNone;
    self.titleTextfield.font = [UIFont fontWithName:@"Ariel" size:16.0f];//here offerTitle is the instance of `UILabel`
    self.yearTextfield.borderStyle = UITextBorderStyleNone;
    self.yearTextfield.font = [UIFont fontWithName:@"Ariel" size:16.0f];
    self.typeTexfield.borderStyle = UITextBorderStyleNone;
    self.typeTexfield.font = [UIFont fontWithName:@"Ariel" size:16.0f];
    self.descriptionTextbox.font = [UIFont fontWithName:@"Ariel" size:16.0f];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)saveMovieObject
{
    NSLog(@"\n\nEntered savingFavMovie Method\n\n");

    DetailMovieObject *newFavoriteMovie = [NSEntityDescription insertNewObjectForEntityForName: @"MovieObject" inManagedObjectContext: self.sharedDataStore.managedObjectContext];
   
    newFavoriteMovie.title = self.titleTextfield.text;
    //newFavoriteMovie.year = self.yearTextfield.text;
    newFavoriteMovie.type = self.typeTexfield.text;
    
    NSString *poster = self.seguedMovie.poster;
    newFavoriteMovie.poster = poster;
        
    [self.sharedDataStore saveContext];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
