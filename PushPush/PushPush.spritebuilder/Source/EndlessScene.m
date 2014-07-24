//
//  EndlessScene.m
//  PushPush
//
//  Created by Luke Solomon on 7/17/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "EndlessScene.h"
#import "FormationHandler.h"

@implementation EndlessScene{

//color nodes
CCNodeColor *TopLeftLine;
CCNodeColor *TopMidLine;
CCNodeColor *TopRightLine;
CCNodeColor *BottomLeftLine;
CCNodeColor *BottomMidLine;
CCNodeColor *BottomRightLine;
//gradient color nodes
CCNodeGradient *MWD;
CCNodeGradient *RWD;
CCNodeGradient *LWD;

//particles
CCParticleSystem *PUM;
CCParticleSystem *PUL;
CCParticleSystem *PUR;

CCParticleSystem *PDM;
CCParticleSystem *PDR;
CCParticleSystem *PDL;

//ints
int yVal;
int pushaT;

//FormationHandler *BottomHandler;
//FormationHandler *TopHandler;

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
    self.userInteractionEnabled = TRUE;
    self.multipleTouchEnabled = TRUE;
}

// --------------------------------------------------------------------------------------------------------
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

// --------------------------------------------------------------------------------------------------------
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
    
    CCParticleSystem *hitMarkMiddle = (CCParticleSystem *)[CCBReader load:@"hitMarkMiddle"];
    hitMarkMiddle.autoRemoveOnFinish = TRUE;
    hitMarkMiddle.position = MWD.position;
    [BottomMidLine.parent addChild:hitMarkMiddle];
    [hitMarkMiddle removeFromParent];
    
    if (MWD.positionInPoints.y > SH) {
        [self victory];
    }
}

// --------------------------------------------------------------------------------------------------------
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
        [self victory2];
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
        [self victory2];
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

    
    //check for win
    if (MWD.positionInPoints.y < 0){
        [self victory2];
    }
}

// --------------------------------------------------------------------------------------------------------
#pragma mark Swiping

- (void) rightSwipe {
    CCLOG(@"player swiped right");
    //[BottomHandler rightPush];
}

- (void) leftSwipe {
    CCLOG(@"player swiped left");
}

- (void) doubleUpSwipe {
    CCLOG(@"player double swiped up");
}

- (void) doubleLeftRightSwipe {
    CCLOG(@"player doubleLeftRightSwipe");
}

- (void) downSwipe {
    CCLOG(@"player swiped down");
}

// --------------------------------------------------------------------------------------------------------
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

- (void) victory2 {
    
    CCScene *gameOver2 = [CCBReader loadAsScene:@"GameOver2"];
    [[CCDirector sharedDirector] replaceScene:gameOver2];
    
}


@end
