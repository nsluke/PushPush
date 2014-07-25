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

- (void) white {
    [p1Node setColor: [CCColor colorWithRed:255.0f/255.0f
                                      green:255.0f/255.0f
                                       blue:255.0f/255.0f
                                      alpha:1.0f] ];
    
    [backgroundGradient setEndColor: [CCColor colorWithRed:255.0f/255.0f
                                                    green:255.0f/255.0f
                                                     blue:255.0f/255.0f
                                                    alpha:1.0f] ];
    /*
    [backgroundGradient setStartColor: [CCColor colorWithRed:0.0f/255.0f
                                                  green:0.0f/255.0f
                                                   blue:255.0f/255.0f
                                                  alpha:1.0f] ];
     */
}

- (void) Red {
    [p1Node setColor: [CCColor colorWithRed:255.0f/255.0f
                                     green:0.0f/255.0f
                                      blue:0.0f/255.0f
                                     alpha:1.0f] ];
    
    [backgroundGradient setEndColor: [CCColor colorWithRed:255.0f/255.0f
                                                    green:0.0f/255.0f
                                                     blue:0.0f/255.0f
                                                    alpha:1.0f] ];
}

- (void) Orange {
    [p1Node setColor: [CCColor colorWithRed:255.0f/255.0f
                                      green:165.0f/255.0f
                                       blue:0.0f/255.0f
                                      alpha:1.0f] ];
    
    [backgroundGradient setEndColor: [CCColor colorWithRed:255.0f/255.0f
                                                     green:165.0f/255.0f
                                                      blue:0.0f/255.0f
                                                     alpha:1.0f] ];
}

- (void) Yellow {
    [p1Node setColor: [CCColor colorWithRed:255.0f/255.0f
                                      green:255.0f/255.0f
                                       blue:0.0f/255.0f
                                      alpha:1.0f] ];
    
    [backgroundGradient setEndColor: [CCColor colorWithRed:255.0f/255.0f
                                                     green:255.0f/255.0f
                                                      blue:0.0f/255.0f
                                                     alpha:1.0f] ];
}

- (void) Green {
    [p1Node setColor: [CCColor colorWithRed:0.0f/255.0f
                                      green:255.0f/255.0f
                                       blue:0.0f/255.0f
                                      alpha:1.0f] ];
    
    [backgroundGradient setEndColor: [CCColor colorWithRed:0.0f/255.0f
                                                     green:255.0f/255.0f
                                                      blue:0.0f/255.0f
                                                     alpha:1.0f] ];
}


- (void) Blue {
    [p1Node setColor: [CCColor colorWithRed:0.0f/255.0f
                                      green:255.0f/255.0f
                                       blue:255.0f/255.0f
                                      alpha:1.0f] ];
    
    [backgroundGradient setEndColor: [CCColor colorWithRed:0.0f/255.0f
                                                    green:255.0f/255.0f
                                                     blue:255.0f/255.0f
                                                    alpha:1.0f] ];
}

- (void) Indigo {
    
    [p1Node setColor: [CCColor colorWithRed:0.0f/255.0f
                                      green:0.0f/255.0f
                                       blue:255.0f/255.0f
                                      alpha:1.0f] ];
    
    [backgroundGradient setEndColor: [CCColor colorWithRed:0.0f/255.0f
                                                     green:0.0f/255.0f
                                                      blue:255.0f/255.0f
                                                     alpha:1.0f] ];
}

- (void) Violet {
    
    [p1Node setColor: [CCColor colorWithRed:155.0f/255.0f
                                      green:48.0f/255.0f
                                       blue:255.0f/255.0f
                                      alpha:1.0f] ];
    
    [backgroundGradient setEndColor: [CCColor colorWithRed:155.0f/255.0f
                                                     green:48.0f/255.0f
                                                      blue:255.0f/255.0f
                                                     alpha:1.0f] ];
}


- (void) Black {
    
    [p1Node setColor: [CCColor colorWithRed:0.0f/255.0f
                                      green:0.0f/255.0f
                                       blue:0.0f/255.0f
                                      alpha:1.0f] ];
    
    [backgroundGradient setEndColor: [CCColor colorWithRed:0.0f/255.0f
                                                     green:0.0f/255.0f
                                                      blue:0.0f/255.0f
                                                     alpha:1.0f] ];
}

- (void) Ready {
    
    CCScene *endlessScene = [CCBReader loadAsScene:@"EndlessScene"];
    [[CCDirector sharedDirector] replaceScene:endlessScene];
    
}


@end
