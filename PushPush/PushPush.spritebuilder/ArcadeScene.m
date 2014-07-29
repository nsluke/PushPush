//
//  ArcadeScene.m
//  PushPush
//
//  Created by Luke Solomon on 7/11/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "ArcadeScene.h"

@implementation ArcadeScene {
    
    CCNodeColor *TopLeftLine;
    CCNodeColor *TopMidLine;
    CCNodeColor *TopRightLine;
    CCNodeColor *BottomLeftLine;
    CCNodeColor *BottomMidLine;
    CCNodeColor *BottomRightLine;
    
    CCNodeGradient *MWD;
    CCNodeGradient *RWD;
    CCNodeGradient *LWD;
    
    CCButton *rightPush;
    CCButton *leftPush;
    
    int yVal;
    int pushaT;
    
#define SW [[CCDirector sharedDirector] viewSize].width
#define SH [[CCDirector sharedDirector] viewSize].height

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

    //NSArray *touchArray = [touch allObjects];
    
    
    CGPoint touchLocation = [touch locationInWorld];
    
    
    if (touchLocation.x<SW/2 && touchLocation.y<SH/2){
        //bottom left quadrant
        [self moveBottomLine:yVal];
    }
    else if (touchLocation.x>SW/2 && touchLocation.y<SH/2){
        //bottom right quadrant
        [self moveBottomLine:yVal];
    }
    else if (touchLocation.x<SW/2 && touchLocation.y>SH/2){
        //top left quadrant
        [self moveTopLine:yVal];
    }
    else if (touchLocation.x>SW/2 && touchLocation.y>SH/2){
         //top right quadrant
        [self moveTopLine:yVal];
    }
    
    //CCLOG(@"%n" (MWD.positionInPoints.y));
    
    //probably not the right place for this, but....

    
}

// --------------------------------------------------------------------------------------------------------
#pragma mark moving the lines

- (void) moveBottomLine: (int) dDist {
    
    //Middle Lines
    BottomMidLine.positionInPoints = ccp(BottomMidLine.positionInPoints.x, BottomMidLine.positionInPoints.y + dDist);
    TopMidLine.positionInPoints = ccp(TopMidLine.positionInPoints.x, TopMidLine.positionInPoints.y + dDist);
    
    //Right Lines
    BottomRightLine.positionInPoints = ccp(BottomRightLine.positionInPoints.x, BottomRightLine.positionInPoints.y + dDist);
    TopRightLine.positionInPoints = ccp(TopRightLine.positionInPoints.x, TopRightLine.positionInPoints.y + dDist);
    
    //Left Lines
    BottomLeftLine.positionInPoints = ccp(BottomLeftLine.positionInPoints.x, BottomLeftLine.positionInPoints.y + dDist);
    TopLeftLine.positionInPoints = ccp(TopLeftLine.positionInPoints.x, TopLeftLine.positionInPoints.y + dDist);

    //Move the Windicators
    MWD.positionInPoints = ccp(MWD.positionInPoints.x, MWD.positionInPoints.y + dDist);
    LWD.positionInPoints = ccp(LWD.positionInPoints.x, LWD.positionInPoints.y + dDist);
    RWD.positionInPoints = ccp(RWD.positionInPoints.x, RWD.positionInPoints.y + dDist);
    
    if (MWD.positionInPoints.y > SH || LWD.positionInPoints.y > SH || RWD.positionInPoints.y > SH){
        
        [self pause];
    }
    
    [self hitmarked];

}

- (void) moveTopLine: (int) dDist {
    
    //Middle Lines
    TopMidLine.positionInPoints = ccp(TopMidLine.positionInPoints.x, TopMidLine.positionInPoints.y - dDist);
    BottomMidLine.positionInPoints = ccp(BottomMidLine.positionInPoints.x, BottomMidLine.positionInPoints.y - dDist);
    
    //Right Lines
    TopRightLine.positionInPoints = ccp(TopRightLine.positionInPoints.x, TopRightLine.positionInPoints.y - dDist);
    BottomRightLine.positionInPoints = ccp(BottomRightLine.positionInPoints.x, BottomRightLine.positionInPoints.y - dDist);
    
    //Left Lines
    TopLeftLine.positionInPoints = ccp(TopLeftLine.positionInPoints.x, TopLeftLine.positionInPoints.y - dDist);
    BottomLeftLine.positionInPoints = ccp(BottomLeftLine.positionInPoints.x, BottomLeftLine.positionInPoints.y - dDist);
    
    //Move the Windicators
    MWD.positionInPoints = ccp(MWD.positionInPoints.x, MWD.positionInPoints.y - dDist);
    LWD.positionInPoints = ccp(LWD.positionInPoints.x, LWD.positionInPoints.y - dDist);
    RWD.positionInPoints = ccp(RWD.positionInPoints.x, RWD.positionInPoints.y - dDist);



    if (MWD.positionInPoints.y < 0 || LWD.positionInPoints.y < 0 || RWD.positionInPoints.y < 0){
        [self pause];
    }
    
    [self hitmarked];
}


- (void) hitmarked {
    // load particle effect
    CCParticleSystem *hitMark = (CCParticleSystem *)[CCBReader load:@"hitMarkMiddle"];
    
    // make the particle effect clean itself up, once it is completed
    hitMark.autoRemoveOnFinish = TRUE;
    
    // place the particle effect on the seals position
    hitMark.position = MWD.position;
    
    // add the particle effect to the same node the seal is on
    [MWD.parent addChild:hitMark];
    
}


 // --------------------------------------------------------------------------------------------------------





// --------------------------------------------------------------------------------------------------------
#pragma mark Pause button

- (void) pause {
    CCLOG(@"pause");
    
    CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
    
}
 
@end
