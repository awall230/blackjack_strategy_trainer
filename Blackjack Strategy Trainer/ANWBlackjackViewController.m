//
//  ANWBlackjackViewController.m
//  Blackjack Strategy Trainer
//
//  Created by Adam Waller on 8/26/15.
//  Copyright (c) 2015 Adam Waller. All rights reserved.
//

#import "ANWBlackjackViewController.h"
#import "ANWBlackjackView.h"
#import "ANWGameManager.h"
#import "ANWHand.h"
#import "ANWCard.h"

@interface ANWBlackjackViewController ()

@end

@implementation ANWBlackjackViewController

- (void)loadView {
    CGRect frame = [UIScreen mainScreen].bounds;
    ANWBlackjackView *bjview = [[ANWBlackjackView alloc] initWithFrame:frame];
    bjview.backgroundColor = [UIColor colorWithRed:78/255.0
                                             green:127/255.0
                                              blue:71/255.0
                                             alpha:1.0];
    
    // Set as the view of this controller
    self.view = bjview;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set background image
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"table_background"]];
    [self.view addSubview:self.backgroundView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedHandChangedNotification:)
                                                 name:@"HandChanged"
                                               object:nil];
    
    ANWGameManager *gameManager = [ANWGameManager sharedGameManager];
    [gameManager startNewGame:10];
    
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    
    self.hitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.hitButton setTitle:@"Hit"
                       forState:UIControlStateNormal];
    
    self.hitButton.center = CGPointMake(width*0.15, height*0.9);
    [self.hitButton sizeToFit];
//    self.hitButton.frame = CGRectMake(width*0.1, height*0.105, width*0.4, height*0.04);
//    self.hitButton.layer.borderWidth = 1.5f;
//    [self.hitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    self.hitButton.backgroundColor = [UIColor whiteColor];
    
    // Add action for button press
    [self.hitButton addTarget:self
                          action:@selector(hitButtonPressed:)
                forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.hitButton];
    
    self.standButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.standButton setTitle:@"Stand"
                    forState:UIControlStateNormal];
    
    self.standButton.center = CGPointMake(width*0.7, height*0.9);
    [self.standButton sizeToFit];
    
    [self.standButton addTarget:self
                         action:@selector(standButtonPressed:)
               forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.standButton];
    
    self.doubleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.doubleButton setTitle:@"Double"
                      forState:UIControlStateNormal];
    
    self.doubleButton.center = CGPointMake(width*0.4, height*0.9);
    [self.doubleButton sizeToFit];
    
    [self.doubleButton addTarget:self
                         action:@selector(doubleButtonPressed:)
               forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.doubleButton];
    
    self.restartButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.restartButton setTitle:@"New Game" forState:UIControlStateNormal];
    
    self.restartButton.center = CGPointMake(width*0.5, height*0.8);
    [self.restartButton sizeToFit];
    
    [self.restartButton addTarget:self
                           action:@selector(restartButtonPressed:)
                 forControlEvents:UIControlEventTouchUpInside];
    
    self.restartButton.hidden = YES;
    
    [self.view addSubview:self.restartButton];
    
    self.playerHandTotal = [[UILabel alloc] init];
    self.playerHandTotal.frame = CGRectMake(width*0.15, height*0.65, width*0.3, height*0.1);
    self.playerHandTotal.text = [NSString stringWithFormat:@"%d", gameManager.playerHand.total];
    self.playerHandTotal.textColor = [UIColor whiteColor];
    [self.view addSubview:self.playerHandTotal];
    
    self.dealerHandTotal = [[UILabel alloc] init];
    self.dealerHandTotal.text = [NSString stringWithFormat:@"%d", [gameManager.dealerHand totalThroughCard:0]];
    self.dealerHandTotal.frame = CGRectMake(width*0.15, height*0.1, width*0.3, height*0.1);
    self.dealerHandTotal.textColor = [UIColor whiteColor];
    [self.view addSubview:self.dealerHandTotal];
    
    self.playerBalanceLabel = [[UILabel alloc] init];
    self.playerBalanceLabel.text = [NSString stringWithFormat:@"%d", gameManager.playerBalance];
    self.playerBalanceLabel.frame = CGRectMake(width*0.3, height*0.1, width*0.1, height*0.5);
    self.playerBalanceLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.playerBalanceLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)hitButtonPressed:(UIButton *)button {
    ANWGameManager *gameManager = [ANWGameManager sharedGameManager];
    [gameManager.playerHand hitFromDeck:gameManager.deck];
    self.doubleButton.hidden = YES;
}

