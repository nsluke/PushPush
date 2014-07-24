//
//  CharacterSelectScene.m
//  PushPush
//
//  Created by Luke Solomon on 7/21/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CharacterSelectScene.h"

@implementation CharacterSelectScene {
    
    CCNodeColor *p1Node;
    CCNodeColor *p2Node;
    
    CCNodeGradient *backgroundGradient;
}

- (id) init {
    self = [super init];
    if (self) {
        
    }
    return self;
}



- (void) didLoadFromCCB {
    
    self.userInteractionEnabled = TRUE;
    CCLOG(@"Scene Loaded");

}

- (void) play {
    //[p1Node setColor: [CCColor colorWithRed:66.0f/255.0f green:79.0f/255.0f blue:91.0f/255.0f alpha:1.0f] ];
    
    CCLOG(@"White Button Pressed");
    
//    backgroundGradient.endColor = #000000;
    
}

/*
- (void) Black {
    
    [p1Node setColor: [CCColor colorWithRed:255.0f/255.0f
                                      green:255.0f/255.0f
                                       blue:255.0f/255.0f
                                      alpha:1.0f] ];
}

- (void) Red {
    [p1Node setColor: [CCColor colorWithRed:255.0f/255.0f
                                     green:0.0f/255.0f
                                      blue:0.0f/255.0f
                                     alpha:1.0f] ];
}

- (void) Blue {
    [p1Node setColor: [CCColor colorWithRed:0.0f/255.0f
                                      green:0.0f/255.0f
                                       blue:255.0f/255.0f
                                      alpha:1.0f] ];
}

- (void) Yellow {
    [p1Node setColor: [CCColor colorWithRed:0.0f/255.0f
                                      green:150.0f/255.0f
                                       blue:155.0f/255.0f
                                      alpha:1.0f] ];
}

- (void) Green {
    [p1Node setColor: [CCColor colorWithRed:0.0f/255.0f
                                      green:255.0f/255.0f
                                       blue:0.0f/255.0f
                                      alpha:1.0f] ];
}
*/


@end
