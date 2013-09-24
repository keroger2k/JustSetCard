//
//  SetCardView.h
//  SetCardViews
//
//  Created by Kyle Rogers on 9/19/13.
//  Copyright (c) 2013 Kyle Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *shade;
@property (strong, nonatomic) NSString *color;

@property (nonatomic) BOOL faceUp;


@end