- (void)standButtonPressed:(UIButton *)button {
    NSLog(@"pressed");
    self.hitButton.hidden = YES;
    self.standButton.hidden = YES;
    self.doubleButton.hidden = YES;
    [[ANWGameManager sharedGameManager] playDealer];
}

- (void)doubleButtonPressed:(UIButton *)button {
    ANWGameManager *gameManager = [ANWGameManager sharedGameManager];
    gameManager.playerBalance -= gameManager.playerBet;
    self.playerBalanceLabel.text = [NSString stringWithFormat:@"%d", [ANWGameManager sharedGameManager].playerBalance];
    gameManager.playerBet *= 2;
    
    [self hitButtonPressed:nil];
    [self standButtonPressed:nil];
}

- (void)restartButtonPressed:(UIButton *)button {
    [self clearHandDisplay];
    self.restartButton.hidden = YES;
    self.hitButton.hidden = NO;
    self.standButton.hidden = NO;
    self.doubleButton.hidden = NO;
    [[ANWGameManager sharedGameManager] startNewGame:10];
    self.playerBalanceLabel.text = [NSString stringWithFormat:@"%d", [ANWGameManager sharedGameManager].playerBalance];
}

- (void)displayHand:(ANWHand *)hand {
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    int i = (int)hand.hand.count-1;
    NSLog(@"Dealer:%s, i=%d", hand.isDealer ? "true" : "false", i);
    ANWCard *card = hand.hand[i];
    UIImage *cardImage;
    if (i==1 && hand.isConcealed) {
        cardImage = [UIImage imageNamed:@"cardBack.png"];
    }
    else {
        cardImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", card.description]];
    }
    UIImageView *cardView = [[UIImageView alloc] initWithImage:cardImage];
    CGRect arect = CGRectMake(width*0.3 + i*width*0.08, (hand.isDealer) ? height*0.1 : height*0.6,
                              223/3.0, 312/3.0);
    cardView.frame = arect;
    cardView.tag = 100; // for identifying as a card
    [self.view addSubview:cardView];
    cardView.alpha = 0.0;
    NSLog(@"%lu", (unsigned long)self.view.subviews.count);
    if (hand.isDealer && !(hand.isConcealed) && i>0) {
        [UIView animateWithDuration:0.2
                              delay:0.5*(i-1)
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             cardView.alpha = 1.0;
                         }
                         completion:^ (BOOL finished) {
                             if (finished) {
                                 self.dealerHandTotal.text = [NSString stringWithFormat:@"%d",
                                                              [hand totalThroughCard:i]];
                                 if ([hand totalThroughCard:i] >= 17) {
                                     self.restartButton.hidden = NO;
                                     self.playerBalanceLabel.text = [NSString stringWithFormat:@"%d",
                                                                    [ANWGameManager sharedGameManager].playerBalance];
                                 }
                             }
                         }];
    }
    else {
        cardView.alpha = 1.0;
        if (hand.isDealer) {
            self.dealerHandTotal.text = [NSString stringWithFormat:@"%d", [hand totalThroughCard:0]];
        }
        else {
            self.playerHandTotal.text = [NSString stringWithFormat:@"%d", hand.total];
        }
    }
}

- (void)clearHandDisplay {
    for (UIView *view in self.view.subviews) {
        if (view.tag == 100) {    // card image
            [view removeFromSuperview];
        }
    }
}

- (void)receivedHandChangedNotification:(NSNotification *)notification {
    ANWGameManager *gameManager = [ANWGameManager sharedGameManager];
    NSDictionary *dict = notification.userInfo;
    ANWHand *hand = [dict objectForKey:@"hand"];
    if (hand.isDealer) {
        [self displayHand:gameManager.dealerHand];
    }
    else {
        [self displayHand:gameManager.playerHand];
        if (gameManager.playerHand.total > 21) {    // player busted
            self.hitButton.hidden = YES;
            self.standButton.hidden = YES;
            self.doubleButton.hidden = YES;
            [gameManager playDealer];
        }
    }
}

@end
