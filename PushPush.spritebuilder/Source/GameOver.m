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
    
    // access audio object
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    // play sound effect
    [audio playEffect:@"Randomize6.mp3"];
    
    p1Label.color = [GameState sharedInstance].p1Color;
    p1Label2.color = [GameState sharedInstance].p1Color;
    
    p2Label.color = [GameState sharedInstance].p2Color;
    p2Label2.color = [GameState sharedInstance].p2Color;
    
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
    
    /*
    NSNumber* player1score = [NSNumber numberWithInt:[GameState sharedInstance].p1Score];
    NSNumber* player2score = [NSNumber numberWithInt:[GameState sharedInstance].p2Score];
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys: player1score, @"P1score", player2score, @"P2score"];
    */
    
}


- (void) endless {
    
    [GameState sharedInstance].gameMode = 2;
    CCScene *countDown = [CCBReader loadAsScene:@"CountDownTimer2"];
    [[CCDirector sharedDirector] replaceScene:countDown];
}


- (void) main {
    CCScene *mainScene = [CCBReader loadAsScene:@"AnimatedMainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}

@end
