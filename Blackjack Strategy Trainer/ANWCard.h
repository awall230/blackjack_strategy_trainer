//
//  ANWCard.h
//  Blackjack Strategy Trainer
//
//  Created by Adam Waller on 8/26/15.
//  Copyright (c) 2015 Adam Waller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANWCard : NSObject

@property (nonatomic) int rank;     // Rank (1-13) Ace = 1
@property (nonatomic) int cardValue;    // Value (1-11)
@property (nonatomic, copy) NSString *suit; // String representation of suit
@property (nonatomic) int suitNumber;   // 0-3
@property (nonatomic, copy) NSString *rankString;

// Initializers
- (instancetype)initWithSuitNumber:(int)suitNumber AndRank:(int)rank;

@end
