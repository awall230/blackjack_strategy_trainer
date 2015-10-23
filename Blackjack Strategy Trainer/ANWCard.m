//
//  ANWCard.m
//  Blackjack Strategy Trainer
//
//  Created by Adam Waller on 8/26/15.
//  Copyright (c) 2015 Adam Waller. All rights reserved.
//

#import "ANWCard.h"

@implementation ANWCard

// Initializers
- (instancetype)initWithSuitNumber:(int)suitNumber AndRank:(int)rank {
    self = [super init];
    if (self) {
        _suitNumber = suitNumber;
        _rank = rank;
    }
    
    return self;
}

// Getters

// Sets suit string whenever suit number changes
- (NSString *)suit {
    switch (self.suitNumber) {
        case 0:
            return @"c";
            break;
        case 1:
            return @"d";
            break;
        case 2:
            return @"h";
            break;
        case 3:
            return @"s";
            break;
            
        default:
            return @"invalid";
            break;
    }
}

// Sets rank string to 2-10, J, Q, K, A
- (NSString *)rankString {
    if (self.rank == 1)
        return @"a";
    else if (self.rank <= 10)
        return [NSString stringWithFormat:@"%d", self.rank];
    else {
        switch (self.rank) {
            case 11:
                return @"j";
                break;
            case 12:
                return @"q";
                break;
            case 13:
                return @"k";
                break;
                
            default:
                return @"invalid";
                break;
        }
    }
}


// Returns value based on rank
// TODO: Make it so Ace can be 1 or 11 (right now defaults to 1)
- (int)cardValue {
    if (self.rank <= 0) {
        return -1;  // invalid rank
    }

    return (self.rank < 10) ? self.rank : 10; // all non-ace face cards have same value
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@%@", self.rankString, self.suit];
}

@end
