//
//  ANWGameManager.m
//  Blackjack Strategy Trainer
//
//  Created by Adam Waller on 8/28/15.
//  Copyright (c) 2015 Adam Waller. All rights reserved.
//

#import "ANWGameManager.h"
#import "ANWDeck.h"
#import "ANWHand.h"

@implementation ANWGameManager

static ANWGameManager *sharedManager = nil;

- (instancetype)init {
    self = [super init];
    if (self) {
        _playerBalance = 100;
    }
    return self;
}

+ (ANWGameManager *)sharedGameManager {
    if (sharedManager == nil) {
        sharedManager = [[self alloc] init];
    }
    return sharedManager;
}

- (void)startNewGame:(int)bet {
    if (self.deck == NULL) {
        self.deck = [[ANWDeck alloc] init];
        [self.deck shuffleDeck];
    }
    
    if (bet != 0) {
        self.playerBet = bet;
    }
    
    self.playerBalance -= self.playerBet;
    
    self.dealerHand = [[ANWHand alloc] initWithDealer:TRUE];
    self.playerHand = [[ANWHand alloc] initWithDealer:FALSE];
    
    [self.dealerHand dealFromDeck:self.deck];
    [self.playerHand dealFromDeck:self.deck];
    [self.dealerHand printHand];
    [self.playerHand printHand];
}

- (void)playDealer {
    self.dealerHand.isConcealed = FALSE;
    [self handChanged:self.dealerHand];
    while (self.dealerHand.total < 17) {
        [self.dealerHand hitFromDeck:self.deck];
        [self handChanged:self.dealerHand];
    }
    [self finishedGame];
}

- (void)finishedGame {
    if (self.playerHand.total > 21) {
        ;   // player busted, gets no money back
    }
    else if (self.dealerHand.total > 21) {
        self.playerBalance += 2*self.playerBet;   // dealer busted, pay out player
    }
    else if (self.playerHand.total > self.dealerHand.total) {
        self.playerBalance += 2*self.playerBet;   // player wins
    }
    else if (self.dealerHand.total > self.playerHand.total) {
        ;   // dealer wins, player gets nothing
    }
    else if (self.dealerHand.total == self.playerHand.total) {
        self.playerBalance += self.playerBet;   // push, player gets bet back;
    }
}

- (void)handChanged:(ANWHand *)hand {
    NSDictionary *dict = [NSDictionary dictionaryWithObject:hand forKey:@"hand"];
    // Fire a notification to controller
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HandChanged"
                                                        object:nil
                                                      userInfo:dict];
}


@end
