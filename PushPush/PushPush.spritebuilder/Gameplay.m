//
//  Gameplay.m
//  PushPush
//
//  Created by Luke Solomon on 7/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"

@implementation Gameplay

/**
 Five formations will be designed
 
 --right push--
 right lane gets +2
 middle lane gets +0
 left lane gets -1
 *RIGHT SWIPE*
 /\/\ - \/
 
 --left push--
 right lane gets -1
 middle lane gets +0
 left lane gets +2
 *LEFT SWIPE*
 \/ - //\\
 
 --middle push--
 right lane gets -1
 middle lane gets +3
 left lane gets -1
 *TWO FINGER SWIPE or TWO FORWARD SWIPES*
 \/ /\/\/\ \/
 
 --left & right push--
 right lane gets +1.5
 middle lane gets -2
 left lane gets +1.5
 **
 /\  \/\/ /\
 
 --flat--
 right lane gets +.3
 middle lane gets +.3
 left lane gets +.3
 
 /\ /\ /\
 
 */


- (void) didLoadFromCCB {
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    
    //CCScene *level = [CCBReader loadAsScene:@"Levels/Level1"];
    
    
}

- (void) leftPush {
    CCLOG(@"leftPush button pressed");
    
    
    //register one push
    
    
}

- (void) rightPush {
    CCLOG(@"rightPush button pressed");
    
    //register one push
}





@end
