//
//  ArcadeScene.m
//  PushPush
//
//  Created by Luke Solomon on 7/11/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "ArcadeScene.h"
#import "FormationHandler.h"

@implementation ArcadeScene{
    
    CCNodeColor *TopLeftLine;
    CCNodeColor *TopMidLine;
    CCNodeColor *TopRightLine;
    CCNodeColor *BottomLeftLine;
    CCNodeColor *BottomMidLine;
    CCNodeColor *BottomRightLine;
    
    CCButton *rightPush;
    CCButton *leftPush;
    
    CCParticleSystem *hitMarkL;
    
    int yVal;
    int pushaT;
    
    FormationHandler *BottomHandler;
    FormationHandler *TopHandler;
    
#define SW [[CCDirector sharedDirector] viewSize].width
#define SH [[CCDirector sharedDirector] viewSize].height

}




- (void) didLoadFromCCB {
    
    yVal = 5;
    
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
        CCLOG(@"push detected");

        [self leftPush];
        

    }
    
    
    else if (touchLocation.x>SW/2 && touchLocation.y<SH/2){
        //bottom right quadrant
        [self rightPush];
        
        CCLOG(@"push detected");

    }
    
    
    else if (touchLocation.x<SW/2 && touchLocation.y>SH/2){
        //top left quadrant
        [self topLeftPush];
        
        CCLOG(@"push detected");

    }

   
    else if (touchLocation.x>SW/2 && touchLocation.y>SH/2){
         //top right quadrant
        [self topRightPush];
        
        CCLOG(@"push detected");

    }
    
}








// --------------------------------------------------------------------------------------------------------
#pragma mark Push Buttons
- (void) leftPush {
    
    //CCLOG(@"leftPush button pressed");
    
    [leftPush.parent addChild:hitMarkL];
    
//    if (pushaT == 1) {
//        pushaT = 0;
        [self moveBottomLine:yVal];

}

- (void) rightPush {
    
    //CCLOG(@"rightPush button pressed");
    
//    if (pushaT == 0) {
//        pushaT = 1;
        [self moveBottomLine:yVal];
    
}

-(void) topRightPush {
    
    //CCLOG(@"topRightPush button pressed");
    
    //    if (pushaT == 0) {
    //        pushaT = 1;
    [self moveTopLine:yVal];
}

-(void) topLeftPush {
    
    //CCLOG(@"topLeftPush button pressed");
    
    //    if (pushaT == 0) {
    //        pushaT = 1;
    [self moveTopLine:yVal];
    
}

// --------------------------------------------------------------------------------------------------------
#pragma mark moving the lines

- (void) moveBottomLine: (int) dDist {
    
    //Move the top and bottom lines at the same time.
    BottomMidLine.positionInPoints = ccp(BottomMidLine.positionInPoints.x, BottomMidLine.positionInPoints.y + dDist);
    TopMidLine.positionInPoints = ccp(TopMidLine.positionInPoints.x, TopMidLine.positionInPoints.y + dDist);
    
    BottomRightLine.positionInPoints = ccp(BottomRightLine.positionInPoints.x, BottomRightLine.positionInPoints.y + dDist);
    TopRightLine.positionInPoints = ccp(TopRightLine.positionInPoints.x, TopRightLine.positionInPoints.y + dDist);
    
    BottomLeftLine.positionInPoints = ccp(BottomLeftLine.positionInPoints.x, BottomLeftLine.positionInPoints.y + dDist);
    TopLeftLine.positionInPoints = ccp(TopLeftLine.positionInPoints.x, TopLeftLine.positionInPoints.y + dDist);

    //NSLog(@"The bottom line should be moving");
    
    //hitMarkL = (CCParticleSystem *)[CCBReader load:@"hitMarker"];
    //NSLog(@"hitmark");
}

- (void) moveTopLine: (int) dDist {
    
    TopMidLine.positionInPoints = ccp(TopMidLine.positionInPoints.x, TopMidLine.positionInPoints.y - dDist);
    BottomMidLine.positionInPoints = ccp(BottomMidLine.positionInPoints.x, BottomMidLine.positionInPoints.y - dDist);
    
    TopRightLine.positionInPoints = ccp(TopRightLine.positionInPoints.x, TopRightLine.positionInPoints.y - dDist);
    BottomRightLine.positionInPoints = ccp(BottomRightLine.positionInPoints.x, BottomRightLine.positionInPoints.y - dDist);
    
    TopLeftLine.positionInPoints = ccp(TopLeftLine.positionInPoints.x, TopLeftLine.positionInPoints.y - dDist);
    BottomLeftLine.positionInPoints = ccp(BottomLeftLine.positionInPoints.x, BottomLeftLine.positionInPoints.y - dDist);
    
    //NSLog(@"The top line should be moving");
    
    //hitMarkL = (CCParticleSystem *)[CCBReader load:@"hitMarker"];
    //NSLog(@"hitmark");
}

 // --------------------------------------------------------------------------------------------------------
 #pragma mark Swiping
 
 - (void) rightSwipe {
    CCLOG(@"player swiped right");
    [BottomHandler rightPush];
 }
 
 - (void) leftSwipe {
    CCLOG(@"player swiped left");
 }
 
 - (void) doubleUpSwipe {
     CCLOG(@"player double swiped up");
 }
 
 - (void) doubleLeftRightSwipe {
     CCLOG(@"player doubleLeftRightSwipe");
 
 //
 }
 
 - (void) downSwipe {
     CCLOG(@"player swiped down");
 
 //
 }
 
// --------------------------------------------------------------------------------------------------------
#pragma mark Pause button

- (void) pause {
    CCLOG(@"pause");
    
    //[BottomHandler rightPush];
    
}
 
@end
