//
//  Deck.h
//  Matchismo
//
//  Created by Kyle Rogers on 8/28/13.
//  Copyright (c) 2013 Kyle Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@property (nonatomic) NSUInteger count;

@end
