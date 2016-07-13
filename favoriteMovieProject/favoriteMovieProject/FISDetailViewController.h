//
//  FISDetailViewController.h
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 6/22/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FISMovieObjectDataStore.h"
#import "FISMovie.h"

@interface  FISDetailViewController : UIViewController

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) FISMovie *seguedMovie;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

-(void)showboatThePicture;
-(void)displayMovieInfo;

@end
