//  FISDetailViewController.m
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 6/22/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import "FISDetailViewController.h"

@interface FISDetailViewController ()

@property (strong, nonatomic) FISMovieObjectDataStore *dataStore;

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

    self.dataStore = [FISMovieObjectDataStore sharedDataStore];
    
    UIBarButtonItem *favortiesFolder = [[UIBarButtonItem alloc] initWithTitle: @"Favs"
                                                                        style: UIBarButtonItemStyleDone
                                                                       target: self
                                                                       action: @selector(saveMovieObject)];
    self.navigationItem.rightBarButtonItem = favortiesFolder;
    
    [self showboatThePicture];
    [self displayMovieInfo];
}

-(void)showboatThePicture
{
    NSURL *moviePicture = [[NSURL alloc] initWithString: [self.seguedMovie valueForKey: @"posterPic"]];
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

-(void)displayMovieInfo
{
    NSLog(@"\n\n\nDISPLAY METHOD CALLED\n\n");
    self.yearTextfield.text = [NSString stringWithFormat: @"  Released:  %@", self.seguedMovie.year];
    self.typeTexfield.text = [NSString stringWithFormat: @"  Type:  %@", self.seguedMovie.type];
    self.descriptionTextbox.text = [NSString stringWithFormat: @" No description yet! Go GET it fool!!"];

    
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

    MovieObjects *newFavoriteMovie = [NSEntityDescription insertNewObjectForEntityForName: @"MovieObjects" inManagedObjectContext: self.dataStore.managedObjectContext];
   
    newFavoriteMovie.title = self.titleTextfield.text;
    newFavoriteMovie.year = self.yearTextfield.text;
    newFavoriteMovie.type = self.typeTexfield.text;
    
    NSString *poster = self.seguedMovie.posterPic;
    newFavoriteMovie.posterPic = poster;
        
    [self.dataStore saveContext];
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
