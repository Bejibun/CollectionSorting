//
//  CollectionCell.m
//  Space_Coding_Challenge
//
//  Created by Frans Kurniawan on 4/23/14.
//  Copyright (c) 2014 Frans Kurniawan. All rights reserved.
//

#import "CollectionCell.h"

@interface CollectionCell ()

@end

@implementation CollectionCell
@synthesize textLabel,titleLabel,createdDateLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
    }
    
    return self;
    
}

@end
