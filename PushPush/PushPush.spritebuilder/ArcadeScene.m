//
//  ArcadeScene.m
//  PushPush
//
//  Created by Luke Solomon on 7/11/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "ArcadeScene.h"

@implementation ArcadeScene

int pushaT;



/*
 Five formations will be designed
 
 --right push--
 right lane gets +2
 middle lane gets +0
 left lane gets -1
 *RIGHT SWIPE*
 /\/\ - \/
 --------------
 
 --left push--
 right lane gets -1
 middle lane gets +0
 left lane gets +2
 *LEFT SWIPE*
 \/ - //\\
 --------------
 
 --middle push--
 right lane gets -1
 middle lane gets +3
 left lane gets -1
 *TWO FINGER SWIPE UP or TWO FORWARD SWIPES*
 \/ /\/\/\ \/
 --------------
 
 --left & right push--
 right lane gets +1.5
 middle lane gets -2
 left lane gets +1.5
 *TWO FINGER SWIPE LEFT AND RIGHT*
 /\  \/\/ /\
 --------------
 
 --flat--
 right lane gets +.3333
 middle lane gets +.3333
 left lane gets +.3333
 *SWIPE DOWN*
 /\ /\ /\
 --------------
 
 
 
 --------------------
 6 instance variables. 1 for each line
 line 1 - BtmL
 line 2 - BtmM
 line 3 - BtmR
 line 4 - TopL
 line 5 - TopM
 
 
 */


- (void) didLoadFromCCB {
    // tell this scene to accept touches
    //self.userInteractionEnabled = TRUE;
    
    //CCScene *level = [CCBReader loadAsScene:@"Levels/Level1"];
    
    
}



// --------------------------------------------------------------------------------------------------------
//#pragma mark Push Buttons



- (void) leftPush {
    
    CCLOG(@"leftPush button pressed");
    
    if (pushaT == 1) {
        pushaT = 0;
        
        
    } else {
        CCLOG(@"Can't push the left button twice!");
    }


    
    
}

- (void) rightPush {
    //runs a check to make sure that the same button has not been pushed twice
    
    CCLOG(@"rightPush button pressed");
    
    if (pushaT == 0) {
        pushaT = 1;
    } else {
        CCLOG(@"Can't push the right button twice!");
    }
        

    
}




/**
 // --------------------------------------------------------------------------------------------------------
 #pragma mark Swiping
 
 - (void) rightSwipe {
 CCLOG(@"player swiped right");
 
 
 }
 
 - (void) leftSwipe {
 CCLOG(@"player swiped left");
 
 
 }
 
 - (void) doubleUpSwipe {
 CCLOG(@"player double swiped up");
 
 //
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
 #pragma mark Push Buttons
 */
@end
