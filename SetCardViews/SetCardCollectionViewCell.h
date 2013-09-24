//
//  SetCardCollectionViewCell.h
//  SetCardViews
//
//  Created by Kyle Rogers on 9/20/13.
//  Copyright (c) 2013 Kyle Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCardView.h"

@interface SetCardCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet SetCardView *setCardView;
@end
