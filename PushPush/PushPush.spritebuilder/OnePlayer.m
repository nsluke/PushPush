//
//  OnePlayer.m
//  PushPush
//
//  Created by Luke Solomon on 7/29/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//
#import "GameState.h"
#import "OnePlayer.h"

@implementation OnePlayer {

//color nodes
CCNodeColor *TopLeftLine;
CCNodeColor *TopMidLine;
CCNodeColor *TopRightLine;
CCNodeColor *BottomLeftLine;
CCNodeColor *BottomMidLine;
CCNodeColor *BottomRightLine;
//gradient color nodes (windicators)
CCNodeGradient *MWD;
CCNodeGradient *RWD;
CCNodeGradient *LWD;

//particles
//upper particles
CCParticleSystem *PUM;
CCParticleSystem *PUL;
CCParticleSystem *PUR;
//lower particles
CCParticleSystem *PDM;
CCParticleSystem *PDR;
CCParticleSystem *PDL;
//corner particles
CCParticleSystem *BRP;
CCParticleSystem *BLP;
CCParticleSystem *TRP;
CCParticleSystem *TLP;

//ints
int yVal;
int pushaT;

#define SW [[CCDirector sharedDirector] viewSize].width
#define SH [[CCDirector sharedDirector] viewSize].height

}

-(id) init {
    self = [super init];
    if (self) {
    }
    return self;
}


- (void) didLoadFromCCB {
    yVal = 20;
    
    // tell this scene to accept touches
    self.multipleTouchEnabled = TRUE;
    
    [self loadColors];
    
}

- (void) loadColors {
    // ---------------------------------------------------------------------------
    //this is the section where we load the colors!
    //color nodes
    TopLeftLine.color = [GameState sharedInstance].p2Color;
    TopMidLine.color = [GameState sharedInstance].p2Color;
    TopRightLine.color = [GameState sharedInstance].p2Color;
    BottomLeftLine.color = [GameState sharedInstance].p1Color;
    BottomMidLine.color = [GameState sharedInstance].p1Color;
    BottomRightLine.color = [GameState sharedInstance].p1Color;
    
    //gradient color nodes (windicators)
    MWD.startColor = [GameState sharedInstance].p1Color;
    RWD.startColor = [GameState sharedInstance].p1Color;
    LWD.startColor = [GameState sharedInstance].p1Color;
    MWD.endColor = [GameState sharedInstance].p2Color;
    RWD.endColor = [GameState sharedInstance].p2Color;
    LWD.endColor = [GameState sharedInstance].p2Color;
    
    //particles
    //upper particles
    PUM.startColor = [GameState sharedInstance].p1Color;
    PUL.startColor = [GameState sharedInstance].p1Color;
    PUR.startColor = [GameState sharedInstance].p1Color;
    PUM.endColor = [GameState sharedInstance].p1Color;
    PUL.endColor = [GameState sharedInstance].p1Color;
    PUR.endColor = [GameState sharedInstance].p1Color;
    //lower particles
    PDM.startColor = [GameState sharedInstance].p2Color;
    PDR.startColor = [GameState sharedInstance].p2Color;
    PDL.startColor = [GameState sharedInstance].p2Color;
    PDM.endColor = [GameState sharedInstance].p2Color;
    PDR.endColor = [GameState sharedInstance].p2Color;
    PDL.endColor = [GameState sharedInstance].p2Color;
    
    //corner particles
    BRP.startColor = [GameState sharedInstance].p2Color;
    BLP.startColor = [GameState sharedInstance].p2Color;
    BRP.endColor = [GameState sharedInstance].p2Color;
    BLP.endColor = [GameState sharedInstance].p2Color;
    
    TRP.startColor = [GameState sharedInstance].p1Color;
    TLP.startColor = [GameState sharedInstance].p1Color;
    TRP.endColor = [GameState sharedInstance].p1Color;
    TLP.endColor = [GameState sharedInstance].p1Color;
    
    //[GameState sharedInstance].colorsLoaded = true;
}


