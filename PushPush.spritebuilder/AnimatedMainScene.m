//
//  AnimatedMainScene.m
//  PushPush
//
//  Created by Luke Solomon on 8/5/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "AnimatedMainScene.h"

@implementation AnimatedMainScene {
    
}

- (void) didLoadFromCCB {
    
    //[GameState sharedInstance].colorsLoaded = false;
    //GameState *state = [[GameState alloc] init];
    //[[CCDirector sharedDirector] popScene];
    
}

- (void) play {
    
    CCLOG(@"play button pressed");
    
    /*
    CCScene *gameplayScene = [CCBReader loadAsScene:@"OnePlayerScene"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
    */
    
    CCScene *animatedCharSelectScene = [CCBReader loadAsScene:@"AnimatedCharacterSelectScene"];
    [[CCDirector sharedDirector] replaceScene:animatedCharSelectScene];
    
    CCLOG(@"play button stop");
    
}


- (void) Versus {
    
    CCLOG(@"versus button pressed");
    
    CCScene *animatedCharSelectScene = [CCBReader loadAsScene:@"AnimatedCharacterSelectScene"];
    [[CCDirector sharedDirector] replaceScene:animatedCharSelectScene];
    
    CCLOG(@"versus button stop");
    
}

@end
