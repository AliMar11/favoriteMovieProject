//
//  FISDetailViewController.h
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 6/22/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//
#import "DetailMovieObject.h"
#import <UIKit/UIKit.h>
#import "FISMovieObjectDataStore.h"
#import "FISMovie.h"
#import "FISOMDBClient.h"

@interface  FISDetailViewController : UIViewController
@property (nonatomic, strong) FISMovie *seguedMovie;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

-(void)showboatThePicture;
-(void)displayMovieInfo;
- (void)updateMovieWithDictionary:(NSDictionary *)desiredDictionary;

@end
