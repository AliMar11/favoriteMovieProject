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

#pragma mark <VC visualSetup>
-(void)setUpTheOutlets
{
    dispatch_async(dispatch_get_main_queue(),
    ^{
    self.directorTextField.text = [NSString stringWithFormat: @" Director: %@", self.movie.director];
    self.actorsTextField.text = [NSString stringWithFormat: @" Actors: %@", self.movie.actors];
    self.genreTextField.text = [NSString stringWithFormat: @" Genre: %@", self.movie.genre];
    self.filmRatingTextField.text = [NSString stringWithFormat: @" Rating: %@", self.movie.filmRating];
    self.imdbScoreTextField.text = [NSString stringWithFormat: @" imdb Movie Score: %@", self.movie.imdbScore];
    self.releaseDateTextField.text = [NSString stringWithFormat: @" Date of Release: %@", self.movie.releaseDate];
    self.runTimeTextField.text = [NSString stringWithFormat: @" Runtime: %@", self.movie.runTime];
    self.typeTextField.text = [NSString stringWithFormat: @" Entertaiment Type: %@", self.movie.type];
    self.plotTextView.text = [NSString stringWithFormat: @"Plot: %@", self.movie.plot];
  
    });
}

-(void)setUpTheImage
{
    UIImageView *backgroundPicture = [[UIImageView alloc] initWithImage: [self.movie valueForKey: @"poster"]];
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
}

@end
