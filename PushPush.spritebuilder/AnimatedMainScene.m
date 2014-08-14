//
//  AnimatedMainScene.m
//  PushPush
//
//  Created by Luke Solomon on 8/5/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "AnimatedMainScene.h"
#import "GameState.h"
#import "AnimatedCharacterSelectScene.h"

@implementation AnimatedMainScene {
    
}

- (void) didLoadFromCCB {
    if ([GameState sharedInstance].p1Color == NULL) {
        [GameState sharedInstance].p1Color = [CCColor colorWithRed:255.0f/255.0f
                                                             green:255.0f/255.0f
                                                              blue:255.0f/255.0f
                                                             alpha:1.0f];;
    }
    
    if ([GameState sharedInstance].p2Color == NULL) {
        [GameState sharedInstance].p2Color = [CCColor colorWithRed:127.0f/255.0f
                                                             green:000.0f/255.0f
                                                              blue:127.0f/255.0f
                                                             alpha:1.0f];
    }
}

- (void) onePlayer {
    [GameState sharedInstance].gameMode = 1;
    CCScene *animatedCharSelectScene = [CCBReader loadAsScene:@"AnimatedCharacterSelectScene"];
    [[CCDirector sharedDirector] replaceScene:animatedCharSelectScene];
}


- (void) twoPlayer {
    [GameState sharedInstance].gameMode = 2;
    CCScene *o = [CCBReader loadAsScene:@"CountDownTimer2"];
    [[CCDirector sharedDirector] replaceScene:o];
}

- (void) TutorialPush {
    //[GameState sharedInstance].gameMode = 2;
    CCScene *TwoPlayerTutorialScene = [CCBReader loadAsScene:@"TutorialPartTwo"];
    [[CCDirector sharedDirector] replaceScene:TwoPlayerTutorialScene];
    
}

- (void) changeColors {
    [GameState sharedInstance].gameMode = 2;
    CCScene *animatedCharSelectScene = [CCBReader loadAsScene:@"AnimatedCharacterSelectScene"];
    [[CCDirector sharedDirector] replaceScene:animatedCharSelectScene];
}


@end