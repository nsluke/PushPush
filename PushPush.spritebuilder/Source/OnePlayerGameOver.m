//
//  OnePlayerGameOver.m
//  PushPush
//
//  Created by Luke Solomon on 8/18/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "OnePlayerGameOver.h"
#import "GameState.h"
#import "Mixpanel.h"

@implementation OnePlayerGameOver {
    
    CCLabelTTF *scoreLabel;
    CCLabelTTF *scoreLabel2;
    
}

- (void) didLoadFromCCB {
    
    scoreLabel.color = [GameState sharedInstance].p2Color;
    scoreLabel2.color = [GameState sharedInstance].p1Color;
    
    self.userInteractionEnabled = TRUE;
    
    NSNumber *previousHighScore = (NSNumber *)([[NSUserDefaults standardUserDefaults] objectForKey:@"onePlayerHighScore"]);
    NSLog(@"");
    if (previousHighScore.integerValue < [GameState sharedInstance].onePlayerHighScore) {
        scoreLabel.string = @"NEW HIGH SCORE!";
        [[NSUserDefaults standardUserDefaults] setObject: @([GameState sharedInstance].onePlayerHighScore) forKey:@"onePlayerHighScore"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        scoreLabel.string = @"Your score:";
    }
    

    
    //NSNumber *score = NSNum[[GameState sharedInstance].onePlayerHighScore];
    NSDictionary *scores = @{@"p1score": [NSNumber numberWithInteger:[GameState sharedInstance].onePlayerHighScore]};
    [[Mixpanel sharedInstance] track:@"Single Player Ended With Score" properties: scores];
}

- (void) playAgain {
    
    [GameState sharedInstance].gameMode = 1;
    CCScene *o = [CCBReader loadAsScene:@"CountDownTimer2"];
    [[CCDirector sharedDirector] replaceScene:o];
}

- (void) main {
    CCScene *mainScene = [CCBReader loadAsScene:@"AnimatedMainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}

@end
