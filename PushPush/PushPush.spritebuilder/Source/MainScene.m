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
    
    CCLOG(@"play button stop");
    
}








@end
