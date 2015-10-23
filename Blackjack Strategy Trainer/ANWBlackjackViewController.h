//
//  ANWBlackjackViewController.h
//  Blackjack Strategy Trainer
//
//  Created by Adam Waller on 8/26/15.
//  Copyright (c) 2015 Adam Waller. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ANWGameManager;
@class ANWHand;
@class ANWCard;

@interface ANWBlackjackViewController : UIViewController

@property (nonatomic, strong) UIImageView *backgroundView;

@property (nonatomic, strong) UIButton *hitButton;
@property (nonatomic, strong) UIButton *standButton;
@property (nonatomic, strong) UIButton *doubleButton;
@property (nonatomic, strong) UIButton *restartButton;
@property (nonatomic, strong) UILabel *playerHandText;  // TODO: delete
@property (nonatomic, strong) UILabel *dealerHandText;  // TODO: delete
@property (nonatomic, strong) UILabel *playerHandTotal;
@property (nonatomic, strong) UILabel *dealerHandTotal;
@property (nonatomic, strong) UILabel *playerBalanceLabel;

- (void)hitButtonPressed:(UIButton *)button;
- (void)standButtonPressed:(UIButton *)button;
- (void)doubleButtonPressed:(UIButton *)button;
- (void)restartButtonPressed:(UIButton *)button;

- (void)displayHand:(ANWHand *)hand;
- (void)clearHandDisplay;
//- (void)displayCard:(ANWCard *)card Position:(int)pos Dealer:(BOOL)dealer Concealed:(BOOL)concealed;

- (void)receivedHandChangedNotification:(NSNotification *)notification;

@end
