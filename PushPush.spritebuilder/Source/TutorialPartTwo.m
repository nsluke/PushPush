//
//  TutorialPartTwo.m
//  PushPush
//
//  Created by Luke Solomon on 8/11/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "TutorialPartTwo.h"

@implementation TutorialPartTwo {
    
    CCNode *_Left;
    CCNode *_Middle;
    CCNode *_Right;
    
    int BtmTouchCount;
    int yVal;

    #define SW ([[CCDirector sharedDirector] viewSize].width)
    #define SH ([[CCDirector sharedDirector] viewSize].height)
}

-(void) didLoadFromCCB {
    
    self.userInteractionEnabled = TRUE;
    
}

- (void) touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent
 *)event {
    
    CCScene *EndlessScene = [CCBReader loadAsScene:@"OnePlayerScene"];
    [[CCDirector sharedDirector] replaceScene:EndlessScene];
    
}

- (void) pause {
    
    CCScene *mainScene = [CCBReader loadAsScene:@"AnimatedMainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
    
}

@end
