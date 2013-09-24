//
//  SetCard.h
//  Matchismo
//
//  Created by Kyle Rogers on 9/8/13.
//  Copyright (c) 2013 Kyle Rogers. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shade;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validShapes;
+ (NSArray *)validColors;
+ (NSArray *)validShades;
+ (NSUInteger)maxRank;

@end
