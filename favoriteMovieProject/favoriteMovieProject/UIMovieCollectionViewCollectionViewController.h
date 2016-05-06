//
//  UIMovieCollectionViewCollectionViewController.h
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 5/2/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIMovieCollectionViewCollectionViewController : UICollectionViewController <UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *collectionViewTreats;
@property (weak, nonatomic) IBOutlet UIImageView *collectionImageView;

@end
