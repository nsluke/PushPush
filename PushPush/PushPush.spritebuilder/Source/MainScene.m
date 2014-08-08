//
//  Gameplay.h
//  PushPush
//
//  Created by Luke Solomon on 7/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "GameState.h"

@implementation MainScene {
    
}
- (void) didLoadFromCCB {
    //[GameState sharedInstance].colorsLoaded = false;
    //GameState *state = [[GameState alloc] init];
    //[[CCDirector sharedDirector] popScene];

}

- (void) animatedMainScene {
    
    CCLOG(@"animatedMainScene button pressed");
    
    CCScene *gameplayScene = [CCBReader loadAsScene:@"AnimatedMainScene"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
    
    CCLOG(@"animatedMainScene button stop");
    
}

- (void) Endless {
    
    CCLOG(@"endless button pressed");
    
    CCScene *endlessScene = [CCBReader loadAsScene:@"EndlessScene"];
    [[CCDirector sharedDirector] replaceScene:endlessScene];
    
    CCLOG(@"endless button stop");
    
}

- (void) Versus {
    
    CCLOG(@"versus button pressed");
    
    CCScene *charSelectScene = [CCBReader loadAsScene:@"CharacterSelectScene"];
    [[CCDirector sharedDirector] replaceScene:charSelectScene];
    
    CCLOG(@"versus button stop");
    
}




@end
