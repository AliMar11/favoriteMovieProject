//
//  FISFavoritesTableViewController
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 5/2/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FISMovie.h"
#import "FISMovieObjectDataStore.h"
#import "DetailMovieObject.h"

@interface FISFavoritesTableViewController : UITableViewController 

-(void)deleteAllTheThings;
-(void)DeleteThisOneThing:(DetailMovieObject *)movieObject;
@end
