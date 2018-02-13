//
//  DishCollectionViewCell.h
//  eMenuClient
//
//  Created by Realank on 2018/2/12.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DishCellOrderChangeDelegate

- (void)wantOrder:(BOOL)order dish:(RLKDish*)dish;

@end

@interface DishCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) RLKDish* dish;
@property (nonatomic, weak) id<DishCellOrderChangeDelegate> delegate;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath*)indexPath;
+ (void)registerCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath*)indexPath;

@end
