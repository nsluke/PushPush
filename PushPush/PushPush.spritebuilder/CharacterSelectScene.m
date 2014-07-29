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

    

}

- (id) init {
    self = [super init];
    if (self) {
    }
    return self;
}



- (void) didLoadFromCCB {
    //allow touches
    self.userInteractionEnabled = TRUE;
    
    //notifies the scene has loaded
    CCLOG(@"Scene Loaded");
    
    //set the toggle to 1
    toggle = 1;
    
    //initialize the colors
    black1 = [CCColor colorWithRed:0.0f/255.0f
                                      green:0.0f/255.0f
                                       blue:0.0f/255.0f
                                      alpha:1.0f];
    violet1 = [CCColor colorWithRed:155.0f/255.0f
                                       green:48.0f/255.0f
                                        blue:255.0f/255.0f
                                       alpha:1.0f];
    indigo1 = [CCColor colorWithRed:0.0f/255.0f
                                       green:0.0f/255.0f
                                        blue:255.0f/255.0f
                                       alpha:1.0f];
    blue1 = [CCColor colorWithRed:0.0f/255.0f
                                     green:255.0f/255.0f
                                      blue:255.0f/255.0f
                                     alpha:1.0f];
    green1 = [CCColor colorWithRed:0.0f/255.0f
                                      green:255.0f/255.0f
                                       blue:0.0f/255.0f
                                      alpha:1.0f];
    yellow1 = [CCColor colorWithRed:255.0f/255.0f
                                       green:255.0f/255.0f
                                        blue:0.0f/255.0f
                                       alpha:1.0f];
    orange1 = [CCColor colorWithRed:255.0f/255.0f
                                       green:165.0f/255.0f
                                        blue:0.0f/255.0f
                                       alpha:1.0f];
    red1 = [CCColor colorWithRed:255.0f/255.0f
                                    green:0.0f/255.0f
                                     blue:0.0f/255.0f
                                    alpha:1.0f];
    white1 = [CCColor colorWithRed:255.0f/255.0f
                                      green:255.0f/255.0f
                                       blue:255.0f/255.0f
                                      alpha:1.0f];
}

- (void) white {
    if (toggle == 1){
        [p1Node setColor: white1];
        [backgroundGradient setEndColor: white1];
        
        [GameState sharedInstance].p1Color = white1;
        
    } else if (toggle == 2){
        [p2Node setColor: white1];
        [backgroundGradient setStartColor: white1];
        
        [GameState sharedInstance].p2Color = white1;
    }
    [self PlayerSelect];
}

- (void) Red {
    if (toggle == 1){
        [p1Node setColor: red1];
        [backgroundGradient setEndColor: red1];
        
        [GameState sharedInstance].p1Color = red1;
        
    } else if (toggle == 2){
        [p2Node setColor: red1];
        [backgroundGradient setStartColor: red1];
        
        [GameState sharedInstance].p2Color = red1;
    }
    [self PlayerSelect];
}

- (void) Orange {
    if (toggle == 1){
        [p1Node setColor: orange1];
        [backgroundGradient setEndColor: orange1];
        
        [GameState sharedInstance].p1Color = orange1;
        
    } else if (toggle == 2){
        [p2Node setColor: orange1];
        [backgroundGradient setStartColor: orange1];
        
        [GameState sharedInstance].p2Color = orange1;
    }
    [self PlayerSelect];

}

- (void) Yellow {
    if (toggle == 1){
        [p1Node setColor: yellow1];
        [backgroundGradient setEndColor: yellow1];
        
        [GameState sharedInstance].p1Color = yellow1;
        
    } else if (toggle == 2){
        [p2Node setColor: yellow1];
        [backgroundGradient setStartColor: yellow1];
        
        [GameState sharedInstance].p2Color = yellow1;
        
    }
    [self PlayerSelect];
}

- (void) Green {
    if (toggle == 1){
        [p1Node setColor: green1];
        [backgroundGradient setEndColor: green1];
        
        [GameState sharedInstance].p1Color = green1;
        
    } else if (toggle == 2){
        [p2Node setColor: green1];
        [backgroundGradient setStartColor: green1];
        
        [GameState sharedInstance].p2Color = green1;
        
    }
    [self PlayerSelect];
}


- (void) Blue {
    if (toggle == 1){
        [p1Node setColor: blue1];
        [backgroundGradient setEndColor: blue1];
        
        [GameState sharedInstance].p1Color = blue1;
        
    } else if (toggle == 2){
        [p2Node setColor: blue1];
        [backgroundGradient setStartColor: blue1];
        
        [GameState sharedInstance].p2Color = blue1;
        
    }
    [self PlayerSelect];
}

- (void) Indigo {
    if (toggle == 1){
        [p1Node setColor: indigo1];
        [backgroundGradient setEndColor: indigo1];
        
        [GameState sharedInstance].p1Color = indigo1;
        
    } else if (toggle == 2){
        [p2Node setColor: indigo1];
        [backgroundGradient setStartColor: indigo1];
        
        [GameState sharedInstance].p2Color = indigo1;
        
    }
    [self PlayerSelect];
}

- (void) Violet {
    if (toggle == 1){
        [p1Node setColor: violet1];
        [backgroundGradient setEndColor: violet1];
        
        [GameState sharedInstance].p1Color = violet1;
        
    } else if (toggle == 2){
        [p2Node setColor: violet1];
        [backgroundGradient setStartColor: violet1];
        
        [GameState sharedInstance].p2Color = violet1;
        
    }
    [self PlayerSelect];
}


- (void) Black {
    if (toggle == 1){
        [p1Node setColor: black1];
        [backgroundGradient setEndColor: black1];
        
        [GameState sharedInstance].p1Color = black1;
        
    } else if (toggle == 2){
        [p2Node setColor: black1];
        [backgroundGradient setStartColor: black1];
        
        [GameState sharedInstance].p2Color = black1;
        
    }
    [self PlayerSelect];
}

- (void) PlayerSelect {
    
    if (toggle == 1) {
        
        toggle = 2;
        NSLog(@"toggle is now %d", toggle);
        
    } else if (toggle == 2) {
        
        toggle = 1;
        NSLog(@"toggle is now %d", toggle);


    }
    
    
}


- (void) Ready {
    
    CCScene *endlessScene = [CCBReader loadAsScene:@"EndlessScene"];
    [[CCDirector sharedDirector] replaceScene:endlessScene];
    
}


@end
