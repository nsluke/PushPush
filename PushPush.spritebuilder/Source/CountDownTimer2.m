//
//  CountDownTimer.m
//  PushPush
//
//  Created by Luke Solomon on 8/12/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CountDownTimer2.h"
#import "CCNode.h"
#import "CCScene.h"
#import "GameState.h"

@implementation CountDownTimer2 {
    
    CCSprite *P1Arrow;
    CCLabelTTF *P1Label;
    
    CCSprite *P2Arrow;
    CCLabelTTF *P2Label;
    
}

- (void) didLoadFromCCB {
    
    P1Arrow.color = [GameState sharedInstance].p1Color;
    P1Label.color = [GameState sharedInstance].p1Color;
    P2Arrow.color = [GameState sharedInstance].p2Color;
    P2Label.color = [GameState sharedInstance].p2Color;
    
    if ([GameState sharedInstance].gameMode == 1) {
        
        P1Arrow.visible = false;
        P1Label.string = @"Get Ready...";
        P2Arrow.visible = false;
        P2Label.visible = false;
        
    } else if ([GameState sharedInstance].gameMode == 2) {
        
        P1Arrow.visible = true;
        P1Label.string = @"Player 1";
        P2Arrow.visible = true;
        P1Label.string = @"Player 2";
        
    }
    
}


- (void) setCountDownTimerWithLabel:(int)x andAnimation:(NSString*)y {
    CountDownTimer2 *timer = [[CountDownTimer2 alloc] init];
    [[timer animationManager] runAnimationsForSequenceNamed:y];
    
}


- (void) removeFromParent {
    //[self removeFromParent];
    // access audio object
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    // play sound effect
    [audio playEffect:@"Randomize7.mp3"];
    
    if ([GameState sharedInstance].gameMode == 1) {
        CCScene *onePlayerScene = [CCBReader loadAsScene:@"OnePlayerScene"];
        [[CCDirector sharedDirector] replaceScene:onePlayerScene];
        
    } else if ([GameState sharedInstance].gameMode == 2) {
        CCScene *endlessScene = [CCBReader loadAsScene:@"EndlessScene"];
        [[CCDirector sharedDirector] replaceScene:endlessScene];
        
    }
    
    
    
}


@end