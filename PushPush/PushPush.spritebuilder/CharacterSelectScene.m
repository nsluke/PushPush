//
//  CharacterSelectScene.m
//  PushPush
//
//  Created by Luke Solomon on 7/21/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CharacterSelectScene.h"
#import "GameState.h"

@implementation CharacterSelectScene {
    
    CCNodeColor *p1Node;
    CCNodeColor *p2Node;
    
    CCNodeGradient *backgroundGradient;
    
    int toggle;

    CCColor *black1;
    CCColor *violet1;
    CCColor *indigo1;
    CCColor *blue1;
    CCColor *green1;
    CCColor *yellow1;
    CCColor *orange1;
    CCColor *red1;
    CCColor *white1;

    CCLabelTTF *pickLabel1;
    CCLabelTTF *pickLabel2;

}

- (id) init {
    self = [super init];
    if (self) {
    }
    return self;
}


// --------------------------------------------------------------------------------------------------------

- (void) didLoadFromCCB {
    //allow touches
    self.userInteractionEnabled = TRUE;
    
    //notifies the scene has loaded
    CCLOG(@"Scene Loaded");
    
    //set the toggle to 1
    toggle = 1;
    
    //initialize the colors
    black1  = [CCColor colorWithRed:000.0f/255.0f green:000.0f/255.0f blue:000.0f/255.0f alpha:1.0f];
    violet1 = [CCColor colorWithRed:155.0f/255.0f green:048.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    indigo1 = [CCColor colorWithRed:000.0f/255.0f green:000.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    blue1   = [CCColor colorWithRed:000.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    green1  = [CCColor colorWithRed:000.0f/255.0f green:255.0f/255.0f blue:000.0f/255.0f alpha:1.0f];
    yellow1 = [CCColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:000.0f/255.0f alpha:1.0f];
    orange1 = [CCColor colorWithRed:255.0f/255.0f green:165.0f/255.0f blue:000.0f/255.0f alpha:1.0f];
    red1    = [CCColor colorWithRed:255.0f/255.0f green:000.0f/255.0f blue:000.0f/255.0f alpha:1.0f];
    white1  = [CCColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
}

// --------------------------------------------------------------------------------------------------------
// These are the methods that control the color selection screen. They all pass the setColor method a parameter

- (void) white {
    [self setColor :white1];
}

- (void) Red {
    [self setColor :red1];
}

- (void) Orange {
    [self setColor :orange1];

}

- (void) Yellow {
    [self setColor :yellow1];
}
 
- (void) Green {
    [self setColor :green1];
}

- (void) Blue {
    [self setColor :blue1];
}

- (void) Indigo {
    [self setColor :indigo1];
}

- (void) Violet {
    [self setColor :violet1];
}

- (void) Black {
    [self setColor :black1];
}


// --------------------------------------------------------------------------------------------------------


- (void) setColor:(CCColor *)theColor {
    
    [self arePlayersSameColor];
    
    if (toggle == 1){
        [p1Node setColor: theColor];
        [backgroundGradient setEndColor: theColor];
        
        //if ([self arePlayersSameColor]){
        [GameState sharedInstance].p1Color = theColor;
        //}
        
        
    } else if (toggle == 2){
        [p2Node setColor: theColor];
        [backgroundGradient setStartColor: theColor];
        
        //if ([self arePlayersSameColor]){
        [GameState sharedInstance].p2Color = theColor;
        //}
        
    }
    [self PlayerSelect];
    
}


// --------------------------------------------------------------------------------------------------------
- (void) PlayerSelect {
    
    if ([self arePlayersSameColor] == false){

        if (toggle == 1) {
            
            pickLabel1.string = @"";
            pickLabel2.string = @"PICK A COLOR";
            toggle = 2;
            
            NSLog(@"toggle is now %d", toggle);
            
        } else if (toggle == 2) {
            
            pickLabel1.string = @"PICK A COLOR";
            pickLabel2.string = @"";
            toggle = 1;
            
            NSLog(@"toggle is now %d", toggle);
            
        }
    }
}


// --------------------------------------------------------------------------------------------------------
- (BOOL) arePlayersSameColor {
    if ([GameState sharedInstance].p2Color == [GameState sharedInstance].p1Color) {
        pickLabel1.string = @"YOU CAN'T BOTH BE THE SAME COLOR!";
        pickLabel2.string = @"YOU CAN'T BOTH BE THE SAME COLOR!";
        return true;
    }
    return false;
}

- (void) Ready {
    CCScene *endlessScene = [CCBReader loadAsScene:@"EndlessScene"];
    [[CCDirector sharedDirector] replaceScene:endlessScene];
}


@end
