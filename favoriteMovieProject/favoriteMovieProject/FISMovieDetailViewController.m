//
//  FISMovieDetailViewController.m
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 7/19/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import "FISMovieDetailViewController.h"

@interface FISMovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *directorTextField;
@property (weak, nonatomic) IBOutlet UITextField *actorsTextField;
@property (weak, nonatomic) IBOutlet UITextField *genreTextField;
@property (weak, nonatomic) IBOutlet UITextField *filmRatingTextField;
@property (weak, nonatomic) IBOutlet UITextField *imdbScoreTextField;
@property (weak, nonatomic) IBOutlet UITextField *releaseDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *runTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField *typeTextField;
@property (weak, nonatomic) IBOutlet UITextView *plotTextView;
@end

@implementation FISMovieDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"MOVIE:\n%@", self.movie);
    
    [self setUpTheOutlets];
    [self setUpTheImage];
}

#pragma mark- leLook

-(void)setUpTheOutlets
{
    self.directorTextField.text = [NSString stringWithFormat: @" Director: %@", self.movie.director];
    self.actorsTextField.text = [NSString stringWithFormat: @" Actors: %@", self.movie.actors];
    self.genreTextField.text = [NSString stringWithFormat: @" Genre: %@", self.movie.genre];
    self.filmRatingTextField.text = [NSString stringWithFormat: @" Rating: %@", self.movie.filmRating];
    self.imdbScoreTextField.text = [NSString stringWithFormat: @" imdb Movie Score: %@", self.movie.imdbScore];
    self.releaseDateTextField.text = [NSString stringWithFormat: @" Date of Release: %@", self.movie.releaseDate];
    self.runTimeTextField.text = [NSString stringWithFormat: @" Runtime: %@", self.movie.runTime];
    self.typeTextField.text = [NSString stringWithFormat: @" Entertaiment Type: %@", self.movie.type];
    self.plotTextView.text = [NSString stringWithFormat: @" Plot: %@", self.movie.plot];
}

-(void)setUpTheImage
{
    NSURL *posterURL = [[NSURL alloc] initWithString: self.movie.poster];
    NSData *posterData = [[NSData alloc]initWithContentsOfURL: posterURL];
    UIImage *posterImage = [[UIImage alloc] initWithData: posterData];
    
    UIImageView *backgroundPicture = [[UIImageView alloc] initWithImage: posterImage];
    backgroundPicture.frame = self.view.bounds;
    UIBlurEffect *backgroundBlurEffect = [UIBlurEffect effectWithStyle: UIBlurEffectStyleLight];
    UIVisualEffectView *visualViewBlur = [[UIVisualEffectView alloc] initWithEffect: backgroundBlurEffect];
    visualViewBlur.frame = self.view.bounds;
    
    [backgroundPicture addSubview: visualViewBlur];
    [self.view addSubview: backgroundPicture];
    backgroundPicture.layer.zPosition = -5;
    
    [backgroundPicture.topAnchor constraintEqualToAnchor: self.view.topAnchor].active = YES;
    [backgroundPicture.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor].active = YES;
    [backgroundPicture.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor].active = YES;
    [backgroundPicture.bottomAnchor constraintEqualToAnchor: self.self.view.bottomAnchor].active = YES;
    
    [self.directorTextField setBackgroundColor: [UIColor clearColor]];
    [self.actorsTextField setBackgroundColor: [UIColor clearColor]];
    [self.genreTextField setBackgroundColor: [UIColor clearColor]];
    [self.filmRatingTextField setBackgroundColor: [UIColor clearColor]];
    [self.imdbScoreTextField setBackgroundColor: [UIColor clearColor]];
    [self.releaseDateTextField setBackgroundColor: [UIColor clearColor]];
    [self.runTimeTextField setBackgroundColor: [UIColor clearColor]];
    [self.typeTextField setBackgroundColor: [UIColor clearColor]];
    [self.plotTextView setBackgroundColor: [UIColor clearColor]];
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

@end
