//
//  GameOver.m
//  PushPush
//
//  Created by Luke Solomon on 7/22/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameOver.h"
#import "GameState.h"

@implementation GameOver {
    CCLabelTTF *p1Label;
    CCLabelTTF *p2Label;
    
    CCLabelTTF *p1Label2;
    CCLabelTTF *p2Label2;
}

-(id) init {
    self = [super init];
    if (self) {

    }
    return self;
}


- (void) didLoadFromCCB {
    
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    
    p1Label.string = [NSString stringWithFormat: @"%ld", (long)[GameState sharedInstance].p1Score];
    p2Label.string = [NSString stringWithFormat: @"%ld", (long)[GameState sharedInstance].p2Score];
    
    if ([GameState sharedInstance].wInteger == 1) {
        
        p1Label2.string = @"YOU WON!";
        p2Label2.string = @"YOU LOST";
        
    } else if ([GameState sharedInstance].wInteger == 2) {
        p1Label2.string = @"YOU LOST";
        p2Label2.string = @"YOU WON!";
    }

}


- (void) endless {
    CCScene *endlessScene = [CCBReader loadAsScene:@"EndlessScene"];
    [[CCDirector sharedDirector] replaceScene:endlessScene];
}


- (void) main {
    CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}

@end
