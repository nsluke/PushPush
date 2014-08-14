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

@implementation CountDownTimer2


- (void) setCountDownTimerWithLabel:(int)x andAnimation:(NSString*)y {
    
    CountDownTimer2 *t = [[CountDownTimer2 alloc] init];

    [[t animationManager] runAnimationsForSequenceNamed:y];
    
}


- (void) removeFromParent {
    
    //[self removeFromParent];
    
    CCScene *endlessScene = [CCBReader loadAsScene:@"EndlessScene"];
    [[CCDirector sharedDirector] replaceScene:endlessScene];
    
}


@end