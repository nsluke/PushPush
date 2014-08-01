//
//  EndlessScene.m
//  PushPush
//
//  Created by Luke Solomon on 7/17/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "EndlessScene.h"
#import "GameState.h"

@implementation EndlessScene {

//The test node
CCNode *_Middle;
CCNode *_Right;
CCNode *_Left;

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
    
#define SW ([[CCDirector sharedDirector] viewSize].width)
#define SH ([[CCDirector sharedDirector] viewSize].height)

}

-(id) init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)dealloc {
    [TopLeftLine removeFromParent];
}


- (void) didLoadFromCCB {
    yVal = 20;
    
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    self.multipleTouchEnabled = TRUE;
    
    [self loadColors];
    
}

- (void) loadColors {
    // -----------------------------------------------------------------------------------------------------
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


// --------------------------------------------------------------------------------------------------------
#pragma mark Touch Input
/*
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
*/

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    CGPoint touchLocation = [touch locationInWorld];
    
    // --- bottom lines ---
    if (touchLocation.x<SW/3 &&
        touchLocation.y<SH/2){
        
        //bottom left
        [self moveThisLine:_Left thisFar:yVal];
        
    }
    
    else if (touchLocation.x>SW/1.5 &&
             touchLocation.y<SH/2){
        
        //bottom right
        [self moveThisLine:_Right thisFar:yVal];
        
    }
    
    else if (touchLocation.x>SW/3 &&
             touchLocation.x<SW/1.5 &&
             touchLocation.y<SH/2){
        
        //bottom middle
        [self moveThisLine:_Middle thisFar:yVal];
        
    }
    // --------------------
    
    // ---- top lines ----
    
    else if (touchLocation.x<SW/3 &&
             touchLocation.y>SH/2){
        
        //top left
        [self moveThisLine:_Left thisFar:-(yVal)];
        
    }
    else if (touchLocation.x>SW/1.5 &&
             touchLocation.y>SH/2){
        
        //top right
        [self moveThisLine:_Right thisFar:-(yVal)];
        
    }
    // --------------------
    else if (touchLocation.x>SW/3 &&
             touchLocation.x<SW/1.5 &&
             touchLocation.y>SH/2){
        
        //top middle
        [self moveThisLine:_Middle thisFar:-(yVal)];
    }
    // --------------------
}

- (void) moveThisLine: (CCNode*)LineMover thisFar: (int)dDist {
    
    if (LineMover == _Middle) {
        _Middle.positionInPoints = ccp (_Middle.positionInPoints.x, _Middle.positionInPoints.y + dDist);
        
        [self victoryCheck: LineMover];
    }
    if (LineMover == _Right) {
        _Right.positionInPoints = ccp (_Right.positionInPoints.x, _Right.positionInPoints.y + dDist);
        [self victoryCheck: LineMover];
    }
    if (LineMover == _Left) {
        _Left.positionInPoints = ccp (_Left.positionInPoints.x, _Left.positionInPoints.y + dDist);
        [self victoryCheck: LineMover];
    }
    
}

// --------------------------------------------------------------------------------------------------------
#pragma mark Hitmark

/*
- (void) hitmarked {
    // load particle effect
    CCParticleSystem *hitMark = (CCParticleSystem *)[CCBReader load:@"hitMarkMiddle"];
    
    // make the particle effect clean itself up, once it is completed
    hitMark.autoRemoveOnFinish = TRUE;
    
    // place the particle effect on the middle position
    hitMark.position = _Middle.position;
    
    // add the particle effect to the same node the Middle is on
    [MWD addChild:hitMark];
    
}
*/

// --------------------------------------------------------------------------------------------------------
#pragma mark Pause button

- (void) pause {
    
    CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
    
}

- (void) victoryCheck: (CCNode*) windication {
    
    NSLog (@"position in y %f + SH %f ", windication.positionInPoints.y, SH);

    if (windication.positionInPoints.y > SH || windication.positionInPoints.y < 0)
    {
        
        if (windication.positionInPoints.y > SH)
        {
            [GameState sharedInstance].wInteger = 1;
            [GameState sharedInstance].p1Score ++;
        }
        else if (windication.positionInPoints.y < 0)
        {
            [GameState sharedInstance].wInteger = 2;
            [GameState sharedInstance].p2Score ++;
        }
        CCScene *gameOver = [CCBReader loadAsScene:@"GameOver"];
        [[CCDirector sharedDirector] replaceScene:gameOver];
    }
    
    
}



@end
