//
//  OnePlayerGameOver.m
//  PushPush
//
//  Created by Luke Solomon on 8/18/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "OnePlayerGameOver.h"
#import "GameState.h"

@implementation OnePlayerGameOver {
    
}




- (void) didLoadFromCCB {
    
    self.userInteractionEnabled = TRUE;
    
    
    
}


- (void) playAgain {
    [MGWU logEvent:@"played again"];
    
    [GameState sharedInstance].gameMode = 2;
    
    CCScene *o = [CCBReader loadAsScene:@"CountDownTimer2"];
    [[CCDirector sharedDirector] replaceScene:o];
}


- (void) main {
    CCScene *mainScene = [CCBReader loadAsScene:@"AnimatedMainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}


@end
