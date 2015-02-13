//
//  OnePlayerScene.m
//  PushPush
//
//  Created by Luke Solomon on 8/6/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "OnePlayerScene.h"
#import "GameState.h"

@implementation OnePlayerScene {
    
    //score label
    CCLabelTTF *ScoreLabel;
    
    //timer
    CCTimer *_timer;
    
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
    
    //ints
    int yVal;
    int validTouchCount;
    int BtmTouchCount;
    int TopTouchCount;
    int TOUCHACCEL;
    int _Score;
    
    //BOOL
    BOOL touchIsValid;
    BOOL lineIsLocked;
    BOOL PAUSED;
    
    //buttons
    CCButton *PauseButton;
    CCButton *ResumeButton;
    
    //define the screen's height and width
#define SW ([[CCDirector sharedDirector] viewSize].width)
#define SH ([[CCDirector sharedDirector] viewSize].height)
    
}

-(id) init {
    self = [super init];
    
    if (self) {
        //_timer = [[CCTimer alloc] init];
    }
    
    return self;
}

- (void) didLoadFromCCB {
    
    yVal = 20;
    
    BtmTouchCount = 0;
    //TopTouchCount = 0;
    
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    self.multipleTouchEnabled = TRUE;
    
    [self loadColors];
    
    
    //[[CCDirector sharedDirector] performSelector:([self update:1 delta]) withObject:(nil) afterDelay:(.5)];
    //[[CCDirector sharedDirector] performSelector:@selector(fixedUpdate:) withObject:nil afterDelay:.9f];

    // access audio object
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio preloadEffect:@"Blip_Select46.mp3"];
    
    ResumeButton.visible = FALSE;
    
    [GameState sharedInstance].onePlayerHighScore = 0;
    //int _Score = 0;
    
    [self schedule:@selector(step) interval:(0.3)];
    
}

-(void) step {
    
    /*
    int cSwitcher = 0;
    switch (cSwitcher) {
        case 0:
            [self moveThisLine:_Left thisFar:-(yVal)];
            [self moveThisLine:_Right thisFar:-(yVal)];
            break;
        case 1:
            [self moveThisLine:_Right thisFar:-(yVal)];
            [self moveThisLine:_Middle thisFar:-(yVal)];
            break;
        case 2:
            [self moveThisLine:_Left thisFar:-(yVal)];
            [self moveThisLine:_Middle thisFar:-(yVal)];
        default:
            break;
    }
    */
    
    [GameState sharedInstance].onePlayerHighScore++;
    //_Score++;
    
    ScoreLabel.string = [NSString stringWithFormat: @"%ld", (long)[GameState sharedInstance].onePlayerHighScore];
    
    /*
    if (_Score == 10){
        yVal = 100;
    } else if (_Score == 20){
        yVal = 150;
    } else if (_Score == 30){
        yVal = 200;
    } else if (_Score == 40){
        yVal = 110;
    } else if (_Score == 50){
        yVal = 130;
    } else if (_Score == 60){
        yVal = 150;
    } else if (_Score == 70){
        yVal = 170;
    } else if (_Score == 80){
        yVal = 190;
    } else if (_Score == 90){
        yVal = 210;
    }
    
    */
    
    [self moveThisLine:_Left thisFar:-(yVal)];
    [self moveThisLine:_Right thisFar:-(yVal)];
    [self moveThisLine:_Middle thisFar:-(yVal)];
}

- (void) loadColors {
    // ---------------------------------------------------------------------------------------------
    //this is the section where we load the colors!
    
    ScoreLabel.color = [GameState sharedInstance].p1Color;
    
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
        
        if (touchLocation.y < SH/2) {
            
            BtmTouchCount++;
            
            // access audio object
            OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
            [audio playEffect:@"Blip_Select46.mp3"];
            
            //ensure that there are no more than 2 touches on the screen at a time
            if (BtmTouchCount < 3) {
                
                //bottom left
                if (touchLocation.x<SW/3 && _Left.positionInPoints.y < SH) {
                    
                    [self moveThisLine:_Left thisFar:yVal];
                }
                
                //bottom right
                else if (touchLocation.x>SW/1.5 && _Right.positionInPoints.y < SH) {
                    
                    [self moveThisLine:_Right thisFar:yVal];
                }
                
                //bottom middle
                else if (touchLocation.x>SW/3 && touchLocation.x<SW/1.5 && _Middle.positionInPoints.y < SH) {
                    
                    [self moveThisLine:_Middle thisFar:yVal];
                }
            }
        }
    }
}




-(void) touchCancelled:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    CGPoint touchLocation = [touch locationInWorld];
    //NSLog(@"touch cancelled");
    //NSLog(@"btm Touch Count %i", BtmTouchCount);
    if (touchLocation.y <SH/2) {
        BtmTouchCount--;
    }
}

-(void) touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    CGPoint touchLocation = [touch locationInWorld];
    //NSLog(@"touch ended");
    //NSLog(@"btm Touch Count %i", BtmTouchCount);
    if (touchLocation.y <SH/2) {
        BtmTouchCount--;
    }
}

// -------------------------------------------------------------------------------
#pragma mark line moving

- (void) moveThisLine: (CCNode*)LineMover thisFar: (int)dDist {
        if (LineMover == _Middle) {
            //CCActionWithDuration
           // [_Middle stopAllActions];
            //[_Middle runAction:[CCActionMoveTo actionWithDuration:.1 position:ccp (_Middle.positionInPoints.x, _Middle.positionInPoints.y + dDist)]];
            
            _Middle.positionInPoints = ccp (_Middle.positionInPoints.x, _Middle.positionInPoints.y + dDist);
            
            [self victoryCheck: LineMover];
            // [self hitmarked: _Middle indicator: dDist];
        }
        
        if (LineMover == _Right) {
            _Right.positionInPoints = ccp (_Right.positionInPoints.x, _Right.positionInPoints.y + dDist);
            [self victoryCheck: LineMover];
            //[self hitmarked: _Right indicator: dDist];
            
        }
        
        if (LineMover == _Left) {
            _Left.positionInPoints = ccp (_Left.positionInPoints.x, _Left.positionInPoints.y + dDist);
            [self victoryCheck: LineMover];
            //[self hitmarked: _Left indicator: dDist];
        }
}

// -------------------------------------------------------------------------------
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
 //}
 */

// -------------------------------------------------------------------------------
#pragma mark Pause button

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
    //NSLog(@"SOMETHING HAPPENED!!!!!    %d", windication.positionInPoints.y < 0);
    if (windication.positionInPoints.y < 0) {
        [GameState sharedInstance].wInteger = 2;
        CCScene *gameOver = [CCBReader loadAsScene:@"OnePlayerGameOver"];
        [[CCDirector sharedDirector] replaceScene:gameOver];
    }
}

    


@end
