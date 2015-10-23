//
//  ANWHand.h
//  Blackjack Strategy Trainer
//
//  Created by Adam Waller on 8/26/15.
//  Copyright (c) 2015 Adam Waller. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ANWDeck;
@class ANWGameManager;

@interface ANWHand : NSObject

@property (nonatomic, strong) NSMutableArray *hand;
@property (nonatomic) BOOL isDealer;
@property (nonatomic) int total;
@property (nonatomic, weak) ANWGameManager *gameManager;
@property (nonatomic) BOOL isConcealed;

- (instancetype)initWithDealer:(BOOL)isDealer;

- (void)dealFromDeck:(ANWDeck *)deck;
- (void)hitFromDeck:(ANWDeck *)deck;

- (int)totalThroughCard:(int)cardNum;

- (void)printHand;

@end
