//
//  ANWHand.m
//  Blackjack Strategy Trainer
//
//  Created by Adam Waller on 8/26/15.
//  Copyright (c) 2015 Adam Waller. All rights reserved.
//

#import "ANWHand.h"
#import "ANWDeck.h"
#import "ANWCard.h"
#import "ANWGameManager.h"

@implementation ANWHand

- (instancetype)initWithDealer:(BOOL)isDealer {
    self = [super init];
    if (self) {
        _hand = [[NSMutableArray alloc] init];
        _total = 0;
        _isDealer = _isConcealed = isDealer;
    }
    return self;
}

- (int)total {
    return [self totalThroughCard:(int)self.hand.count-1];
}

- (void)dealFromDeck:(ANWDeck *)deck {
    for (int i=0; i<2; i++) {
        [self hitFromDeck:deck];
    }
}

- (void)hitFromDeck:(ANWDeck *)deck {
    if (deck.deck.count < 10) {
        [deck.deck removeAllObjects];
        [deck populateDeck];
        [deck shuffleDeck];
    }
    [self.hand addObject:[deck drawCard]];
//    self.total += [[self.hand lastObject] cardValue];
    [self printHand];
    [[ANWGameManager sharedGameManager] handChanged:self];
}

- (int)totalThroughCard:(int)cardNum {
    int total = 0;
    int tempVal;
    int numAces = 0;
    for (int i=0; i<=cardNum; i++) {
        tempVal = [(ANWCard *)self.hand[i] cardValue];
        if (tempVal == 1) {
            numAces++;
            tempVal = 11;
        }
        total += tempVal;
    }
    while (total > 21 && numAces > 0) {
        total -= 10;    // change 1 ace value from 11 to 1
        numAces--;
    }
    return total;
}

- (void)printHand {
    NSLog(@"%@", (self.isDealer) ? @"Dealer" : @"Player");
    NSLog(@"%@", self.description);
}

- (NSString *)description {
    NSMutableString *descriptionString = [[NSMutableString alloc] init];
    for (ANWCard *card in self.hand) {
        [descriptionString appendString:[NSString stringWithFormat:@"%@%@ ", card.rankString, card.suit]];
    }
    return [NSString stringWithString:descriptionString];
}



@end
