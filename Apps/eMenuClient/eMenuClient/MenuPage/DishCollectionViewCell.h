//
//  DishCollectionViewCell.h
//  eMenuClient
//
//  Created by Realank on 2018/2/12.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"
@interface DishCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) RLKDish* dish;
@property (nonatomic, weak) id<DishOrderChangeDelegate> delegate;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath*)indexPath;
+ (void)registerCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath*)indexPath;

@end
