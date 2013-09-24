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
    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    return self.startingCardCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SetCard" forIndexPath:indexPath];
    //NSLog(@"index path: %d", indexPath.item);
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card];
    return cell;
}

- (NSUInteger)startingCardCount
{
    return 40;
}

- (Deck *)deck
{
    if (!_deck) _deck = [[SetCardDeck alloc] init];
    return _deck;
}

- (SetCardMatchingGame *)game
{
    if(!_game) _game = [[SetCardMatchingGame alloc] initWithCardCount:self.deck.count usingDeck:self.deck];
    return _game;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    if([cell isKindOfClass:[SetCardCollectionViewCell class]]) {
        SetCardView *setCardView = ((SetCardCollectionViewCell *)cell).setCardView;
        if([card isKindOfClass:[SetCard class]]){
            if(card.isUnplayable) {
                [self.game.cards removeObject:card];
                card = [self.game getRandomCard];
            }
            SetCard *setCard = (SetCard *)card;
            setCardView.rank = setCard.rank;
            setCardView.shade = setCard.shade;
            setCardView.shape = setCard.shape;
            setCardView.color = setCard.color;
            setCardView.faceUp = setCard.isFaceUp;
        }
    }
}

- (void)updateUI
{
    
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card];
    }
    
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
