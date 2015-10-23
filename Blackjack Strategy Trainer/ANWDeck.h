//
//  ANWDeck.h
//  Blackjack Strategy Trainer
//
//  Created by Adam Waller on 8/26/15.
//  Copyright (c) 2015 Adam Waller. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ANWCard;

@interface ANWDeck : NSObject

@property (nonatomic, strong) NSMutableArray *deck;

- (void)populateDeck;
- (void)shuffleDeck;
- (ANWCard *)drawCard;

- (void)printDeck;

@end
