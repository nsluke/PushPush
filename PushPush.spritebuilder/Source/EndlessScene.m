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

    CCNode *o;
    
    //The container nodes
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
    
    //PushLabels
    CCLabelTTF *PushLabel;
    CCLabelTTF *PushLabel2;

    //ints
    int yVal;
    int validTouchCount;
    int BtmTouchCount;
    int TopTouchCount;
    int TOUCHACCEL;
        
    //BOOL
    BOOL PAUSED;
    
    //Button
    CCButton *PauseButton;
    CCButton *ResumeButton;
    
    //define the screen's height and width
    #define SW ([[CCDirector sharedDirector] viewSize].width)
    #define SH ([[CCDirector sharedDirector] viewSize].height)

}

-(id) init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void) didLoadFromCCB {
    yVal = 20;
    
    TOUCHACCEL = 1000;
    
    BtmTouchCount = 0;
    TopTouchCount = 0;
    
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    self.multipleTouchEnabled = TRUE;
    
    [self loadColors];
    
    // access audio object
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio preloadEffect:@"Blip_Select46.mp3"];
    
    ResumeButton.visible = FALSE;
}

- (void) loadColors {
    // ---------------------------------------------------------------------------------------------
    //this is the section where we load the colors!
    PushLabel.color = [GameState sharedInstance].p2Color;
    PushLabel2.color = [GameState sharedInstance].p1Color;

    
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
}


// -------------------------------------------------------------------------------------------------
#pragma mark Touch Input

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    CGPoint touchLocation = [touch locationInWorld];

    if (PAUSED == FALSE) {
        
        // access audio object
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        // play sound effect
        [audio playEffect:@"Blip_Select46.mp3"];
        
        if (touchLocation.y<SH/2) {
            BtmTouchCount++;
            if (BtmTouchCount <3) {
                
                if (touchLocation.x<SW/3){
                    //bottom left
                    [self moveThisLine:_Left thisFar:yVal];
                }
                else if (touchLocation.x>SW/1.5){
                    //bottom right
                    [self moveThisLine:_Right thisFar:yVal];
                }
                else if (touchLocation.x>SW/3 && touchLocation.x<SW/1.5){
                    //bottom middle
                    [self moveThisLine:_Middle thisFar:yVal];
                }
            }
        }//if
        else if (touchLocation.y>SH/2) {
            TopTouchCount++;
            if (TopTouchCount<3) {
                if (touchLocation.x<SW/3){
                    //top left
                    [self moveThisLine:_Left thisFar:-(yVal)];
                }
                else if (touchLocation.x>SW/1.5){
                    //top right
                    [self moveThisLine:_Right thisFar:-(yVal)];
                }
                // --------------------
                else if (touchLocation.x>SW/3 && touchLocation.x<SW/1.5){
                    //top middle
                    [self moveThisLine:_Middle thisFar:-(yVal)];
                }
            }
        }//else
    }//paused
}

-(void) touchCancelled:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    CGPoint touchLocation = [touch locationInWorld];
   // NSLog(@"touch cancelled");
   // NSLog(@"top Touch Count %i", TopTouchCount);
   // NSLog(@"btm Touch Count %i", BtmTouchCount);
    if (touchLocation.y <SH/2) {
        BtmTouchCount--;
    }
    else if (touchLocation.y>SH/2) {
        TopTouchCount--;
    }
}

-(void) touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    CGPoint touchLocation = [touch locationInWorld];
    //NSLog(@"touch ended");
    //NSLog(@"top Touch Count %i", TopTouchCount);
    //NSLog(@"btm Touch Count %i", BtmTouchCount);
    if (touchLocation.y <SH/2) {
        BtmTouchCount--;
    }
    else if (touchLocation.y>SH/2) {
        TopTouchCount--;
    }
}

