//
//  CollectionViewCell.m
//  favoriteMovieProject
//
//  Created by Alicia Marisal on 5/4/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//


#import "CollectionViewCell.h"

@interface CollectionViewCell ()

@end

@implementation CollectionViewCell



-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionFooter)
    {
        UICollectionReusableView *footerView = [collectionView dequeueReusableCellWithReuseIdentifier: @"footerView" forIndexPath: indexPath];
        
        reusableView = footerView;
    }
    
    [reusableView.trailingAnchor constraintEqualToAnchor: reusableView.leadingAnchor].active = YES;
    [reusableView.leadingAnchor constraintEqualToAnchor: reusableView.trailingAnchor].active= YES;

    return reusableView;
    
}
@end
