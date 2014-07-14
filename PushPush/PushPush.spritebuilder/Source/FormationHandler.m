//
//  FormationHandler.m
//  PushPush
//
//  Created by Luke Solomon on 7/10/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "FormationHandler.h"

@implementation FormationHandler



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
 */



- (void) rightPush {
    
}




@end
