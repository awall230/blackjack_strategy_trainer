//
//  ANWDeck.m
//  Blackjack Strategy Trainer
//
//  Created by Adam Waller on 8/26/15.
//  Copyright (c) 2015 Adam Waller. All rights reserved.
//

#import "ANWDeck.h"
#import "ANWCard.h"
#import "ANWHand.h"

@implementation ANWDeck

- (instancetype)init {
    self = [super init];
    if (self) {
        _deck = [NSMutableArray arrayWithCapacity:52];
        [self populateDeck];
    }
    
    return self;
}

- (void)populateDeck {
    int suit, rank;
    for (int i=0; i<52; i++) {
        suit = i / 13;
        rank = (i % 13) + 1;
        self.deck[i] = [[ANWCard alloc] initWithSuitNumber:suit AndRank:rank];
    }
}

- (void)shuffleDeck {
    int index1, index2;
    ANWCard *temp;
    for (int i=0; i<100; i++) {
        // swap two random cards
        index1 = arc4random() % self.deck.count;
        index2 = arc4random() % self.deck.count;
        temp = (ANWCard *)self.deck[index1];
        self.deck[index1] = self.deck[index2];
        self.deck[index2] = temp;
    }
}

- (ANWCard *)drawCard {
    ANWCard *card = [self.deck lastObject];
    [self.deck removeLastObject];
    return card;
}

- (void)printDeck {
    for (ANWCard *card in self.deck) {
        NSLog(@"%d of %@", card.rank, card.suit);
    }
}



@end