- (void) moveThisLine: (CCNode*)LineMover thisFar: (int)dDist {
    
    if (LineMover == _Middle) {
        _Middle.positionInPoints = ccp (_Middle.positionInPoints.x, _Middle.positionInPoints.y + dDist);
//        [self hitmarked: _Middle indicator: dDist];

        [self victoryCheck: LineMover];
    }
    if (LineMover == _Right) {
        _Right.positionInPoints = ccp (_Right.positionInPoints.x, _Right.positionInPoints.y + dDist);
//        [self hitmarked: _Right indicator: dDist];
        [self victoryCheck: LineMover];
    }
    if (LineMover == _Left) {
        _Left.positionInPoints = ccp (_Left.positionInPoints.x, _Left.positionInPoints.y + dDist);
//        [self hitmarked: _Left indicator: dDist];
        [self victoryCheck: LineMover];
    }
    
}

// --------------------------------------------------------------------------------------
#pragma mark Hitmark

/*
//- (void) hitmarked: (CCNode*) whichLine indicator: (int) dDist {
//
//    NSLog(@"dDist = %d", dDist);
//
//    //hitMark.startColor = [GameState sharedInstance].p2Color;
//    //hitMark.endColor = [GameState sharedInstance].p2Color;
//    
//    // make the particle effect clean itself up, once it is completed
//    CCParticleSystem *hitMarkUp = (CCParticleSystem *)[CCBReader load:@"hitMarkMiddle"];
//    CCParticleSystem *hitMarkDown = (CCParticleSystem *)[CCBReader load:@"hitMarkUp"];
//    
//    hitMarkDown.startColor = [GameState sharedInstance].p2Color;
//    hitMarkDown.endColor = [GameState sharedInstance].p2Color;
//    hitMarkUp.startColor = [GameState sharedInstance].p1Color;
//    hitMarkUp.endColor = [GameState sharedInstance].p1Color;
//    
//    if (whichLine == _Middle) {
//        if (dDist > 0) {
//            [MWD addChild:hitMarkUp];
//            hitMarkUp.position = MWD.position;
//            hitMarkUp.autoRemoveOnFinish = TRUE;
//        }
//        else if (dDist < 0) {
//            [MWD addChild:hitMarkDown];
//            hitMarkDown.position = MWD.position;
//            hitMarkDown.autoRemoveOnFinish = TRUE;
//        }
//    }
//    if (whichLine == _Right) {
//        if (dDist > 0) {
//            [RWD addChild:hitMarkUp];
//            hitMarkUp.position = MWD.position;
//            hitMarkUp.autoRemoveOnFinish = TRUE;
//        }
//        else if (dDist < 0) {
//            [RWD addChild:hitMarkDown];
//            hitMarkDown.position = MWD.position;
//            hitMarkDown.autoRemoveOnFinish = TRUE;
//        }
//    }
//    if (whichLine == _Left) {
//        if (dDist > 0) {
//            [LWD addChild:hitMarkUp];
//            hitMarkDown.position = MWD.position;
//            hitMarkUp.autoRemoveOnFinish = TRUE;
//        }
//        else if (dDist < 0) {
//            [LWD addChild:hitMarkDown];
//            hitMarkDown.position = MWD.position;
//            hitMarkDown.autoRemoveOnFinish = TRUE;
//        }
//    }
//     
//    
//
*/

// --------------------------------------------------------------------------------------
#pragma mark buttons

- (void) pause {
    
    PAUSED = TRUE;
    
    [[CCDirector sharedDirector] pause];
    ResumeButton.visible = TRUE;
    PauseButton.visible = FALSE;

    
}

- (void) resume {
    
    PAUSED = FALSE;
    
    [[CCDirector sharedDirector] resume];
    ResumeButton.visible = FALSE;
    PauseButton.visible = TRUE;
    
}

- (void) victoryCheck: (CCNode*) windication {
    
    //Someone has won
    if (windication.positionInPoints.y > SH || windication.positionInPoints.y < 0)
    {
        //player one has won
        if (windication.positionInPoints.y > SH) {
            [GameState sharedInstance].wInteger = 1;
            [GameState sharedInstance].p1Score ++;
        }
        //player two has won
        else if (windication.positionInPoints.y < 0) {
            [GameState sharedInstance].wInteger = 2;
            [GameState sharedInstance].p2Score ++;
        }
        //load the gameover scene
        CCScene *gameOver = [CCBReader loadAsScene:@"GameOver"];
        [[CCDirector sharedDirector] replaceScene:gameOver];
    }
    
    
}



@end
