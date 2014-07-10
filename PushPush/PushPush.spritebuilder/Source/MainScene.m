//
//  Gameplay.h
//  PushPush
//
//  Created by Luke Solomon on 7/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "MainScene.h"

@implementation MainScene {
}


- (void) play {
    CCLOG(@"play button pressed");
    
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}



/**
 Need to create seperate methods for each push button?
 Taps only register if touched in the right order? ie, left, right, left, right?
 
 Start thinking about swipe handling
 
 
 */




@end