// -------------------------------------------------------------------------------
#pragma mark Touch Input

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    CGPoint touchLocation = [touch locationInWorld];
    
    // --- bottom lines ---
    if (touchLocation.x<SW/3 && touchLocation.y<SH/2){
        //bottom left
        [self moveBottomLeftLine:yVal];
    }
    else if (touchLocation.x>SW/1.5 && touchLocation.y<SH/2){
        //bottom right
        [self moveBottomRightLine:yVal];
    }
    else if (touchLocation.x>SW/3 &&
             touchLocation.x<SW/1.5 &&
             touchLocation.y<SH/2){
        //bottom middle
        [self moveBottomLine:yVal];
    }
    // --------------------
    
    // ---- top lines ----
    else if (touchLocation.x<SW/3 && touchLocation.y>SH/2){
        //top left
        [self moveTopLeftLine:yVal];
    }
    else if (touchLocation.x>SW/1.5 && touchLocation.y>SH/2){
        //top right
        [self moveTopRightLine:yVal];
    }
    else if (touchLocation.x>SW/3 &&
             touchLocation.x<SW/1.5 &&
             touchLocation.y>SH/2){
        //top middle
        [self moveTopLine:yVal];
    }
    // --------------------
    
}

// -------------------------------------------------------------------------------
#pragma mark moving the bottom lines

- (void) moveBottomRightLine: (int) dDist {
    //Right Lines
    BottomRightLine.positionInPoints = ccp(BottomRightLine.positionInPoints.x, BottomRightLine.positionInPoints.y + dDist);
    TopRightLine.positionInPoints = ccp(TopRightLine.positionInPoints.x, TopRightLine.positionInPoints.y + dDist);
    
    //Move the Windicator
    RWD.positionInPoints = ccp(RWD.positionInPoints.x, RWD.positionInPoints.y + dDist);
    
    //Move the Particle Systems
    PDR.positionInPoints = ccp(PDR.positionInPoints.x, PDR.positionInPoints.y + dDist);
    PUR.positionInPoints = ccp(PUR.positionInPoints.x, PUR.positionInPoints.y + dDist);
    
    
    if (RWD.positionInPoints.y > SH) {
        
        [GameState sharedInstance].wInteger = 1;
        [GameState sharedInstance].p1Score ++;
        
        [self victory];
    }
}

- (void) moveBottomLeftLine: (int) dDist {
    //Left Lines
    BottomLeftLine.positionInPoints = ccp(BottomLeftLine.positionInPoints.x, BottomLeftLine.positionInPoints.y + dDist);
    TopLeftLine.positionInPoints = ccp(TopLeftLine.positionInPoints.x, TopLeftLine.positionInPoints.y + dDist);
    
    //Move the Windicator
    LWD.positionInPoints = ccp(LWD.positionInPoints.x, LWD.positionInPoints.y + dDist);
    
    //Move the Particle Systems
    PDL.positionInPoints = ccp(PDL.positionInPoints.x, PDL.positionInPoints.y + dDist);
    PUL.positionInPoints = ccp(PUL.positionInPoints.x, PUL.positionInPoints.y + dDist);
    
    
    if (LWD.positionInPoints.y > SH) {
        
        [GameState sharedInstance].wInteger = 1;
        [GameState sharedInstance].p1Score ++;
        
        [self victory];
    }
}

- (void) moveBottomLine: (int) dDist {
    //Middle Lines
    BottomMidLine.positionInPoints = ccp(BottomMidLine.positionInPoints.x, BottomMidLine.positionInPoints.y + dDist);
    TopMidLine.positionInPoints = ccp(TopMidLine.positionInPoints.x, TopMidLine.positionInPoints.y + dDist);
    
    //Move the Windicator
    MWD.positionInPoints = ccp(MWD.positionInPoints.x, MWD.positionInPoints.y + dDist);
    
    //Move the Particle Systems
    PDM.positionInPoints = ccp(PDM.positionInPoints.x, PDM.positionInPoints.y + dDist);
    PUM.positionInPoints = ccp(PUM.positionInPoints.x, PUM.positionInPoints.y + dDist);
    
    if (MWD.positionInPoints.y > SH) {
        
        [GameState sharedInstance].wInteger = 1;
        [GameState sharedInstance].p1Score ++;
        
        [self victory];
    }
}

