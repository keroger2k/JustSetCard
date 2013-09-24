//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Kyle Rogers on 9/8/13.
//  Copyright (c) 2013 Kyle Rogers. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init
{
    self = [super init];
    
    if(self) {
        for(NSString *color in [SetCard validColors]) {
            for(NSString *shape in [SetCard validShapes]) {
                for(NSString *shade in [SetCard validShades]) {
                    for(NSUInteger rank = 1; rank <= [SetCard maxRank]; rank++){
                        SetCard *card = [[SetCard alloc] init];
                        card.rank = rank;
                        card.color = color;
                        card.shape = shape;
                        card.shade = shade;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
