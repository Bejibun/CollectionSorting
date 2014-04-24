//
//  MainViewController.h
//  Space_Coding_Challenge
//
//  Created by Frans Kurniawan on 4/23/14.
//  Copyright (c) 2014 Frans Kurniawan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionCell.h"

@interface MainViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,NSURLConnectionDelegate>
{
}
// Collection View
@property (strong, nonatomic) IBOutlet UICollectionView *colView;

// Attributes Title, Text, Created_Date
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *textArray;
@property (nonatomic, strong) NSMutableArray *createdDateArray;

//Index
@property (nonatomic,assign) int index;

//Collection Cell
@property (nonatomic, strong) CollectionCell *colCell;

//Combined Dictionary
@property (nonatomic, strong) NSArray *combinedDict;

// Sort Button Action clicked : SortByTitle and SortByLabel
- (IBAction)sortByTitleClicked:(id)sender;

- (IBAction)sortByDateClicked:(id)sender;

@end
