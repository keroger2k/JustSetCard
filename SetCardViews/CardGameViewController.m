//
//  CardGameViewController.m
//  SetCardViews
//
//  Created by Kyle Rogers on 9/19/13.
//  Copyright (c) 2013 Kyle Rogers. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "SetCard.h"
#import "SetCardView.h"
#import "SetCardDeck.h"
#import "SetCardMatchingGame.h"
#import "SetCardCollectionViewCell.h"

@interface CardGameViewController () <UICollectionViewDataSource>
@property (strong, nonatomic) SetCardMatchingGame *game;
@property (strong, nonatomic) Deck *deck;
@property (weak, nonatomic) IBOutlet UILabel *cardsRemaining;
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
@end

@implementation CardGameViewController

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return [self.game.cards count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SetCard" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card];
    return cell;
}

- (NSUInteger)startingCardCount
{
    return 12;
}

- (Deck *)deck
{
    if (!_deck) _deck = [[SetCardDeck alloc] init];
    return _deck;
}

- (SetCardMatchingGame *)game
{
    if(!_game) _game = [[SetCardMatchingGame alloc] initWithCardCount:self.startingCardCount usingDeck:self.deck];
    return _game;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    if([cell isKindOfClass:[SetCardCollectionViewCell class]]) {
        SetCardView *setCardView = ((SetCardCollectionViewCell *)cell).setCardView;
        if([card isKindOfClass:[SetCard class]]){
            SetCard *setCard = (SetCard *)card;
            setCardView.rank = setCard.rank;
            setCardView.shade = setCard.shade;
            setCardView.shape = setCard.shape;
            setCardView.color = setCard.color;
            setCardView.faceUp = setCard.isFaceUp;
        }
    }
    self.cardsRemaining.text = [NSString stringWithFormat:@"Cards Reamining: %d", 81 - [self.game.cards count]];
}

- (void)updateUI
{
    
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card];
    }
    
}

- (IBAction)addThreeCards {
    
    for (int i = 0; i < 3; i++) {
        [self.game addCardFromDeck];
    }
    [self.cardCollectionView insertItemsAtIndexPaths:@[
                                                       [NSIndexPath indexPathForItem:[self.game.cards count] - 3 inSection:0],
                                                       [NSIndexPath indexPathForItem:[self.game.cards count] - 2 inSection:0],
                                                       [NSIndexPath indexPathForItem:[self.game.cards count] - 1 inSection:0]
                                                       ]];
    [self.cardCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:([self.game.cards count]-1) inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
    self.cardsRemaining.text = [NSString stringWithFormat:@"Cards Reamining: %d", 81 - [self.game.cards count]];
}

- (IBAction)deal{
    _game = nil;
    _deck = nil;
    [self updateUI];
}

- (IBAction)flipCard:(UITapGestureRecognizer *)gesture {
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    if(indexPath) {
        [self.game flipCardAtIndex:indexPath.item];
        [self updateUI];
    }
}

@end
