//
//  CollectionCell.h
//  Space_Coding_Challenge
//
//  Created by Frans Kurniawan on 4/23/14.
//  Copyright (c) 2014 Frans Kurniawan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionCell : UICollectionViewCell<NSObject>

// Attributes Label
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *textLabel;
@property (strong, nonatomic) IBOutlet UILabel *createdDateLabel;

@end
