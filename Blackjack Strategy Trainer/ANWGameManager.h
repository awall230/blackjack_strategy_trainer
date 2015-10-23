//
//  ANWGameManager.h
//  Blackjack Strategy Trainer
//
//  Created by Adam Waller on 8/28/15.
//  Copyright (c) 2015 Adam Waller. All rights reserved.
//
// Singleton Class

#import <Foundation/Foundation.h>
@class ANWDeck;
@class ANWHand;

@interface ANWGameManager : NSObject

@property (nonatomic, strong) ANWDeck *deck;
@property (nonatomic, strong) ANWHand *dealerHand;
@property (nonatomic, strong) ANWHand *playerHand;
@property (nonatomic) int playerBalance;
@property (nonatomic) int playerBet;

+ (ANWGameManager *)sharedGameManager;

- (void)startNewGame:(int)bet;
- (void)playDealer;
- (void)finishedGame;

- (void)handChanged:(ANWHand *)hand;

@end
