//
//  FISDetailViewController.h
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 6/22/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "FISMovie.h"
#import "DetailMovieObject.h"
#import "FISMovieObjectDataStore.h"
#import "FISOMDBClient.h"

@interface  FISDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, strong) FISMovie *movieObject;

-(void)showboatThePicture;
-(void)displayMovieInfo;

@end
