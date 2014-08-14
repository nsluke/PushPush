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
    
    CCParticleSystem *p1Particle;
    CCParticleSystem *p2Particle;
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
    
    //load the scores from the singleton
    p1Label.string = [NSString stringWithFormat: @"%ld", (long)[GameState sharedInstance].p1Score];
    p2Label.string = [NSString stringWithFormat: @"%ld", (long)[GameState sharedInstance].p2Score];
    
    //load the particle system colors
    if ([GameState sharedInstance].wInteger == 1) {
        
        p1Label2.string = @"YOU WON!";
        p2Label2.string = @"YOU LOST";
        
        p1Particle.startColor = [GameState sharedInstance].p1Color;
        p1Particle.endColor = [GameState sharedInstance].p1Color;
        
    } else if ([GameState sharedInstance].wInteger == 2) {
        p1Label2.string = @"YOU LOST";
        p2Label2.string = @"YOU WON!";
        
        p2Particle.startColor = [GameState sharedInstance].p2Color;
        p2Particle.endColor = [GameState sharedInstance].p2Color;
    }
}


- (void) endless {
    [GameState sharedInstance].gameMode = 2;
    
    CCScene *o = [CCBReader loadAsScene:@"CountDownTimer2"];
    
    [[CCDirector sharedDirector] replaceScene:o];
}


- (void) main {
    CCScene *mainScene = [CCBReader loadAsScene:@"AnimatedMainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}

@end
