//
//  SetCardMatchingGame.m
//  Matchismo
//
//  Created by Kyle Rogers on 9/8/13.
//  Copyright (c) 2013 Kyle Rogers. All rights reserved.
//

#import "SetCardMatchingGame.h"

@interface SetCardMatchingGame()
@property (nonatomic, strong) Deck *deck;
@end


@implementation SetCardMatchingGame

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)messenger
{
    if(!_messenger) _messenger = [[NSMutableArray alloc] init];
    return _messenger;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)addCardFromDeck {
    [self.cards addObject:[self.deck drawRandomCard]];
}


- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self = [super init];
    self.deck = deck;
    
    if(self) {
        
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if(!card){
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }    return self;
    
}

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSMutableArray *cardsInPlay = [[NSMutableArray alloc] init];
    
    if(!card.isUnplayable) {
        if(!card.isFaceUp){
            for(Card *otherCard in self.cards) {
                if(otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [cardsInPlay addObject:otherCard];
                }
            }
            int messageCount = [self.messenger count];
            if([cardsInPlay count] == 2) {
                int matchScore = [card match:cardsInPlay];
                Card *cardOne = cardsInPlay[0];
                Card *cardTwo = cardsInPlay[1];
                if(matchScore){
                    [self.cards removeObject:card];
                    [self.cards removeObject:cardOne];
                    [self.cards removeObject:cardTwo];
                    self.score += matchScore * MATCH_BONUS;
                    [self.messenger addObject:[NSString stringWithFormat:@"Matched %@ & %@ & %@ for %d points",
                                               cardOne.contents, cardTwo.contents, card.contents, matchScore * MATCH_BONUS]];
                } else {
                    cardOne.faceUp = NO;
                    cardTwo.faceUp = NO;
                    self.score -= MISMATCH_PENALTY;
                    [self.messenger addObject:[NSString stringWithFormat:@"Mis-Matched %@ & %@ & %@ for -%d points",
                                               cardOne.contents, cardTwo.contents, card.contents, MISMATCH_PENALTY]];
                }
            }
            
            if(messageCount == [self.messenger count]) {
                [self.messenger addObject:[NSString stringWithFormat:@"Flipped %@", card.contents]];
            }
            
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}



@end