// -------------------------------------------------------------------------------
#pragma mark moving the top lines


- (void) moveTopRightLine: (int) dDist {
    //Right Lines
    TopRightLine.positionInPoints = ccp(TopRightLine.positionInPoints.x, TopRightLine.positionInPoints.y - dDist);
    BottomRightLine.positionInPoints = ccp(BottomRightLine.positionInPoints.x, BottomRightLine.positionInPoints.y - dDist);
    
    //Move the Windicator
    RWD.positionInPoints = ccp(RWD.positionInPoints.x, RWD.positionInPoints.y - dDist);
    
    //Move the Particle Systems
    PDR.positionInPoints = ccp(PDR.positionInPoints.x, PDR.positionInPoints.y - dDist);
    PUR.positionInPoints = ccp(PUR.positionInPoints.x, PUR.positionInPoints.y - dDist);
    
    if (RWD.positionInPoints.y < 0){
        
        [GameState sharedInstance].wInteger = 2;
        [GameState sharedInstance].p2Score ++;
        
        [self victory];
    }
}

- (void) moveTopLeftLine: (int) dDist {
    //Left Lines
    TopLeftLine.positionInPoints = ccp(TopLeftLine.positionInPoints.x, TopLeftLine.positionInPoints.y - dDist);
    BottomLeftLine.positionInPoints = ccp(BottomLeftLine.positionInPoints.x, BottomLeftLine.positionInPoints.y - dDist);
    
    //Move the Windicator
    LWD.positionInPoints = ccp(LWD.positionInPoints.x, LWD.positionInPoints.y - dDist);
    
    //Move the Particle Systems
    PDL.positionInPoints = ccp(PDL.positionInPoints.x, PDL.positionInPoints.y - dDist);
    PUL.positionInPoints = ccp(PUL.positionInPoints.x, PUL.positionInPoints.y - dDist);
    
    if (LWD.positionInPoints.y < 0){
        
        [GameState sharedInstance].wInteger = 2;
        [GameState sharedInstance].p2Score ++;
        
        [self victory];
    }
}

- (void) moveTopLine: (int) dDist {
    //Middle Lines
    TopMidLine.positionInPoints = ccp(TopMidLine.positionInPoints.x, TopMidLine.positionInPoints.y - dDist);
    BottomMidLine.positionInPoints = ccp(BottomMidLine.positionInPoints.x, BottomMidLine.positionInPoints.y - dDist);
    
    
    //Move the Windicator
    MWD.positionInPoints = ccp(MWD.positionInPoints.x, MWD.positionInPoints.y - dDist);
    
    //Move the Particle Systems
    PDM.positionInPoints = ccp(PDM.positionInPoints.x, PDM.positionInPoints.y - dDist);
    PUM.positionInPoints = ccp(PUM.positionInPoints.x, PUM.positionInPoints.y - dDist);
    
    //hitmarking
    //[self hitmarked];
    
    //check for win
    if (MWD.positionInPoints.y < 0){
        
        [GameState sharedInstance].wInteger = 2;
        [GameState sharedInstance].p2Score ++;
        
        [self victory];
    }
}

// -------------------------------------------------------------------------------
#pragma mark Hitmark

/*
 - (void) hitmarked {
 // load particle effect
 CCParticleSystem *hitMark = (CCParticleSystem *)[CCBReader load:@"hitMarkMiddle"];
 
 // make the particle effect clean itself up, once it is completed
 hitMark.autoRemoveOnFinish = TRUE;
 
 // place the particle effect on the MWD position
 hitMark.position = MWD.position;
 
 // add the particle effect to the same node the seal is on
 [MWD addChild:hitMark];
 
 }
 */

// -------------------------------------------------------------------------------
#pragma mark AI

- (void) enemyColors {
    //
    
    
    
    
    
}


// -------------------------------------------------------------------------------
#pragma mark Pause button

- (void) pause {
    CCLOG(@"pause");
    
    CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
    
}

- (void) victory {
    
    CCScene *gameOver = [CCBReader loadAsScene:@"GameOver"];
    [[CCDirector sharedDirector] replaceScene:gameOver];
    
}

@end
