//
//  FavouriteCell.h
//  SydTraffic
//
//  Created by Nicolas Triantafillou on 18/10/13.
//  Copyright (c) 2013 Nicolas Triantafillou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavouriteCell : UICollectionViewCell {
    UIActivityIndicatorView *ai;
}

@property (atomic, strong) IBOutlet UIImageView *imageView;
@property (atomic, strong) UIActivityIndicatorView *ai;

@end
